output "ec2_public_ip" {
  value = aws_instance.todo_server.public_ip
}
