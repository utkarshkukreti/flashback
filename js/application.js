// Generated by CoffeeScript 1.4.0
(function() {

  this.App || (this.App = {});

  App.FlashbackController = function($scope, $http) {
    return $scope.search = function() {
      var query, url;
      $scope.tweets = [];
      $scope.loading = true;
      query = $scope.query;
      url = "https://search.twitter.com/search.json?" + ("q=" + (encodeURIComponent(query)) + "&rpp=500&result_type=mixed&") + "callback=JSON_CALLBACK";
      return $http.jsonp(url).success(function(response) {
        var max_retweets;
        $scope.tweets = response.results;
        max_retweets = _.max($scope.tweets, function(tweet) {
          return tweet.metadata.recent_retweets;
        }).metadata.recent_retweets;
        _.each($scope.tweets, function(tweet) {
          var ratio;
          ratio = (tweet.metadata.recent_retweets || 0) / max_retweets;
          console.log(ratio);
          return tweet["class"] = ratio < 0.25 ? "one-fourth" : ratio < 0.5 ? "one-half" : ratio < 0.75 ? "three-fourths" : "one-whole";
        });
        return $scope.loading = false;
      });
    };
  };

}).call(this);
