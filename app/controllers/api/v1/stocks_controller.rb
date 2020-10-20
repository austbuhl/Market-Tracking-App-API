class Api::V1::StocksController < ApplicationController

  def index
    token = 'pk_6457f5f5569a457a9f95635f54b70833'
    client = IEX::Api::Client.new(
      publishable_token: token,
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    response = {
      high_level_metrics: [
        client.quote('DIA'),
        client.quote('SPY'),
        client.quote('IWM'),
        client.quote('NDAQ')
      ],
      top_10: client.stock_market_list(:mostactive)
    }

    render json: response

  end

end