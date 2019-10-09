# cat config.ru
require "dotenv"; Dotenv.load
require_relative "app"

run Gggiiifff::App.freeze.app
