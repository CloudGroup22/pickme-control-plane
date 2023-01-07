resource "aws_iam_role" "lambda_role" {
  name = "role_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "dummy" {
  type = "zip"
  output_path = "${path.module}/dummy.zip"
  source {
    content  = "hello"
    filename = "dummy.txt"
  }
}

resource "aws_lambda_function" "delivery_lambda_function" {
  function_name = var.check_delivery_status_function_name
  filename      = var.fileName
  role          = aws_iam_role.lambda_role.arn
  handler       = var.delivery_handler_name
  runtime       = "java8"
  timeout       = 15
  memory_size   = 512
}

resource "aws_lambda_function" "restaurants_lambda_function" {
  function_name = var.get_restaurants_function_name
  filename      = var.fileName
  role          = aws_iam_role.lambda_role.arn
  handler       = var.restaurants_handler_name
  runtime       = "java8"
  timeout       = 15
  memory_size   = 512
}

resource "aws_lambda_function" "orders_lambda_function" {
  function_name = var.place_order_function_name
  filename      = var.fileName
  role          = aws_iam_role.lambda_role.arn
  handler       = var.order_handler_name
  runtime       = "java8"
  timeout       = 15
  memory_size   = 512
}

resource "aws_lambda_function" "change_order_status_lambda_function" {
  function_name = var.change_order_status_function_name
  filename      = var.fileName
  role          = aws_iam_role.lambda_role.arn
  handler       = var.order_handler_name
  runtime       = "java8"
  timeout       = 15
  memory_size   = 512
}