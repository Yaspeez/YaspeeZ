# == Schema Information
#
# Table name: api_tokens
#
#  id         :uuid             not null, primary key
#  name       :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_api_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ApiToken < ApplicationRecord
  belongs_to :user

  has_secure_token :token

  validates :name, presence: true

  APP_NAME = "Application YaspeeZ"
end
