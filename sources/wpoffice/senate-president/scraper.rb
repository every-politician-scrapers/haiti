#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Took'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[name start end].freeze
    end

    def empty?
      noko.text.to_s.include?('?') || itemLabel.include?('No legislature') || super
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
