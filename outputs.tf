output "db_endpoint" {
  value = aws_db_instance.pickme_db.endpoint
}

output "url" {
  value = "${aws_api_gateway_deployment.pickme-api-gateway-deployment.invoke_url}/api"
}