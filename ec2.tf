#2. EC2 Instance
resource "aws_instance" "app1" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu AMI (update as needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1.id
  security_groups = [aws_security_group.ec2_sg.id]

 user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              sudo dnf install -y nginx.x86_64
              sudo systemctl start nginx
              sudo systemctl enable nginx
 
              #sudo rm -rf | sudo tee -a /usr/share/nginx/html/index.html
              echo "<h1>Home - Page!</h1>" | sudo tee -a /usr/share/nginx/html/index.html
 
              sudo chown -R nginx:nginx /usr/share/nginx/html
              sudo chmod -R 755 /usr/share/nginx/html
              EOF

  tags = {
    Name = "App1-Instance1"
  }
}

resource "aws_instance" "app2" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu AMI (update as needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public2.id
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              sudo dnf install -y nginx.x86_64
              sudo systemctl start nginx
              sudo systemctl enable nginx
 
              mkdir /usr/share/nginx/html/images
              echo "<h1>Images !</h1>" | sudo tee -a /usr/share/nginx/html/images/index.html
 
              sudo chown -R nginx:nginx /usr/share/nginx/html
              sudo chmod -R 755 /usr/share/nginx/html
              EOF
  tags = {
    Name = "App1-Instance2"
  }
}

resource "aws_instance" "app3" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu AMI (update as needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public3.id
  security_groups = [aws_security_group.ec2_sg.id]

user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              sudo dnf install -y nginx.x86_64
              sudo systemctl start nginx
              sudo systemctl enable nginx
 
              mkdir /usr/share/nginx/html/register
              echo "<h1>Register !</h1>" | sudo tee -a /usr/share/nginx/html/register/index.html
 
              sudo chown -R nginx:nginx /usr/share/nginx/html
              sudo chmod -R 755 /usr/share/nginx/html
              EOF
  tags = {
    Name = "App1-Instance3"
  }
}

