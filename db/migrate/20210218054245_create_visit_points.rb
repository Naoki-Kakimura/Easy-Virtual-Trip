class CreateVisitPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :visit_points do |t|
      t.float :latitude
      t.float :longitude
      t.references :visit_place, foreign_key: true
      t.timestamps
    end
  end
end
