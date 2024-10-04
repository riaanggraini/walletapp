class StockService
  def initialize(stocks_data)
    @stocks_data = stocks_data
  end

  def upsert_to_database
    unique_stocks = @stocks_data.uniq { |stock| stock['symbol'] }

    # Upsert unique stock records into the database
    unique_stocks.each do |stock|
      Stock.upsert(
        {
          symbol: stock['symbol'],
          price: stock['lastPrice'],
          change: stock['change'],
          day_high: stock['dayHigh'],
          day_low: stock['dayLow'],
          last_update_time: stock['lastUpdateTime'],
          company_name: stock.dig('meta', 'companyName'),
          industry: stock.dig('meta', 'industry'),
          isin: stock.dig('meta', 'isin'),
          open_price: stock['open'],
          p_change: stock['pChange'],
          per_change_30d: stock['perChange30d'],
          per_change_365d: stock['perChange365d'],
          previous_close: stock['previousClose'],
          total_traded_value: stock['totalTradedValue'],
          total_traded_volume: stock['totalTradedVolume'],
          year_high: stock['yearHigh'],
          year_low: stock['yearLow']
        },
        unique_by: :symbol
      )
    end
  end
end
