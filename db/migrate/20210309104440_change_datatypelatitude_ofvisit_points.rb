class ChangeDatatypelatitudeOfvisitPoints < ActiveRecord::Migration[6.0]
  def change
    change_column :visit_points, :latitude, :decimal,:precision => 9, :scale => 6
  end
end
