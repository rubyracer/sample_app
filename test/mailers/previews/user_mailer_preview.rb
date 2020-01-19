# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
# Предпросмотр всех писем по адресу http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  # Предпросмотр этого письма на
  # http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    # user = User.first
    user = User.find 102
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
    # UserMailer.account_activation
    # debugger
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  # Предпросмотр этого письма на
  # http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    UserMailer.password_reset
  end

end
