class MapsController < ApplicationController
  def new
    @visit_place_id = flash[:visit_place_id]
    visit_placese = flash[:address]
    @visit_place = visit_placese["prefecture"]+visit_placese["municipality"]
    gon.visit_place = @visit_place
    gon.latlng = {lat: visit_placese["latitude"],lng: visit_placese["longitude"]}

    require 'net/https'
    require 'uri'
    require 'json'
    require 'nokogiri'

    api_key = ENV["GOOGLE_KEY"]
    lat = visit_placese["latitude"]
    lng = visit_placese["longitude"]
    rad = '5000'

    types = ["amusement_park","cafe","food","museum","place_of_worship","restaurant","spa","zoo"]

    language = 'ja'

    uri = URI.parse "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=#{rad}&types=#{types}&sensor=false&language=ja&key=#{api_key}"

    request = Net::HTTP::Get.new(uri.request_uri)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    body = JSON.parse(response.body)
    results = body['results']
    @placese = []
    results.each do |info|
      if info["name"].nil? || info["photos"].nil?
        next
      end
      location = info["geometry"]["location"]
      location_lat = location["lat"]
      location_lng = location["lng"]
      location_point = [location_lat,location_lng]
      image_arr = info["photos"]
      image = image_arr[0]["photo_reference"]
      title = info["name"]
      uri = URI.parse "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{image}&key=#{api_key}"
      request = Net::HTTP::Get.new(uri.request_uri)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end
      body = response.body
      file = Nokogiri::HTML(body)
      set = file.xpath('//a/@href')
      image_info = set[0]
      if image_info.nil?
        next
      end
      image_url = image_info.value
      place = [image_url,title,location_point]
      @placese.push(place)
    end
    if @placese.nil?
      redirect_to controller: :plans, action: :index
    end
    @visit_point = VisitPoint.new
  end
  
  def create
    visit_place_id = params["visit_point"][:visit_place_id]
    visit_points = visit_point_params
    visit_points.each_with_index do |point,i|
      point_arr = point.split(",")
      visit_lat = point_arr[0].delete("[").to_f
      visit_lng = point_arr[1].delete("]").strip.to_f
      visit_point_id = VisitPoint.create(latitude: visit_lat, longitude: visit_lng, visit_place_id: visit_place_id)
      if i == visit_points.length - 1
        flash.keep[:visit_place_id] = visit_point_id.visit_place_id
      end
    end
    redirect_to controller: :streets, action: :new
  end

  private
    def visit_point_params
      visit_param = params
      visit_param.delete("authenticity_token")
      visit_param.delete("commit")
      visit_param.delete("controller")
      visit_param.delete("action")
      visit_param.delete("visit_point")
      visit_location_index = visit_param.keys
      visit_points = []
      visit_location_index.each do |i|
        visit_points.push(visit_param[i])
      end
      return visit_points
    end
end


