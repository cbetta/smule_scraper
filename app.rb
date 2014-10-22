require 'sinatra'
require 'json'
require "./lib/scraper"

class Application < Sinatra::Base
  get '/' do
  end

  get "/list" do
    content_type :json
    Scraper.new.data.to_json
  end
end
