require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './top-search.rb'


##stopped due to illegality of scraping google trends##


class Scraper

  def get_page
    doc = Nokogiri::HTML(open("http://www.google.com/trends/hottrends"))
  end

  def get_top_results
    # format for the date to distinguish today's most popular is the id yearmonthday
    #e.g. February 3 2016 -> 20160203
    #so css selector would be div.2016203 which would select that entire days worth. 
    # use datetime library to get date. 
    # time = Time.new -> time.strftime('%Y%m%d').to_i
    time = Time.new 
    new_time = time.strftime('%Y%m%d').to_i
    #self.get_page.css("div ##{new_time}")
    self.get_page.css("div .hottrends-single-trend-container")
  end

  #\32 0160203-Groundhog\20 Day > div > div.hottrends-single-trend-info-container > div:nth-child(1) > div > a > span

  def make_searches
    get_top_results.each do |post|
      result = Result.new
      result.title = post.css("div a span").text
    end
    binding.pry
  end
 

  def print_results
    self.make_searches
    Result.all.each do |result|
      if result.title
        puts "Title: #{result.title}"
      end
    end
  end
end

Scraper.new.print_results
