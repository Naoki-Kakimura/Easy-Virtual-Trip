class MapsController < ApplicationController
  def new
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
      place = [image_url,title]
      @placese.push(place)
    end
    if @placese.nil?
      redirect_to controller: :plans, action: :index
    end
  end
end


