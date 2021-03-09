class StreetsController < ApplicationController
  def new
    points_info = VisitPoint.where(visit_place_id: flash[:visit_place_id])
    api_key = ENV["GOOGLE_KEY"]
    @uri = []
    points_info.each do |point|
      lat = point.latitude
      lng = point.longitude
      @uri.push("https://maps.googleapis.com/maps/api/streetview?size=640x640&location=#{lat},#{lng}&fov=80&heading=70&pitch=0&key=#{api_key}")
    end
  end
end
