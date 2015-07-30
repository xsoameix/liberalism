class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @title = "自由學者管理系統 會員註冊通知"
    @user = user
    mail to: @user.email, subject: @title
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.deleting.subject
  #
  def deleting(user)
    @title = "自由學者管理系統 會員刪除通知"
    @user = user
    mail to: @user.email, subject: @title
  end
end
