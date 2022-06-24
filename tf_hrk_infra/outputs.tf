output "arn" {
  value       = aws_instance.hrk_01.arn
  sensitive   = true
  description = "ARN of the server"
  //depends_on  = []
}
