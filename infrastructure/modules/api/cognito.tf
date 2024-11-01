resource "aws_cognito_user_pool" "cognito" {
  name = "cognito-user-pool"
}

resource "aws_cognito_user_pool_client" "cognito" {
  name            = "cognito-user-pool-client"
  user_pool_id    = aws_cognito_user_pool.cognito.id
  generate_secret = false
}
