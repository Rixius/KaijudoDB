module ApplicationHelper
  require 'pp'

  def is_managing_deck?
    !!session[:current_deck]
  end
  def current_deck
    @deck ||= Deck.find(session[:current_deck])
  end
end
