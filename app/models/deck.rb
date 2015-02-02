class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user

  has_attached_file :picture, styles: { medium: "200x200#" }
  validates_attachment_content_type :picture, content_type: /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]

  validates :user, :name, presence: true
end
