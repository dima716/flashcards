class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :password, length: { minimum: 3 }, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :decks, dependent: :destroy
  accepts_nested_attributes_for :authentications
end
