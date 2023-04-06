# frozen_string_literal: true

namespace :demonstration do
  desc "Seed demonstration data"
  task seed: :environment do
    require "csv"
    addresses_file_path = Rails.root.join("data", "addresses.csv")

    owner = User.find_by(email: "cyril@dilolabs.fr")

    CSV.foreach(addresses_file_path, headers: true) do |address|
      4.times do
        activity = Activity.new(
          address: address["address"],
          city_name: address["city"],
          country_code: "FR",
          description: "Description",
          duration_in_minutes: 60,
          gender: "Tous",
          level: "Loisirs",
          maximum_participants_number: 10,
          per_participant_price_cents: 0,
          postal_code: address["postal_code"],
          starts_at: DateTime.now + 15.days,
          owner:,
          sport: Sport.all.sample,
        )

        results = Geocoder.search([activity.address, activity.postal_code, activity.city].join(" "))
        if results.any?
          most_accurate_result = results.first

          activity.latitude = most_accurate_result.latitude
          activity.longitude = most_accurate_result.longitude
        end

        activity.save!

        activity.participants.where(user: owner).first_or_create!
      end
    end
  end
end
