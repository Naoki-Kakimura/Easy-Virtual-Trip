class AddLatToVisitPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :visit_places, :longitude, :float
    add_column :visit_places, :latitude, :float
  end
end
