class MapsController < ApplicationController
  def new
    visit_placese = flash[:address]
    @visit_place = visit_placese["prefecture"]+visit_placese["municipality"]
    gon.visit_place = @visit_place
    gon.latlng = {lat: visit_placese["latitude"],lng: visit_placese["longitude"]}
  end
end
