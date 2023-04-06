# == Schema Information
#
# Table name: participants
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :uuid             not null
#  user_id     :uuid             not null
#
# Indexes
#
#  index_participants_on_activity_id  (activity_id)
#  index_participants_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
