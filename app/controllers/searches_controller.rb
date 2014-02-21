require 'instagram'

class SearchesController < ApplicationController
  def index
  end

  def create
    @instagram_results = Instagram.tag_recent_media(params[:search])
  end
end
