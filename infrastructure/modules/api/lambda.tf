module "lambdas" {
  for_each = local.lambdas
  source   = "terraform-aws-modules/lambda/aws"

  function_name = "${each.key}Lambda${var.name_postfix}"
  description   = "Resolver for AppSync API for ${each.key} api call"
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  source_path   = "../apps/${each.value.directory_name}"

  tags = var.common_tags
}
