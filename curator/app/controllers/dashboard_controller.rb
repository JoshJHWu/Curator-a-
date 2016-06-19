class DashboardController < ApplicationController
  include DashboardHelper

  def index
  end

  def search
    term = params[:term].gsub(" ", "+")

    reddit_data = call_to_Reddit(term)
    news_data = call_to_News(term)

    render json: {news: news_data, reddit: reddit_data}.to_json, layout: false
  end

  # def json
  #   @term = params[:term].gsub(" ", "+")
  #
  #   reddit_data = call_to_Reddit(@term)
  #   news_data = call_to_News(@term)
  #
  #   render json: {news: news_data, reddit: reddit_data}.to_json, layout: false
  # end
end
