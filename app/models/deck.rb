class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  has_attached_file :picture, styles: { medium: "200x200#" }
  validates_attachment_content_type :picture, content_type: /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]

  validates :user, :name, presence: true
  #validates :user, presence: true

  scope :current_deck, -> { where("current = ?", true) }

  def change_current_deck(current_deck)
    current_deck.update_attributes(current: false)
    update_attributes(current: true)
  end
end
