output "length" {
  value       = "${length(aws_instance.frontend)}"
}

output "target_id" {
  value       = "${aws_eip.elastic_ip_frontend[*].private_ip}" 
}
