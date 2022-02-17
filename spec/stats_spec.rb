# frozen_string_literal: true

require 'spec_helper'

# Problem exists where the statistics are not showing the correct number of items as when you click on the link. Item categories are derived from different fields, but a solution was made to ensure these counts match to the Solr query

describe 'Statistics' do
    it 'has the same count as the search results do' do
      visit('/statistics')
      doc = Nokogiri::HTML(page.html)
      
      # get the tr of the first mention of Manuscripts and it's number of items
      tr = doc.search("//tr[contains(., 'Calligraphy')]").first
      cells = tr.search('td')
      manuscripts_count = cells[1].text.gsub(',','').to_i
      
      # hack around not being able to click on a Nokogiri element
      new_path = cells[0].xpath('a/@href').text.gsub("/library", '')
      visit(new_path)
     
      # get the number of results .page-entries 3rd <strong> element
      results_doc = Nokogiri::HTML(page.html)
      results_count = results_doc.search('.page-entries strong')[2].text.gsub(',','').to_i

      #compare manuscript number to result number
      expect(results_count).to eq(manuscripts_count)

    end
  end
  