require "rest-client"
require "json"

module Gggiiifff
  class Query
    attr_accessor :q
    attr_reader :results

    QUERY_CACHE = Hash.new 

    def initialize(attrs = {})
      self.q = attrs[:q].to_s
      @results = []
    end

    def present?
      self.q.strip.size > 0
    end

    def results?
      !@results.empty?
    end

    def search!
      return unless self.present?

      @results = search_with_cache!
    end

    def search_with_cache!
      return QUERY_CACHE[q] if QUERY_CACHE[q]

      url = "http://api.giphy.com/v1/gifs/search?q=#{q}&api_key=#{GIPHY_API_KEY}&limit=5"
      response = RestClient.get(url)
    
      QUERY_CACHE[q] = JSON.parse(response)
    end
  end
end
