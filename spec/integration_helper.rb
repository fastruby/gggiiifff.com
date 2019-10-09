require 'capybara/rspec'

Capybara.app = Gggiiifff::App

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
end
