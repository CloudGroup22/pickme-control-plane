resource "aws_api_gateway_rest_api" "api" {
  name        = "PickmeFoodAPI"
  description = "API to access pickme foods applications"
  body        = data.template_file.pickme_api_swagger.rendered
}

data "template_file" pickme_api_swagger {
  template = "${file("swagger.yaml")}"

  vars = {
    delivery_lambda_arn     = aws_lambda_function.delivery_lambda_function.invoke_arn
    order_status_lambda_arn = aws_lambda_function.change_order_status_lambda_function.invoke_arn
    order_lambda_arn        = aws_lambda_function.orders_lambda_function.invoke_arn
    restaurant_lambda_arn   = aws_lambda_function.restaurants_lambda_function.invoke_arn
  }
}

resource "aws_api_gateway_deployment" "pickme-api-gateway-deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "default"
}
