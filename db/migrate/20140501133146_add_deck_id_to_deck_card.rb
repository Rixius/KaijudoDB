class AddDeckIdToDeckCard < ActiveRecord::Migration
  def change
    add_column :deck_cards, :deck_id, :integer
  end
end
