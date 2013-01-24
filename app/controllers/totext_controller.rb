# -*- encoding: UTF-8 -*-
require 'httpclient'
require 'nkf'
require 'uri'
require './lib/narou.rb'

class TotextController < ApplicationController
  def index
  end

  def show
    text = HTTPClient.new.get_content(params[:dest])
    # URLが間違ってたりしてエラーだった場合の対応が必要
    text.force_encoding(NKF.guess(text))
    # UTF-8じゃなかった場合の変換を入れる。

    @docname = "testext.txt"
    @ibstr = ""

    novel = NarouNovel.new(text)

    testfile = File.open("./public/" + @docname, "w")
    testfile.puts(novel.title)
    testfile.puts(novel.subtitle)
    testfile.puts(novel.author)
    testfile.puts
    testfile.puts(novel.document)
    testfile.close

    @title = novel.title
    @author = novel.author
    @ibstr = "?title=" +URI.escape(novel.title) + "&author=" + URI.escape(novel.author)
  end
end
