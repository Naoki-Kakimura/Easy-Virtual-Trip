class CreateVisitPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :visit_points do |t|
      t.float :latitude, :precision => 9, :scale => 6
      t.float :longitude, :precision => 9, :scale => 6
      t.references :visit_place, foreign_key: true
      t.timestamps
    end
  end
end
