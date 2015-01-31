class AddAttachmentPictureToDecks < ActiveRecord::Migration
  def self.up
    change_table :decks do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :decks, :picture
  end
end
