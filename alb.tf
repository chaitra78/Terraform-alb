
# Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = [
    aws_subnet.public1.id,
    aws_subnet.public2.id,
    aws_subnet.public3.id
]

  enable_deletion_protection = false

  tags = {
    Name = "app-alb"
  }
}

# Target Group for Path /home
resource "aws_lb_target_group" "Home_tg" {
  name     = "app1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    matcher             = "200-399"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "Images_tg" {
  name     = "app2-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    matcher             = "200-399"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "Register_tg" {
  name     = "app3-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
   enabled             = true
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    matcher             = "200-399"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

#-------------ALB Listener and Rule Resources-------


resource "aws_lb_listener" "http_listener_home" {
  load_balancer_arn = aws_lb.app_alb
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Home_tg.arn
  }
}


resource "aws_lb_listener_rule" "path_based_routing_images" {
  listener_arn = aws_lb_listener.http_listener_home.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Images_tg.arn
  }

  condition {
    path_pattern {
      values = ["/images/*"]
    }
  }
}

  resource "aws_lb_listener_rule" "path_based_routing_register" {
  listener_arn = aws_lb_listener.http_listener_home.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Register_tg.arn
  }

  condition {
    path_pattern {
      values = ["/register/*"]
    }
  }
  }



#---Target group Attachement------------------#
resource "aws_lb_target_group_attachment" "app1_attach_home" {
  target_group_arn = aws_lb_target_group.Home_tg.arn
  target_id        = aws_instance.app1.id
  }

  resource "aws_lb_target_group_attachment" "app2_attach_images" {
  target_group_arn = aws_lb_target_group.Images_tg.arn
  target_id        = aws_instance.app2.id
  }

  resource "aws_lb_target_group_attachment" "app3_attach_register" {
  target_group_arn = aws_lb_target_group.Register_tg.arn
  target_id        = aws_instance.app3.id
  }



