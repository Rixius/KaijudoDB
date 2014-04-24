class ChangeAbilitiesToText < ActiveRecord::Migration
  def up
      change_column :abilities, :text, :text
  end
  def down
      change_column :abilities, :text, :string
  end
end
