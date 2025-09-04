
# Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "app-alb"
  }
}
