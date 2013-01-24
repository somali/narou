# coding: utf-8
require 'nokogiri'

class NarouNovel
  attr_reader :title, :subtitle, :author, :document
  def initialize(text)
    text.gsub!(/<rp>.*?<\/rp>/,'')
    text.gsub!(/<rb>/,'｜')
    text.gsub!(/<rt>/,'《')
    text.gsub!(/<\/rt>/,'》')
    text.gsub!(/\r\n/,"\n")

    doc = Nokogiri::HTML(text)

    @title = ""
    @subtitle = ""
    @author = ""
    @document = ""

    doc.xpath('//div[@class = "novel_title"]').each do |node|
      @title << node.text
    end
    doc.xpath('//span[@class = "novel_title2"]').each do |node|
      @title << node.text
    end

    doc.xpath('//div[@class = "novel_subtitle"]').each do |node|
      @subtitle  << node.text
    end

    doc.xpath('//div[@class = "novel_writername" or @class = "novel_bar"]').each do |node|
      tmptext = node.text.match(/作者：(.*)$/)
      if tmptext != nil
        @author = tmptext[1]
      end
    end

    doc.xpath('//div[@id = "novel_view"]').each do |node|
      @document  << node.text
    end
  end
end
