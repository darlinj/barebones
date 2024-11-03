output "appsync_api_key" {
  value = aws_appsync_api_key.api_key.key
}

output "cognito_userpool_id" {
  value = aws_cognito_user_pool.cognito.id
}

output "cognito_userpool_client_id" {
  value = aws_cognito_user_pool_client.cognito.id
}

output "appsync_api_url" {
  value = aws_appsync_graphql_api.api.uris["GRAPHQL"]
}
