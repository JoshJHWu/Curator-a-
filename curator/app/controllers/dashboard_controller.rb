class DashboardController < ApplicationController
  def index
    # render erb
  end

  def search
    term = params[:term]

    reddit_data = call_to_Reddit(term)
    # {text:"comments", posts:[id:, body:, url:]}
    news_data = call_to_News(term)

    return {news: news_data, reddit: reddit_data}.to_json

    # return what we got in a json to the frontend
  end

  def json
    render layout: false
  end
end
