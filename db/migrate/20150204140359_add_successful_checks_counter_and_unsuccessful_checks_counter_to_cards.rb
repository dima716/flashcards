class AddSuccessfulChecksCounterAndUnsuccessfulChecksCounterToCards < ActiveRecord::Migration
  def change
    add_column :cards, :successful_checks_counter, :integer, default: 0
    add_column :cards, :unsuccessful_checks_counter, :integer, default: 0
  end
end
