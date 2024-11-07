module "lambdas" {
  for_each = local.lambdas
  source   = "terraform-aws-modules/lambda/aws"

  function_name = "${each.key}Lambda"
  description   = "Resolver for AppSync API for ${each.key} api call"
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  source_path   = "../apps/${each.value.directory_name}"

  tags = merge(var.common_tags, { function_name = each.key })
}
