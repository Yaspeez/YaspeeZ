class ReportActivityCommentNotification < ApplicationNotification
  deliver_by :ios, format: :ios_format, bundle_identifier: :ios_bundle_identifier, cert_path: :ios_cert_path, key_id: :ios_key_id, team_id: :ios_team_id, pool_size: 5, development: Rails.env.development?
  deliver_by :fcm, credentials: :fcm_credentials, format: :format_notification

  def format_notification(device_token)
    {
      token: device_token,
      notification: {
        title: "Nouveau signalement sur YaspeeZ",
        body: "Nouveau signalement de commentaire",
      },
    }
  end

  def ios_format(apn)
    apn.alert = "Nouveau signalement de commentaire"
    apn.custom_payload = {
      url: activity_url(params[:activity]),
    }
  end
end
