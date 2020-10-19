class Api::V1::FavoritesController < ApplicationController

  def index
    favorites = Favorite.all

    client = IEX::Api::Client.new(
      publishable_token: 'pk_6457f5f5569a457a9f95635f54b70833',
      endpoint: 'https://cloud.iexapis.com/v1'
    )

  
    favorites.each do |favorite|
      iex_quote = client.quote(favorite.stock.ticker).to_hash
      favorite.attributes.symbolize_keys.merge({'quote' => iex_quote})
    end

    # render json: quote

    render json: favorites.to_json(:include => {
      :stock => {:only => [:company_name, :ticker]},
      :user => {:only => [:name]}     
    })

    
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