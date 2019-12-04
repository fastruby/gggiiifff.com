require "rest-client"
require "json"

module Gggiiifff
  class Query
    attr_accessor :q
    attr_reader :results

    def initialize(attrs = {})
      self.q = attrs[:q].to_s.strip
      @results = []
    end

    def search!
      return unless self.present?

      response = RestClient.get(url)
      @results = JSON.parse(response)
    end

    def url
      "http://api.giphy.com/v1/gifs/search?q=#{q}&api_key=#{GIPHY_API_KEY}&limit=5"
    end
  end
end
