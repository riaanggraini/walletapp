require 'latest_stock_price'
require 'decorators/stock_decorator'

class StocksController < ApplicationController
  include LatestStockPrice::Endpoints
  include ResponseMessages

  # Fetches all stock prices
  def all_price
    response = price_all
    decorated_response = response.map { |stock| StockDecorator.new(stock).decorate }
    json_response(status: :ok, message: "All stock prices retrieved", data: decorated_response)
  end

  # Fetches for a stock by symbol
  def price_by_symbol
    stock_symbol = params[:symbol]
    response = price_all
    matching_stock = response.find { |stock| stock["symbol"] == stock_symbol }

    if matching_stock
      decorated_stock = StockDecorator.new(matching_stock).decorate
      json_response(status: :ok, message: ResponseMessages.found('Stock'), data: decorated_stock)
    else
      json_response(status: :not_found, message: ResponseMessages.stock_not_found(stock_symbol))
    end
  end

  #  Fetches for a stock by symbols
  def price_by_symbols
    stock_symbols = params[:symbols].split(',')
    response = price_all

    matching_stocks = response.select { |stock| stock_symbols.include?(stock["symbol"]) }
    decorated_stocks = matching_stocks.map { |stock| StockDecorator.new(stock).decorate }

    if decorated_stocks.any?
      json_response(status: :ok, message: ResponseMessages.found('Matching Stocks'), data: decorated_stocks)
    else
      json_response(status: :not_found, message: ResponseMessages.not_found('Matching Stocks'))
    end
  end

  def sync_stock_prices
    response = price_all

    # Use the service to upsert the data into the database
    stock_updater_service = StockService.new(response)
    stock_updater_service.upsert_to_database

    # Return a success response
    json_response(status: :ok, message: ResponseMessages.updated('Stocks'))
  end
end