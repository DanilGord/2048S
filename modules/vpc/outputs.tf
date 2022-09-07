output "vpc_id" {
  description = "VPC_id"
  value       = aws_vpc.vpc.id
}

output "public_subnets_id" {
  description = "public subnets ID"
  value       = aws_subnet.prod-subnet-public.*.id
}

output "private_subnets_id" {
  description = "private subnets ID"
  value       = aws_subnet.prod-subnet-private.*.id
}
