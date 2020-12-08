class Api::V1::FavoritesController < ApplicationController

  # POST to /login and send the username entered in the form...
  # in application controller we either find or create a new user...do
  # then in favorites we just grab the current_user from our application controller @current_user
  IEX_KEY = ENV['iex_publishable_key']

  CLIENT = IEX::Api::Client.new(
    publishable_token: IEX_KEY,
    endpoint: 'https://cloud.iexapis.com/v1'
  )

  def index
    current_user = User.first
    favorites = current_user.favorites

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
      news: CLIENT.news(favorite.stock.ticker, 3),
      chart: CLIENT.chart(favorite.stock.ticker, '6m', chart_close_only: true)
    }
    render json: response
  end


  def create
    fav_stock = Stock.create!(ticker:params[:symbol], company_name: params[:company_name])

    favorite = Favorite.create!(user_id: params[:user_id], stock_id: fav_stock.id)
    render json: favorite
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    # will this actually render?
    render json: favorite
  end

  def favorite_params
    params.permit(:user_id, :symbol)
  end
end
