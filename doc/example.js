Bulk = require('fbulk');
q = Bulk({access_token: 'my-access-token'});
q.addCall({target: 'me'});
q.addCall({target: 'me/friends', params: {limit: 50}});
q.exec();
