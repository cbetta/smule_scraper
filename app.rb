require 'sinatra'
require 'json'
require 'redis'
require './lib/scraper'

Dotenv.load

class Application < Sinatra::Base
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET']

  get '/' do
    redirect to('/login') unless logged_in?
    erb :index
  end

  get '/download' do
    redirect to('/login') unless logged_in?
    send_file params[:filename]
  end


  get '/login' do
    erb :login
  end

  get '/logout' do
    session[:logged_in] = nil
    redirect to('/')
  end

  post '/login' do
    if params['password'] == ENV['ACCESS']
      session[:logged_in] = true
    end
    redirect to('/')
  end

  get '/list' do
    redirect to('/login') unless logged_in?
    content_type :json
    Scraper.new.data(params[:cached]).to_json
  end

  private

  def logged_in?
    session[:logged_in] == true
  end
end
