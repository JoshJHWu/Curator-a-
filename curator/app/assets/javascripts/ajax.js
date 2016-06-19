var partialRequest = function(newsInfo, redditInfo, redditArray, newsArray) {
	$.ajax({
		type: "get",
	  url: "/html",
	  data: $(this).serialize()
	}).done(function(partialResults) {
		$(".yielded-index").html(partialResults);
		$("#reddit-cloud").jQCloud(redditArray);
		$("#nyt-cloud").jQCloud(newsArray);
		for(i = 0; i < redditInfo.length; i++) {
			$("#reddit-card-action ul").append("<li><a href=" + redditInfo[i].url + "></a></li>");
			$("#reddit-card-action ul li").eq(i).children().text(redditInfo[i].title);
		};
		for(i = 0; i < newsInfo.length; i++) {
			$("#news-card-action ul").append("<li><a href=" + newsInfo[i].url + "></a></li>");
			$("#news-card-action ul li").eq(i).children().text(newsInfo[i].title); 
		};
	});
};

$(document).ready(function() {

	var newsInfo;
	var redditUrls;

	$("body").on("submit", "form", function() {
  	$(".yielded-index").html("Loading...");
			event.preventDefault();
			$.ajax({
	      type: "get",
	      url: "/search",
	      data: $(this).serialize(),
	      datatype: 'json'
	    }).done(function(results) {
    		newsInfo = results.news.posts;
    		redditInfo = results.reddit.posts;
    		redditArray = results.reddit.array;
    		newsArray = results.news.array;
	    	console.log(results);
	    	partialRequest(newsInfo, redditInfo, redditArray, newsArray);
	    });
	});
});