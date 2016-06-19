class DashboardController < ApplicationController
  def index
    # render erb
  end

  def search
    term = params[:term]

    reddit_data = call_to_Reddit(term)
    news_data = call_to_News(term)

    json = {news: news_data, reddit: reddit_data}

    # return what we got in a json to the frontend
  end
end
