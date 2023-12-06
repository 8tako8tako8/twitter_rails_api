# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{ENV.fetch('FRONTEND_DOMAIN')}"
  layout 'mailer'
end
