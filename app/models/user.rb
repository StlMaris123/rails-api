class User < ApplicationRecord
  include Gravatar

  has_secure_password

  has_many :boards, foreign_key: 'creator_id', dependent: :nullify
  has_many :lists, foreign_key: 'creator_id', dependent: :nullify
  has_many :cards, foreign_key: 'creator_id', dependent: :nullify
  has_many :comments, foreign_key: 'creator_id', dependent: :nullify
  has_many :assigned_cards, foreign_key: 'assignee_id', dependent: :nullify, class_name: 'Card'

  validates :email, presence: true, iniqueness: true

  default_scope { order(:created_at) }

  def self.admin
    where(admin: true)
  end

end
