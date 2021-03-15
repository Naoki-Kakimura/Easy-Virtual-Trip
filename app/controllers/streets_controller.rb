class StreetsController < ApplicationController
  def new
    points_info = VisitPoint.where(visit_place_id: flash[:visit_place_id])
    api_key = ENV["GOOGLE_KEY"]
    @uri = []
    @latlng = []
    points_info.each_with_index do |point,i|
      lat = point.latitude.to_f
      lng = point.longitude.to_f
      @uri.push("https://maps.googleapis.com/maps/api/streetview?size=640x640&location=#{lat},#{lng}&fov=120&pitch=0&key=#{api_key}")
      @latlng.push([lat,lng])
        if points_info.length-1 == i 
          weather_apikey = ENV["WEATHER_KEY"]
          city_lat = 
          uri = URI.parse "http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lng}&appid=#{weather_apikey}&lang=ja&units=metric"

          request = Net::HTTP::Get.new(uri.request_uri)
          response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
            http.request(request)
          end

          body = JSON.parse(response.body)
          @weather = body["weather"][0]["description"]
          @temp = body["main"]["temp"]
        end
    end
  end
end
