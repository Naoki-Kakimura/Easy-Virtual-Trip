class ChangeDatatypelongitudeOfvisitPoints < ActiveRecord::Migration[6.0]
  def change
    change_column :visit_points, :longitude, :decimal,:precision => 9, :scale => 6
    change_column :visit_points, :latitude, :decimal,:precision => 9, :scale => 6
  end
end
