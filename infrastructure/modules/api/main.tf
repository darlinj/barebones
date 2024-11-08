resource "aws_appsync_graphql_api" "api" {
  name   = "api${var.name_postfix}"
  schema = file("modules/api/schema.graphql")

  authentication_type = "AMAZON_COGNITO_USER_POOLS"

  user_pool_config {
    user_pool_id   = aws_cognito_user_pool.cognito.id
    default_action = "ALLOW"
  }

  additional_authentication_provider {
    authentication_type = "API_KEY"
  }

}
resource "time_offset" "one_year_ahead" {
  offset_years = 1
}

resource "aws_appsync_api_key" "api_key" {
  api_id  = aws_appsync_graphql_api.api.id
  expires = time_offset.one_year_ahead.rfc3339
}

