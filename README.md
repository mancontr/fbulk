fbulk
=====

A simple helper library to make bulk requests to the Facebook Graph Api.

For more info on bulk requests, see [Making multiple requests](https://developers.facebook.com/docs/graph-api/making-multiple-requests)

## Installation

```
npm install fbulk --save
```

Note that this library needs support for Promise and Fetch APIs.

## Usage

```
Bulk = require('fbulk')
q = Bulk access_token: 'my-user-token'
q.addCall target: 'me'
q.addCall target: 'me/friends', params: limit: 50
q.exec()
```
