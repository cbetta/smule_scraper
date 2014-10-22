require 'sinatra'
require "./lib/scraper"

class Application < Sinatra::Base
  get '/' do
    Scraper.new.login
    # "Hello World"
  end

  private


end
