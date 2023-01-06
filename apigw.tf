resource "aws_api_gateway_rest_api" "api" {
  name = "PickmeFoodApi"
}

resource "aws_api_gateway_resource" "resource_restaurants" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "restaurants"
}

resource "aws_api_gateway_method" "method_1" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_restaurants.id
  http_method   = "GET"
  authorization = "NONE"

}

resource "aws_api_gateway_integration" "integration_1" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource_restaurants.id
  http_method             = aws_api_gateway_method.method_1.http_method
  integration_http_method = "POST"
  type                     = "AWS_PROXY"
  uri                      = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.delivery_lambda_function.arn}/invocations"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "dev"
  depends_on = [aws_api_gateway_method.method_1, aws_api_gateway_integration.integration_1]
}