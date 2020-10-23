class Api::V1::StocksController < ApplicationController

  IEX_KEY = ENV['iex_publishable_key']

  CLIENT = IEX::Api::Client.new(
    publishable_token: IEX_KEY,
    endpoint: 'https://cloud.iexapis.com/v1'
  )

  def index

    top_10 = CLIENT.stock_market_list(:mostactive)

    top_10_plus_logos = top_10.map do |company|
      response = {
        quote: company,
        logo: CLIENT.logo(company.symbol)
      }
    end

    response = {
      high_level_metrics: [
        CLIENT.quote('DIA'),
        CLIENT.quote('SPY'),
        CLIENT.quote('IWM'),
        CLIENT.quote('NDAQ')
      ],
      top_10: top_10_plus_logos
    }

    render json: response
  end

  def search
    symbol = params[:symbol]

    response = {
      quote: CLIENT.quote(symbol),
      news: CLIENT.news(symbol, 3),
      chart: CLIENT.chart(symbol, '6m', chart_close_only: true)
    }
    render json: response
  end

end
