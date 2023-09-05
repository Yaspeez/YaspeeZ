# == Schema Information
#
# Table name: notification_tokens
#
#  id         :uuid             not null, primary key
#  platform   :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_notification_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class NotificationTokenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
