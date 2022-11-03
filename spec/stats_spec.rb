# frozen_string_literal: true

require 'spec_helper'

# Problem exists where the statistics are not showing the correct number of items as when you click on the link. Item categories are derived from different fields, but a solution was made to ensure these counts match to the Solr query

describe 'Statistics' do
    it 'has the same count as the search results do' do
      visit('/statistics')
      doc = Nokogiri::HTML(page.html)
      
      # get the tr of the first mention of Manuscripts and it's number of items
      # tr = doc.search("//tr[contains(., 'Calligraphy')]").first
      tr = doc.search("//tr[contains(., 'Manuscripts')]").first
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

    it 'has the same number of collections as the search results do' do
      visit('/statistics')

      doc = Nokogiri::HTML(page.html)
      tr = doc.search('//tr[contains(., "American University of Beirut")]')
      link = tr.search('a').first
      cells = tr.search('td')
      collection_count = cells[2].text.gsub(',','').to_i
      item_count = cells[3].text.gsub(',','').to_i

      # $stderr.puts "#{link['href']} | #{collection_count} | #{item_count}"

      visit(link['href'].gsub('/library', '')) # need to remove repeated 'library'
      
      # https://dlmenetwork.org/library/catalog?f%5Bagg_provider_en%5D%5B%5D=American+University+of+Beirut
      results_doc = Nokogiri::HTML(page.html)
      results_item_count = results_doc.search('.page-entries strong')[2].text.gsub(',','').to_i

      # pull the number of collections by counting <li> elements in .facet-agg_data_provider_collection_en
      results_collection_count = results_doc.search('#facet-agg_data_provider_collection_en li').count
      # $stderr.puts "#{results_collection_count}"

      expect(results_item_count).to eq(item_count)
      expect(results_collection_count).to eq(collection_count)

    end
  end
  