class Api::V1::StocksController < ApplicationController
  
  IEX_KEY = ENV['iex_publishable_key']

  CLIENT = IEX::Api::Client.new(
    publishable_token: IEX_KEY,
    endpoint: 'https://cloud.iexapis.com/v1'
  )

  def index

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
      news: CLIENT.news(symbol, 3),
      chart: CLIENT.chart(symbol, '3m', chart_close_only: true)
    }
    render json: response
  end

end
