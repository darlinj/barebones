

resource "aws_cognito_user_pool" "cognito" {
  name                     = "cognito-user-pool"
  auto_verified_attributes = ["email"]

  email_configuration {
    email_sending_account  = "COGNITO_DEFAULT"
    reply_to_email_address = "support@${var.domain_name}"
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
    invite_message_template {
      email_message = "Welcome to our service! Your verification code is {####} and your username is {username}"
      sms_message   = "Welcome to our service! Your verification code is {####} and your username is {username}"
      email_subject = "Your verification code"
    }
  }
}

resource "aws_cognito_user_pool_client" "cognito" {
  name            = "cognito-user-pool-client"
  user_pool_id    = aws_cognito_user_pool.cognito.id
  generate_secret = false
}
