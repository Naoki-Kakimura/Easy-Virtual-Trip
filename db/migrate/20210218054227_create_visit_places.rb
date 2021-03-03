class CreateVisitPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :visit_places do |t|
      t.string :prefecture 
      t.string :municipality
      t.references :plan, foreign_key: true
      t.timestamps
    end
  end
end
