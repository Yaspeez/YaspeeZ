# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default(FALSE)
#  age                    :integer
#  city_name              :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  country_code           :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  followers_count        :integer
#  latitude               :float
#  locked_at              :datetime
#  longitude              :float
#  nickname               :string
#  onboarded              :boolean          default(FALSE)
#  points_count           :integer
#  postal_code            :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  city_id                :uuid
#  sport_id               :uuid
#
# Indexes
#
#  index_users_on_city_id               (city_id)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_sport_id              (sport_id)
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (sport_id => sports.id)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  belongs_to :city, optional: true
  belongs_to :sport, optional: true
  has_one_attached :avatar
  has_many :api_tokens, dependent: :destroy
  has_many :organized_activities, class_name: "Activity", foreign_key: :owner_id, dependent: :destroy
  has_many :participations, class_name: "Participant", dependent: :destroy
  has_many :activities, through: :participations

  validates :age, presence: true, on: :update
  validates :city_name, presence: true, on: :update
  validates :nickname, presence: true, uniqueness: true, on: :update
  validates :postal_code, presence: true, on: :update

  after_save :convert_heic_avatar_to_jpg

  geocoded_by :city_with_postal_code
  reverse_geocoded_by :latitude, :longitude

  def city_with_postal_code
    [postal_code, city].join(" ")
  end

  def convert_heic_avatar_to_jpg
    if avatar.attached? && avatar.content_type.eql?("image/heic")
      ConvertHeicAvatarToJpgJob.perform_later(self)
    end
  end
end

