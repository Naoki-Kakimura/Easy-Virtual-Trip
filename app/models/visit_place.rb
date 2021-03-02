class VisitPlace < ApplicationRecord
  belongs_to :plan
  geocoded_by :municipality
    after_validation :geocode, if: :municipality_changed?
end
