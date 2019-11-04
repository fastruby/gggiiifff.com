require "roda"
require "tilt"
require "forme"
require "warden"

require_relative "config/constants"
require_relative "config/ohm"
require_relative "config/omniauth_twitter"
require_relative "config/shrine"
require_relative "models/file"
require_relative "models/query"
require_relative "models/user"

module Gggiiifff
  class App < Roda
    plugin :flash
    plugin :forme
    plugin :render
    plugin :static, ["/stylesheets"]

    use Rack::Session::Cookie, key: "rack.session",
                               domain: ENV['DOMAIN'],
                               path: "/",
                               expire_after: 2592000, # In seconds
                               secret: ENV["SESSION_SECRET"]
    use OmniAuth::Builder do
      provider :twitter, TWITTER_API_KEY, TWITTER_API_SECRET
    end
    # setup extracted from a working rails application
    use Warden::Manager do |config|
      config.failure_app = ->(env) do
        env['REQUEST_METHOD'] = 'GET'
        [0, 500, {}]
      end
      config.default_scope = :user

      config.scope_defaults :user,        :strategies => [:password]

      config.scope_defaults(
        :api,
        strategies: [:api_token],
        store: false,
        action: "unauthenticated_api"
      )
    end

    route do |r|
      # GET / request
      r.root do
        r.redirect "/search"
      end

      # Sign In
      r.get "auth/twitter/callback" do
        if (auth_hash = request.env['omniauth.auth'])
          handle = auth_hash["info"]["nickname"]

          if (user = User.find(username: handle))
            flash["notice"] = "Signed in"
          else
            flash["notice"] = "Signed up"
            user = User.create(username: handle)
          end

          env['warden'].set_user user
        end

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
