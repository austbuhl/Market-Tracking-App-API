class Api::V1::FavoritesController < ApplicationController
  
  token = 'pk_6457f5f5569a457a9f95635f54b70833'
  CLIENT = IEX::Api::Client.new(
    publishable_token: token,
    endpoint: 'https://cloud.iexapis.com/v1'
  )

  def index
    favorites = Favorite.all

    full_response = favorites.map do |fav|
      response = {
        id: fav.id,
        user_id: fav.user_id,
        stock_id: fav.stock_id,
        stock: {
          company: fav.stock.company_name,
          ticker: fav.stock.ticker
        },
        quote: CLIENT.quote(fav.stock.ticker),
        news: CLIENT.news(fav.stock.ticker, 1)
      }
    end

    render json: full_response

    # render json: favorites.to_json(:include => {
    #   :stock => {:only => [:company_name, :ticker]},
    #   :user => {:only => [:name]}
    # })
  end

  def show
    favorite = Favorite.find(params[:id])
    response = {
      id: favorite.id,
      user_id: favorite.user_id,
      stock_id: favorite.stock_id,
      stock: {
        company: favorite.stock.company_name,
        ticker: favorite.stock.ticker
      },
      quote: CLIENT.quote(favorite.stock.ticker),
      news: CLIENT.news(favorite.stock.ticker, 3)
      #chart: CLIENT.chart(favorite.stock.ticker, '6m', chart_close_only: true)
    }
    render json: response
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
