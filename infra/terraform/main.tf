provider "aws" {
  region = "us-east-1"  # or your preferred AWS region
}

resource "aws_key_pair" "github_actions" {
  key_name   = "github-actions-key"
  public_key = file("C:/Users/arpit/.ssh/github-actions-key.pub")
}

resource "aws_security_group" "todo_sg" {
  name        = "todo-sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "todo_server" {
  ami           = "ami-0c02fb55956c7d316"  # Ubuntu 22.04 LTS (us-east-1)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.github_actions.key_name
  security_groups = [aws_security_group.todo_sg.name]

  tags = {
    Name = "todo-server"
  }
}
