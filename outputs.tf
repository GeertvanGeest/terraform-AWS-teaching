output "instance_public_ip" {
  value = aws_eip.train.public_ip
}
