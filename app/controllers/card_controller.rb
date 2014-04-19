class CardController < ApplicationController
  def show
      @card = Card.find_by_slug params[:slug]
  end
end
