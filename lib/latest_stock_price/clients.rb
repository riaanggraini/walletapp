require 'httparty'

module LatestStockPrice
  class Clients
    include HTTParty
    base_uri ENV.fetch('RAPIDAPI_BASEURL')

    def initialize
      @headers = {
        "X-RapidAPI-Key" => ENV['RAPIDAPI_KEY'],
        "X-RapidAPI-Host" => "latest-stock-price.p.rapidapi.com",
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
    end

    def get_price_all
      response = self.class.get("/any", headers: @headers)
      handle_response(response)
    end    
    
    private
    
    def handle_response(response)
      if response.success?
        response
      else
        raise "API request failed with code #{response.code}: #{response.message}"
      end
    end
  end
end    
