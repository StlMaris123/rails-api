class List < ApplicationRecord
  belongs_to :board
  belongs_to :creator, class_name: 'user'

  has_many :cards, dependent: :destroy

  validates :title, presence: true
end
