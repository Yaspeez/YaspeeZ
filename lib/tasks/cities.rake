# frozen_string_literal: true

namespace :cities do
  desc "Import cities"
  task import: :environment do
    require "csv"
    cities_file_path = Rails.root.join("data", "codes-postaux.csv")
    CSV.foreach(cities_file_path, headers: true, col_sep: ";") do |city|
      City.where(code_commune_insee: city["code_commune_insee"]).first_or_create(
        code_commune_insee: city["code_commune_insee"],
        nom_de_la_commune: city["nom_de_la_commune"],
        code_postal: city["code_postal"],
        ligne_5: city["ligne_5"],
        libelle_d_acheminement: city["libelle_d_acheminement"],
        latitude: city["coordonnees_gps"]&.split(",")&.first,
        longitude: city["coordonnees_gps"]&.split(",")&.last,
      )
      print "."
    end
  end
end

