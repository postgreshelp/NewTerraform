output "new_vpc_id" {
  description = "ID of the newly created VPC"
  value       = aws_vpc.new_vpc.id
}