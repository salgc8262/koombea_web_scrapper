class Page < ApplicationRecord
  belongs_to :user
  has_many :links
end
