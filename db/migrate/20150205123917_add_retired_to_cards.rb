class AddRetiredToCards < ActiveRecord::Migration
  def change
    add_column :cards, :retired, :boolean, default: false
  end
end
