class Printing < ActiveRecord::Base
    belongs_to :card
    belongs_to :cardset
end
