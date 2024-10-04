module LatestStockPrice
  module Endpoints

    def price_all
      client.get_price_all
    end

    private

    def client
      @client ||= LatestStockPrice::Clients.new
    end
  end
end
