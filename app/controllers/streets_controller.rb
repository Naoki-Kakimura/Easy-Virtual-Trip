class StreetsController < ApplicationController
  def new
    points_info = VisitPoint.where(visit_place_id: flash[:visit_place_id])
    api_key = ENV["GOOGLE_KEY"]
    @uri = []
    @latlng = []
    points_info.each do |point|
      lat = point.latitude.to_f
      lng = point.longitude.to_f
      @uri.push("https://maps.googleapis.com/maps/api/streetview?size=640x640&location=#{lat},#{lng}&fov=120&pitch=0&key=#{api_key}")
      @latlng.push([lat,lng])
    end
  end
end
