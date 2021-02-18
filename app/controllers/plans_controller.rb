class PlansController < ApplicationController
  def index

  end
  def new
    require 'securerandom'
    require 'flickraw'
    search_trip
    if @image_url == []
      search_trip
    end
    @plan = Plan.new
  end
  def create
    Plan.create(plan_params)
  end
  private
  def search_trip
    prefecture_num = SecureRandom.random_number(47)
    params =URI.encode_www_form({prefCode:prefecture_num})
    uri = URI.parse("https://opendata.resas-portal.go.jp/api/v1/cities?#{params}")
    req = Net::HTTP::Get.new(uri.request_uri)
    req["X-API-KEY"] = ENV['RESAS_KEY']

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    res = https.request(req)

    res_body = JSON.parse(res.body)
    result = res_body["result"]
    city_num = SecureRandom.random_number(result.length)
    city_hash = result[city_num]
    @city_name = city_hash["cityName"]

    FlickRaw.api_key = ENV["FLICKR_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_SECRET_KEY"]
    images = flickr.photos.search(tags: @city_name, sort: "interestingness-desc", per_page: 4)
    @image_url = []
    images.each do |image|
      url = FlickRaw.url image
      @image_url.push(url)
    end
  end
  def plan_params
    params.require(:plan).permit(:name)
  end
end
