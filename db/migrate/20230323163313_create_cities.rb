class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities, id: :uuid do |t|
      t.string :code_commune_insee
      t.string :nom_de_la_commune
      t.string :code_postal
      t.string :ligne_5
      t.string :libelle_d_acheminement
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
