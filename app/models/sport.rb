# == Schema Information
#
# Table name: sports
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Sport < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name, against: :name, using: { tsearch: { prefix: true } }

  has_one_attached :icon
  has_one_attached :cover_photo
  has_many :activities, dependent: :destroy
  has_many :users, dependent: :nullify

  def future_activities_for(user)
    activities.near([user.latitude, user.longitude], 10, units: :km).future.order(starts_at: :asc)
  end
end
