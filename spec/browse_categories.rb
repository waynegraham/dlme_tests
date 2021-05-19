require 'capybara'
require 'capybara/dsl'
require 'spec_helper'

Capybara.default_driver = :selenium_chrome
Capybara.app_host = 'https://dlmenetwork.org/'

# Note, removed the `/library` from `app_host` because of how Capybara contructs
# URLs, to make it easier

describe 'Browse Categories' do

  it 'has the correct browse categories' do
    visit('/library/browse/')
    expect(page).to have_selector('.browse-group-navigation li', count: 5)
    expect(page).to have_content('All')
    expect(page).to have_content('Recently Added')
    expect(page).to have_content('Manuscripts')
    expect(page).to have_content('Art & Architecture')
    expect(page).to have_content('Photography')
  end

  it 'has the expected number of results' do
    visit('/library/browse/')

    doc = Nokogiri::HTML(page.html)
    categories = doc.search("//div[contains(@class, 'category')]")

    categories.each do |category|
      # extract item count
      count = category.search('small').text.gsub(/item?(s?)/, '').strip.to_i
      label = category.search('span[@class="title"]').text

      link = category.search('a').first

      visit(link['href'])
      doc2 = Nokogiri::HTML(page.html)
      page_count = doc2.search('small').text.gsub(/item?(s?)/, '').strip.to_i
      expect(page_count).to eq(count)
      # $stderr.puts "Checking #{label} (#{link['href']}): #{count} | #{page_count}"
    end
  end
end
