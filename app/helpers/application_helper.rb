module ApplicationHelper
  require 'pp'

  def gravatar_url(email,options = {})
    require 'digest/md5'
    hash = Digest::MD5.hexdigest(email)
    url = "http://www.gravatar.com/avatar/#{hash}"
    options.each do |option|
      option == options.first ? url+="?" : url+="&"
      key = option[0].to_s
      value = option[1].to_s
      url+=key + "=" + value
    end
    url
  end

  def is_managing_deck?
    !!session[:current_deck]
  end
  def current_deck
    @deck ||= Deck.find(session[:current_deck])
  end

  def link_to_card_format name, slug
    if current_card_format == slug
      name = name + '*'
    end
    link_to name, card_format_path(format: slug)
  end
  def current_card_format
    if session[:card_show_format].nil?
      'image_text'
    else
      session[:card_show_format]
    end
  end
end
