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
        @query = Query.new(q: request.params["q"])
        @query.search!
        render "home", locals: { query: @query }
      end

      # /gifs/new
      r.get "gifs/new" do
        @file = Gggiiifff::File.new
        render "new", locals: { file: @file }
      end
    end
  end
end
