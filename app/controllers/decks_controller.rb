class DecksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_deck, only: [:show, :edit, :update, :destroy, :scope, :manage]
  before_action :check_ownership, only: [:edit, :update, :destroy, :scope, :manage]
  before_action :check_visibility, only: [:edit, :update, :destroy, :scope, :show, :manage]

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
  end

  # GET /decks/new
  def new
    @deck = Deck.new
  end

  # GET /decks/1/edit
  def edit
  end

  # POST /decks
  # POST /decks.json
  def create
    @deck = Deck.new(deck_params)
    @deck.user = current_user
    @deck.active = true

    respond_to do |format|
      if @deck.save
        format.html { redirect_to @deck, notice: 'Deck was successfully created.' }
        format.json { render :show, status: :created, location: @deck }
      else
        format.html { render :new }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decks/1
  # PATCH/PUT /decks/1.json
  def update
    respond_to do |format|
      if @deck.update(deck_params)
        puts @deck.inspect
        format.html { redirect_to @deck, notice: 'Deck was successfully updated.' }
        format.json { render :show, status: :ok, location: @deck }
      else
        format.html { render :edit }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck.destroy
    respond_to do |format|
      format.html { redirect_to decks_url }
      format.json { head :no_content }
    end
  end

  # GET /decks/1/scope
  # GET /decks/1/scope.json
  def scope
    session[:current_deck] = params[:deck_id]
    session[:current_deck] = nil if params[:deck_id] == '0'
    respond_to do |format|
      format.html { redirect_back_or_default }
      format.json { head :no_content }
    end
  end

  #POST /decks/1/manage
  #POST /decks/1/manage.json
  def manage
    @card = Card.find(params[:card_id])
    @deck_card = DeckCard.where('deck_id = ?', @deck.id).where('card_id = ?', params[:card_id]).first

    if !@deck_card
      @deck_card = DeckCard.new deck: @deck,
        card: @card
    end
    @deck_card.amount = params[:commit]
    @deck_card.save

    respond_to do |format|
      format.html { redirect_back_or_default }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deck_params
      params.require(:deck).permit(:name, :description, :public, :format)
    end

    # Only allow modifications by the owner of the deck
    def check_ownership
      if current_user != @deck.user
        redirect_to root_path, notice: 'You cannot edit someone else\'s deck!'
      end
    end

    def check_visibility
      if !@deck.active or (current_user != @deck.user and !@deck.public)
        not_found
      end
    end
end
