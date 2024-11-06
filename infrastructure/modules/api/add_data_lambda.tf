module "add_data" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "addDataLambda"
  description   = "Resolver for AppSync API for addData api call"
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  source_path   = "../apps/add_data_lambda"

  tags = var.common_tags
}
