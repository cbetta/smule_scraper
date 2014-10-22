require "capybara"
require "capybara/dsl"
require "capybara-webkit"

class Scraper
  include Capybara::DSL

  def initialize
    Capybara.run_server = false
    Capybara.current_driver = :webkit
    Capybara.app_host = "http://www.smule.com/"
  end

  def login
    visit("/")
    click_on('Log In')
    click_on('Login')
    find(:css, ".snp-modal-form-username").set("paypal14")
    find(:css, ".snp-modal-form-password").set("paypal14")
    click_on('Login')
    sleep(5)
    page.html
  end
end
