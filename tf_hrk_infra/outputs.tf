output "arn" {
  value       = aws_instance.hrk_01.arn
  sensitive   = false
  description = "ARN of the server"
  //depends_on  = []
}

output "name_servers" {
  value       = aws_route53_zone.abprod.name_servers
}