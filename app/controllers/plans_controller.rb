class PlansController < ApplicationController
  def index

  end
  def new
    require 'securerandom'
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
  end
  def create
    plan = Plans.new
  end
end
