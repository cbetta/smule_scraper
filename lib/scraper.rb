require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'
require 'dotenv'

class Scraper
  include Capybara::DSL

  def initialize
    Dotenv.load
    Capybara.run_server = false
    Capybara.current_driver = :webkit
    Capybara.app_host = 'http://www.smule.com/'
  end

  def login
    visit('/')
    click_on('Log In')
    click_on('Login')
    find(:css, '.snp-modal-form-username').set(ENV["USERNAME"])
    find(:css, '.snp-modal-form-password').set(ENV["PASSWORD"])
    click_on('Login')
    sleep(5)
    page.html
  end
end
