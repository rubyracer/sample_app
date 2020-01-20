class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  # Тема письма может быть указана в файле I18n config/locales/en.yml
  # следующим образом:
  #
  #   en.user_mailer.account_activation.subject
  #
  # def account_activation
  #   @greeting = "Hi"

  #   mail to: "to@example.org"
  # end

  def account_activation(user)
    @user = user

    # Листинг 10.11: Отправка ссылки на активацию аккаунта.
    mail to: user.email, subject: "Account activation"

    # это для человеко-понятного отображения содержимого в логе рельсо-консоли (небезопасно)
    # mail to: user.email, subject: "Account activation" do |format|
      # format.text(content_transfer_encoding: "7bit")
      # format.html(content_transfer_encoding: "7bit")
    # end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  # Тема письма может быть указана в файле I18n config/locales/en.yml
  # следующим образом:
  #
  #   en.user_mailer.password_reset.subject
  #
  # def password_reset
  #   @greeting = "Hi"

  #   mail to: "to@example.org"
  # end

  def password_reset(user)
    @user = user

    # Листинг 10.43: Отправка ссылки на сброс пароля.
    # mail to: user.email, subject: "Password reset"

    # это для человеко-понятного отображения содержимого в логе рельсо-консоли (небезопасно)
    mail to: user.email, subject: "Password reset" do |format|
      format.text(content_transfer_encoding: "7bit")
      format.html(content_transfer_encoding: "7bit")
    end
  end
end
