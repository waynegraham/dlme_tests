require 'selenium-webdriver'
require 'terminal-table'

@driver = Selenium::WebDriver.for :chrome
@wait = Selenium::WebDriver::Wait.new(timeout: 30)
@app_host = 'https://dlmenetwork.org/library'
@rows = []

def timestamp
  Process.clock_gettime(Process::CLOCK_MONOTONIC)
end

def elapsed_time(start_time, end_time)
  end_time - start_time
end

def setup
  @start_time = timestamp
  @driver.navigate.to @app_host
end

def report(rows)
  Terminal::Table.new(title: 'DLME Time Responses', headings: ['Task', 'Time (seconds)'], rows: rows)
end

desc 'Generate report'
task :report do
  puts report(@rows)
end

namespace :performance do
  desc 'Run all performance tests and generate report'
  task all: %i[landing_page simple_search browse_categories]

  desc 'Landing page timing'
  task :landing_page do
    setup
    timing = elapsed_time(@start_time, timestamp)
    @rows << ['landing_page', timing]
  end

  desc 'Simple search timing (search for "persian gulf" from landing page)'
  task :simple_search do
    setup

    search = @driver.find_element(id: 'q')
    search.send_keys('persian gulf')
    button = @driver.find_element(class: 'blacklight-icon-search').click
    @wait.until { @driver.find_element(class: 'page-links') }

    timing = elapsed_time(@start_time, timestamp)

    @rows << ['simple_search', timing]
  end

  desc 'View Browse categories'
  task :browse_categories do
    setup
    # puts @driver.find_element(:xpath, "//*[text()='Manuscripts']//a/string()").map(&:text)
    manuscripts = @driver.find_elements(:class, 'browse-group-categories-block')[1]
    manuscripts.find_element(:link, 'View all').click
    @wait.until { @driver.find_element(class: 'category') }

    timing = elapsed_time(@start_time, timestamp)

    @rows << ['browse_categories', timing]
  end

  desc 'Load test'
  task :load do
    users = 5
    requests = 500
    seconds = 1200
    puts "ab -c #{users} -n #{requests} -s #{seconds} #{@app_host}"
  end
end
