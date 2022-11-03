# frozen_string_literal: true

require 'capybara'
require 'capybara/dsl'
require 'open-uri'
require 'capybara-screenshot/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL

  Capybara.default_driver = :selenium_chrome
  Capybara.app_host = 'https://dlmenetwork.org/library'
  Capybara::Screenshot.autosave_on_failure = true
end
