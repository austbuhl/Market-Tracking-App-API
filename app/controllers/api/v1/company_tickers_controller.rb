class Api::V1::CompanyTickersController < ApplicationController
  def index
    tickers = CompanyTicker.all

    render json: tickers, except:[:updated_at, :created_at]
  end
end
