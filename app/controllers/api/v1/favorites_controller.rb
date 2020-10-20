class Api::V1::FavoritesController < ApplicationController

  def index
    favorites = Favorite.all

    token = 'pk_6457f5f5569a457a9f95635f54b70833'
    client = IEX::Api::Client.new(
      publishable_token: token,
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    full_response = favorites.map do |fav|
      response = { 
        id: fav.id,
        user_id: fav.user_id,
        stock_id: fav.stock_id,
        stock: {
          company: fav.stock.company_name,
          ticker: fav.stock.ticker
        },
        quote: client.quote(fav.stock.ticker)
      }
    end

    render json: full_response

    # render json: favorites.to_json(:include => {
    #   :stock => {:only => [:company_name, :ticker]},
    #   :user => {:only => [:name]}     
    # })

    
  end

  def create
    favorite = Favorite.create!(favorite_params)

    render json: favorite
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    # will this actually render?
    render json: favorite
  end

  def favorite_params
    params.require(:favorite).permit(:user_id, :stock_id)
  end
end