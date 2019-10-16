source "https://rubygems.org"

gem "roda"

gem "dotenv"
gem "forme"
gem "rest-client"
gem "shrine"
gem "shrine-redis"
gem "tilt"

group :development do
  gem "byebug"
  gem "rubycritic", git: "git@github.com:fastruby/rubycritic.git", branch: "simple-cov-section"
  gem "shotgun"
end

group :test do
  gem "rspec"
  gem "rack-test"
  gem "capybara"
end

group :production do
  gem "puma"
end
