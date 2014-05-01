class Deck < ActiveRecord::Base
  belongs_to :user
  enum format: {
    open: 'open',
    standard: 'standard'
  }
end
