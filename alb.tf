resource "aws_lb" "om-lb" {
  name               = "om-ecs-lb"
  load_balancer_type = "application"
  internal           = false
  subnets            = module.vpc.public_subnets
  tags = {
    "env"       = "om"
    #"createdBy" = "mkerimova"
  }
  security_groups = [aws_security_group.lb.id]
}

resource "aws_security_group" "lb" {
  name   = "allow-all-lb"
  vpc_id = data.aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "env"       = "om"
    "Name"      = "om-lb"
    #"createdBy" = "mkerimova"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "om-target-group"
  port        = "5443"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.om-lb.arn
  port              = "5443"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    # ssl_policy        = "ELBSecurityPolicy-2016-08"
    # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}