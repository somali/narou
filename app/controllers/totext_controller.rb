# -*- encoding: UTF-8 -*-
require 'httpclient'
require 'uri'
require './lib/narou.rb'

class TotextController < ApplicationController
  def index
  end

  def show
#   begin
      text = HTTPClient.new.get_content(params[:dest])
#   rescue
    # URLが間違ってたりしてエラーだった場合の対応が必要
    # どうやってどうやって表示すればいいかわかんないわー。
    # いっそこのままとかー。orz
#     redirect_to :back
#     return
#   end

    text.force_encoding("UTF-8")  # NKF.guess(text)

    @novel = NarouNovel.new(text)

    uri = URI.parse(params[:dest])
    @docname = uri.path.gsub(/\//,"_") + ".txt"
    @ibstr = "?title=" +URI.escape(@novel.title) + "&author=" + URI.escape(@novel.author)

    $novel_g = @novel
  end

  def item
    @novel = $novel_g
# Global変数とかやだなにそれー。なんか方法ないのかな。

    newstr = @novel.title << "\n"
    newstr << @novel.subtitle << "\n"
    newstr << @novel.author << "\n"
    newstr << "\n"
    newstr << @novel.document << "\n"

    @ibtr2 = @novel.title
    render :text => newstr
  end
end
