provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "us-east-1"
}

variable "get_restaurants_function_name" {
  default = "pickmeGetRestaurantsFunction"
}

variable "place_order_function_name" {
  default = "pickmePlaceOrderFunction"
}

variable "check_delivery_status_function_name" {
  default = "pickmeCheckDeliveryStatusFunction"
}

variable "delivery_handler_name" {
  default = "org.pickme.DeliveryHandler::handleRequest"
}

variable "restaurants_handler_name" {
  default = "org.pickme.RestaurantsHandler::handleRequest"
}

variable "order_handler_name" {
  default = "org.pickme.OrderHandler::handleRequest"
}

variable "fileName" {
  default = "dummy.zip"
}

