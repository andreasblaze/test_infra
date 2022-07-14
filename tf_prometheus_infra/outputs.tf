output "arn" {
  value       = aws_instance.prometheus.arn
  sensitive   = false
  description = "ARN of the server"
  //depends_on  = []
}