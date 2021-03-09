class VisitPoint < ApplicationRecord
  belongs_to :visit_place
  has_one_attached :image
end
