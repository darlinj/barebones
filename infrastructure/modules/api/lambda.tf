module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "lambda1"
  description   = "Resolver for AppSync API"
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  source_path   = "../apps/lambda1"

  tags = {
    Name = "lambda1"
  }
}
