class Api::V1::StocksController < ApplicationController
  token = 'pk_6457f5f5569a457a9f95635f54b70833'
  CLIENT = IEX::Api::Client.new(
    publishable_token: token,
    endpoint: 'https://cloud.iexapis.com/v1'
  )

  def index
    token = 'pk_6457f5f5569a457a9f95635f54b70833'
    client = IEX::Api::Client.new(
      publishable_token: token,
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    response = {
      high_level_metrics: [
        CLIENT.quote('DIA'),
        CLIENT.quote('SPY'),
        CLIENT.quote('IWM'),
        CLIENT.quote('NDAQ')
      ],
      top_10: CLIENT.stock_market_list(:mostactive)
    }

    render json: response
  end

  def search
    symbol = params[:symbol]

    response = {
      quote: CLIENT.quote(symbol),
      news: CLIENT.news(symbol, 3)
      #chart: CLIENT.chart(favorite.stock.ticker, '6m', chart_close_only: true)
    }
    render json: response
  end

end
