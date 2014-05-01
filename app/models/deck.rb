class Deck < ActiveRecord::Base
  has_many :deck_cards
  belongs_to :user
  enum format: {
    open: 'open',
    standard: 'standard'
  }
end
