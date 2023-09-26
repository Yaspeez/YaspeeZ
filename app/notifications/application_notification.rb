class ApplicationNotification < Noticed::Base
  def fcm_credentials
    JSON.parse(File.read(Rails.root.join("config/certs/fcm.json")))
  end

  def fcm_device_tokens(recipient)
    recipient.notification_tokens.where(platform: "Android").pluck(:token)
  end

  def ios_bundle_identifier
    Rails.application.credentials.dig(:ios, :bundle_identifier)
  end

  def ios_cert_path
    Rails.root.join("config", "certs", "apns.p8")
  end

  def ios_device_tokens(recipient)
    recipient.notification_tokens.where(platform: "iOS").pluck(:token)
  end

  def ios_key_id
    Rails.application.credentials.dig(:ios, :key_id)
  end

  def ios_team_id
    Rails.application.credentials.dig(:ios, :team_id)
  end
end
