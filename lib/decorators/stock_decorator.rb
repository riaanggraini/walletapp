class StockDecorator
  def initialize(stock)
    @stock = stock
  end

  def decorate
    {
      symbol: @stock["symbol"],
      identifier: @stock["identifier"],
      change: @stock["change"],
      day_high: @stock["dayHigh"],
      day_low: @stock["dayLow"],
      last_price: @stock["lastPrice"],
      last_update_time: parse_time(@stock["lastUpdateTime"]),
      open_price: @stock["open"],
      p_change: @stock["pChange"],
      per_change_30d: @stock["perChange30d"],
      per_change_365d: @stock["perChange365d"],
      previous_close: @stock["previousClose"],
      total_traded_value: @stock["totalTradedValue"],
      total_traded_volume: @stock["totalTradedVolume"],
      year_high: @stock["yearHigh"],
      year_low: @stock["yearLow"],
      meta: format_meta(@stock["meta"])
    }
  end

  private

  # Convert time
  def parse_time(time)
    time ? Time.parse(time) : nil
  end

  # Formatting for the 'meta' field
  def format_meta(meta)
    {
      company_name: meta["companyName"],
      industry: meta["industry"],
      isin: meta["isin"]
    }
  end
end
