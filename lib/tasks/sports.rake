# frozen_string_literal: true

namespace :sports do
  desc "Import sports"
  task import: :environment do
    require "csv"
    sports_file_path = Rails.root.join("data", "sports.csv")
    CSV.foreach(sports_file_path, headers: true) do |s|
      Sport.where(name: s["name"]).first_or_create
    end
  end
end

