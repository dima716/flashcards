class AddEfAndScoreAndRepetitionNumberAndRepetitionIntervalToCards < ActiveRecord::Migration
  def change
    add_column :cards, :ef, :float, default: 2.5
    add_column :cards, :score, :integer, default: 0
    add_column :cards, :repetition_number, :integer, default: 0
    add_column :cards, :repetition_interval, :integer
  end
end
