module DashboardHelper
  def call_to_Reddit(term)
    # using search term, makes a call to 3 news subreddits/hot/.json
    # selects top 5 posts from each subreddit
    # for each post, keeps only URL to the post page
    # for each post, makes a call to the URL/.json
    # for each post, parses the JSON data to get only the comments
    # aggregates all comments in variable
    # must return text in this form: {:text=>'text'}
  end

  def call_to_News(term)
    # makes call to news API

    # must return text in this form: {:text=>'text'}
  end

  def call_to_HPE(data)
    client = HODClient.new(ENV["HPE_KEY"])

    # analyzing content
    request = client.post('extractconcepts', data)

    # analyzing sentiments
    # request = client.post('analyzesentiment', {:text=>'I like cats'})

    json_data = JSON.parse(request)
    # this is where we need to explore what data we get back and how we want to alter it for our frontend
  end
end
