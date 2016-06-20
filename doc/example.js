FormData = require('form-data');
fetch = require('node-fetch');
var Bulk = require('fbulk');

var q = Bulk({access_token: 'my-access-token'});
q.addCall({target: 'me'});
q.addCall({target: 'me/friends', params: {limit: 50}});
q.exec()
    .then(function(result){ console.log(result); })
    .catch(function(err){ console.error(err); });
