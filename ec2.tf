#1. User Data Script to Install Nginx
data "template_file" "nginx_user_data" {
  template = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              echo "<h1>HomePage!</h1>" > /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
            EOF
}

#2. EC2 Instance
resource "aws_instance" "app1" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu AMI (update as needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1.id
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = data.template_file.nginx_user_data.rendered

  tags = {
    Name = "App1-Instance"
  }
}

#3. Target Group for Path /app1
resource "aws_lb_target_group" "app1_tg" {
  name     = "app1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

#4. Attach EC2 to Target Group
resource "aws_lb_target_group_attachment" "app1_attach" {
  target_group_arn = aws_lb_target_group.app1_tg.arn
  target_id        = aws_instance.app1.id
  port             = 80
}


#5. Listener Rule for Path-Based Routing
resource "aws_lb_listener_rule" "app1_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app1_tg.arn
  }

  condition {
    path_pattern {
      values = ["/app1*"]
    }
  }
}
