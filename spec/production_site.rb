require 'capybara'
require 'capybara/dsl'
require 'spec_helper'

Capybara.default_driver = :selenium_chrome
Capybara.app_host = 'https://dlmenetwork.org/library'

describe 'Landing Page' do
  before :each do
    visit('/')
  end

  it 'can get to the landing page' do
    expect(page).to have_content('Digital Library of the Middle East')
  end

  context 'facets' do
    it 'has 5 facet groups' do
      expect(page).to have_selector('#facet-panel-homepage-collapse h3', count: 5)
    end
  end

  context 'Browse Categories' do
    it 'has 4 major browse categories' do
      expect(page).to have_selector('.browse-group-categories-block h2', count: 4)
      expect(page).to have_content('Recently Added')
      expect(page).to have_content('Manuscripts')
      expect(page).to have_content('Art & Architecture')
      expect(page).to have_content('Photography')
    end
  end
end

describe 'Browse Categories' do
  it 'has the correct browse categories' do
    visit('/browse/')
    expect(page).to have_selector('.browse-group-navigation li', count: 5)
    expect(page).to have_content('All')
    expect(page).to have_content('Recently Added')
    expect(page).to have_content('Manuscripts')
    expect(page).to have_content('Art & Architecture')
    expect(page).to have_content('Photography')
  end

  # it 'has the correct number of records' do
  #   visit('/browse/')
  #
  #   doc = Nokogiri::HTML(page.html)
  #   categories = doc.search("//div[contains(@class, 'category')]")
  #
  #
  #   $stderr.puts categories.class
  #
  #   visit('/browse/qur-an-manuscripts')
  # end
end

describe 'Basic Search' do

  before :each do
    visit('/')
  end

  it 'can search in Arabic' do
    fill_in('q', with: 'بوس')
    click_button(class: 'search-btn')
    expect(page).to have_content('بؤس العلمانية من بؤس العلمانيين')
  end

  it 'can seach in English' do
    fill_in('q', with: 'Astronomical charts')
    click_button(class: 'search-btn')
    expect(page).to have_content('Astronomical charts for Fatḥ-ʻAlī Shāh Qājār.')
  end

  it 'can search in romanized Arabic' do
    fill_in('q', with: 'Būstān.')
    click_button(class: 'search-btn')
    expect(page).to have_content('Būstān.')
  end
end
