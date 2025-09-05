#1. User Data Script to Install Nginx
data "template_file1" "nginx_user_data" {
  template = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              echo "<h1>HomePage!</h1>" > /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
            EOF
}

data "template_file2" "nginx_user_data" {
  template = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              echo "<h1>Images !</h1>" > /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
            EOF
}


data "template_file3" "nginx_user_data" {
  template = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              echo "<h1>Register !</h1>" > /var/www/html/index.html
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

  user_data = data.template_file1.nginx_user_data.rendered

  tags = {
    Name = "App1-Instance1"
  }
}

resource "aws_instance" "app2" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu AMI (update as needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public2.id
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = data.template_file2.nginx_user_data.rendered

  tags = {
    Name = "App1-Instance2"
  }
}

resource "aws_instance" "app3" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu AMI (update as needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public3.id
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = data.template_file3.nginx_user_data.rendered

  tags = {
    Name = "App1-Instance3"
  }
}

