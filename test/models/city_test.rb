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
require "test_helper"

class CityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
