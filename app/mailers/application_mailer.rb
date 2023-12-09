# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('RAILS_ENV') == 'production' ? "no-reply@#{ENV.fetch('FRONTEND_DOMAIN', nil)}" : ENV.fetch('SENDER_ADDRESS', nil)
  layout 'mailer'
end
