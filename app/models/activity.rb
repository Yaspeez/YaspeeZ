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
class Activity < ApplicationRecord
  belongs_to :city, optional: true
  belongs_to :owner, class_name: "User"
  belongs_to :sport
  has_many :comments, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude

  monetize :per_participant_price_cents

  scope :handisports, -> { where(handisport: true) }
  scope :future, -> { where("starts_at > ?", DateTime.now) }

  validates :address, presence: true
  validates :city_name, presence: true
  validates :description, presence: true
  validates :duration_in_minutes, presence: true
  validates :gender, presence: true
  validates :level, presence: true
  validates :maximum_participants_number, presence: true
  validates :per_participant_price_cents, presence: true
  validates :sport_id, presence: true
  validates :starts_at, presence: true

  GENDERS =
    [
      { code: "mixte", name: "Mixte" },
      { code: "femme", name: "Femme" },
      { code: "homme", name: "Homme" },
    ]

  LEVELS =
    [
      { code: "Pas de niveau", name: "Pas de niveau" },
      { code: "Tous niveaux", name: "Tous niveaux" },
      { code: "Débutant", name: "Débutant" },
      { code: "Confirmé", name: "Confirmé" },
      { code: "Expert", name: "Expert" },
    ]

  MINIMUM_DISTANCE_IN_KM = 0
  MAXIMUM_DISTANCE_IN_KM = 50

  def calculate_coordinates
    results = Geocoder.search([address, city].join(" "))

    if results.any?
      most_accurate_result = results.first

      self.latitude = most_accurate_result.latitude
      self.longitude = most_accurate_result.longitude

    elsif self.city.present?
      self.latitude = self.city.latitude
      self.longitude = self.city.longitude
      self.postal_code = self.city.code_postal

    else
      results = Geocoder.search(city)

      if results.any?
        most_accurate_result = results.first

        self.latitude = most_accurate_result.latitude
        self.longitude = most_accurate_result.longitude
      end
    end

    self
  end

  def full_address
    [address, postal_code, city].join(" ")
  end

  def self.genders_select_for
    genders = Activity::GENDERS
    genders.map { |gender| [gender[:name], gender[:code]] }
  end

  def self.levels_select_for
    levels = Activity::LEVELS
    levels.map { |level| [level[:name], level[:code]] }
  end

  def self.next
    future.order(:starts_at)&.first
  end

  def participable?
    maximum_participants_number > participants_count
  end

  def per_participant_price_euros
    if per_participant_price_cents
      per_participant_price_cents / 100
    end
  end
end
