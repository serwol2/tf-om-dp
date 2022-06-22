resource "aws_instance" "for-curento-om-test" { 
  ami             = "ami-0c4f7023847b90238"
  instance_type   = "t2.micro"
  key_name        = "mykeypairsergey"
  associate_public_ip_address = false
  vpc_security_group_ids = [ "${aws_security_group.ec2-sg.id}" ]
  subnet_id       = "${tolist(module.vpc.public_subnets)[0]}"
  private_ip      = "10.0.1.15"
  user_data       = <<EOF
#!/bin/bash
sudo apt update && sudo apt install -y docker.io
sudo docker run -d --name kms -p 8888:8888 kurento/kurento-media-server:latest
EOF
  tags = {
    Name = "for-curento-om-test"
  }

}
