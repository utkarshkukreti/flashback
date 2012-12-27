@App ||= {}
App.FlashbackController = ($scope, $http) ->
  $scope.search = ->
    $scope.tweets = []
    $scope.loading = true
    query = $scope.query
    url = "https://search.twitter.com/search.json?" +
          "q=#{encodeURIComponent query}&rpp=500&result_type=mixed&" +
          "callback=JSON_CALLBACK"
    $http.jsonp(url).
      success (response) ->
        $scope.tweets = response.results

        max_retweets = _.max $scope.tweets, (tweet) ->
          tweet.metadata.recent_retweets
        .metadata.recent_retweets

        _.each $scope.tweets, (tweet) ->
          ratio = (tweet.metadata.recent_retweets || 0) / max_retweets
          console.log ratio
          tweet.class = if ratio < 0.25
                          "one-fourth"
                        else if ratio < 0.5
                          "one-half"
                        else if ratio < 0.75
                          "three-fourths"
                        else
                          "one-whole"

        $scope.loading = false
