# Setup ActionMailer with SMTP
Rails.application.configure do
  if ENV["MAILER_USE_TEST_DELIVERY_METHOD"] == "True"
    config.action_mailer.delivery_method = :test
  else
    config.action_mailer.default_url_options = { host: ENV['HOST'] }
    config.action_mailer.smtp_settings = {
      address: ENV["SMTP_ADDRESS"],
      port: ENV["SMTP_PORT"],
      domain: ENV["SMTP_DOMAIN_NAME"],
      user_name: ENV["SMTP_USERNAME"],
      password: ENV["SMTP_PASSWORD"],
      authentication: ENV.fetch("SMTP_AUTHENTICATION") {"plain"},
      enable_starttls_auto: ENV.fetch("SMTP_ENABLE_STARTTLS_AUTO") { true },
    }
  end
end
