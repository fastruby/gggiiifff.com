require "roda"
require "tilt"
require "forme"

require_relative "config/constants"
require_relative "config/shrine"
require_relative "models/file"
require_relative "models/query"

module Gggiiifff
  class App < Roda
    plugin :forme
    plugin :render

    route do |r|
      # GET / request
      r.root do
        r.redirect "/search"
      end

      # /search branch
      r.get "search" do
        query_string = request.params["q"].to_s.strip
        @query = Query.new(q: query_string)
        @query.search!
        view "home", locals: { query: @query }
      end

      # /gifs/new
      r.get "gifs/new" do
        @file = Gggiiifff::File.new
        view "new", locals: { file: @file }
      end
    end
  end
end
