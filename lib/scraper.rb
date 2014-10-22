require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'
require 'dotenv'
require 'awesome_print'

class Scraper
  include Capybara::DSL

  def initialize
    Dotenv.load
    Capybara.run_server = false
    Capybara.current_driver = :webkit
    Capybara.app_host = 'http://www.smule.com/'
  end

  def data
    login
    html = page.html.split("displayData").last
    links = html.to_s.scan /"media_url":"(.*?)",/
    titles = html.to_s.scan /"title":"(.*?)",/
    keys = html.to_s.scan /"key":"(.*?)",/
    dates = html.to_s.scan /"created_at":"(.*?)",/

    collection = links.each.with_index.inject([]) do |list, (link, index)|
      list << {
        link: link[0],
        title: titles[index][0],
        key: keys[index][0],
        created_at: dates[index][0]
      }
      list
    end
    collection
  end

  def login
    visit('/')
    click_on('Log In')
    click_on('Login')
    find(:css, '.snp-modal-form-username').set(ENV["USERNAME"])
    find(:css, '.snp-modal-form-password').set(ENV["PASSWORD"])
    click_on('Login')
    sleep(5)
    find(:css, '.login-handle').click
    click_on('Profile')
  end
end
