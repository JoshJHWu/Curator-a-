class DashboardController < ApplicationController
  include DashboardHelper

  def index
  end

  def search
    @term = params[:term].gsub(" ", "+")

    reddit_data = call_to_Reddit(@term)
    news_data = call_to_News(@term)

    # return what we got in a json to the frontend
    redirect_to json_path(term: @term)
  end

  def json
    @term = params[:term]
    news = call_to_News(@term)
    reddit = call_to_Reddit(@term)
    render json: {news: news, reddit: reddit}.to_json, layout: false
  end
end
