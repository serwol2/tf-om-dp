resource "aws_ecs_cluster" "om-web-cluster" {
  name               = var.cluster_name
  capacity_providers = [aws_ecs_capacity_provider.om-provider.name]
  tags = {
    "env"       = "om-cluster"
    "Name"      = "om-cluster"
    #"createdBy" = "mkerimova"
  }
}

resource "aws_ecs_capacity_provider" "om-provider" {
  name = "om-capacity-provider"
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 90
    }
  }
}

# update file container-def, so it's pulling image from ecr
resource "aws_ecs_task_definition" "om-task-definition" {
  family                = "web-family"
  container_definitions = file("container-definitions/container-def.json")
  network_mode          = "bridge"
  tags = {
    "env"       = "om-task"
    "Name"      = "om-task"
    # "createdBy" = "mkerimova"
  }
}

resource "aws_ecs_service" "service" {
  name            = "web-service"
  cluster         = aws_ecs_cluster.om-web-cluster.id
  task_definition = aws_ecs_task_definition.om-task-definition.arn
  desired_count   = 2 #10
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn   
    container_name   = "openmeetings"
    container_port   = 5443
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web-listener]
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/frontend-container"
  tags = {
    "env"       = "om"
    "Name"      = "om"
    #"createdBy" = "mkerimova"
  }
}