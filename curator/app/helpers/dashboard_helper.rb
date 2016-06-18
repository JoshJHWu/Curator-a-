module DashboardHelper
  def call_to_Reddit(term)
    # makes call to Reddit

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
