# Step 10 - Add output variables
output "public_ip" {
  value = aws_instance.my_amazon.public_ip
}

output "web_eip" {
  value = aws_eip.static_eip.public_ip
}

output "vpc_id" {
  value = aws_vpc.midterm.id
}