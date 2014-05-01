class AddCardIdToDeckCard < ActiveRecord::Migration
  def change
    add_column :deck_cards, :card_id, :integer
  end
end
