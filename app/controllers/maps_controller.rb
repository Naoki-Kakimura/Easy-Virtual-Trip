class MapsController < ApplicationController
  def new
    visit_placese = flash[:address]
    visit_place = visit_placese["prefecture"]+visit_placese["municipality"]
    gon.visit_place = visit_place
    gon.google_key = ENV["GOOGLE_KEY"]
  end
end
