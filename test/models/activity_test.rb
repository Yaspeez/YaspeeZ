# == Schema Information
#
# Table name: activities
#
#  id                             :uuid             not null, primary key
#  address                        :string
#  city_name                      :string
#  country_code                   :string
#  description                    :text
#  duration_in_minutes            :float
#  gender                         :string
#  handisport                     :boolean          default(FALSE)
#  latitude                       :float
#  level                          :string
#  longitude                      :float
#  maximum_participants_number    :integer
#  participants_count             :integer
#  per_participant_price_cents    :integer          default(0), not null
#  per_participant_price_currency :string           default("EUR"), not null
#  postal_code                    :string
#  starts_at                      :datetime
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  city_id                        :uuid
#  owner_id                       :uuid             not null
#  sport_id                       :uuid             not null
#
# Indexes
#
#  index_activities_on_city_id   (city_id)
#  index_activities_on_owner_id  (owner_id)
#  index_activities_on_sport_id  (sport_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (owner_id => users.id)
#  fk_rails_...  (sport_id => sports.id)
#
require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
