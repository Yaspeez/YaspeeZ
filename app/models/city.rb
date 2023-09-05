# == Schema Information
#
# Table name: cities
#
#  id                     :uuid             not null, primary key
#  code_commune_insee     :string
#  code_postal            :string
#  latitude               :float
#  libelle_d_acheminement :string
#  ligne_5                :string
#  longitude              :float
#  nom_de_la_commune      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class City < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:nom_de_la_commune, :code_postal], using: { tsearch: { prefix: true } }
end
