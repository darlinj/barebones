module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "querySimpleDataLambda"
  description   = "Resolver for AppSync API for querySimipleData api call"
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  source_path   = "../apps/query_simple_data_lambda"

  tags = var.common_tags
}
