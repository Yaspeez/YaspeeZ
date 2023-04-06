if Rails.env.production?
  Mailjet.configure do |config|
    config.api_key = Rails.application.credentials.dig(:mailjet, :api_key)
    config.secret_key = Rails.application.credentials.dig(:mailjet, :secret_key)
    config.default_from = 'contact@yaspeez.fr'
  end
end
