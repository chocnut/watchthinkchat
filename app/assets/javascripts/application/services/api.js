angular.module('chatApp').service('api', function ($http, $q) {

  this.interaction = function (data) {
    var deferred = $q.defer();
    $http({
      method: 'post',
      url: apiUrl + '/v1/interactions',
      data: data,
      headers: {
        Authorization: 'Token token="' + window.token + '"'
      },
      timeout: 5000
    }).
        success(function(data) {
          deferred.resolve(data);
        }).
        error(function(data) {
          deferred.resolve(data);
        });
    return deferred.promise;
  };

  this.call = function (method, url, data, successFn, errorFn) {
    $http({
      method: method,
      url: apiUrl + url,
      data: data,
      headers: {
        Authorization: 'Token token="' + window.token + '"'
      },
      timeout: 5000
    }).
        success(function(data, status) {
          if(_.isFunction(successFn)){
            successFn(data, status);
          }
        }).
        error(function(data, status) {
          console.log('API ERROR: ' + status);
          if(_.isFunction(errorFn)){
            errorFn(data, status);
          }
        });
  };
});
