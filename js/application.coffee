@App ||= {}
App.FlashbackController = ($scope, $http) ->
  $scope.search = ->
    $scope.tweets = []
    $scope.loading = true
    query = $scope.query
    url = "https://search.twitter.com/search.json?" +
          "q=#{encodeURIComponent query}&rpp=500&callback=JSON_CALLBACK"
    $http.jsonp(url).
      success (response) ->
        $scope.tweets = response.results
        $scope.loading = false
