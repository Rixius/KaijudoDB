module CardHelper
  def current_deck_card_count number, card
    out = {
      class: 'btn btn-default'
    }
    found = false
    current_deck.deck_cards.each do |deck_card|
      if deck_card.card_id == card.id
        found = true
        if deck_card.amount == number
          out = {
            class: 'btn btn-primary',
            disabled: 'disabled'
          }
        end
      end
    end
    if !found and number == 0
      out = {
        class: 'btn btn-primary',
        disabled: 'disabled'
      }
    end
    out
  end
end
