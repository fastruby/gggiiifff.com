require "rest-client"
require "json"

module Gggiiifff
  class Query
    attr_accessor :q
    attr_reader :results

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

      url = "http://api.giphy.com/v1/gifs/search?q=#{q}&api_key=#{GIPHY_API_KEY}&limit=5"
      response = RestClient.get(url)
      @results = JSON.parse(response)
    end
  end
end
