fbulk
=====

A simple helper library to make bulk requests to the Facebook Graph Api.

For more info on bulk requests, see [Making multiple requests](https://developers.facebook.com/docs/graph-api/making-multiple-requests)

## Installation

```
npm install fbulk --save
```

## Usage

```
Bulk = require('fbulk')
Bulk token: 'my-user-token'
.addCall target: 'me'
.addCall target: 'me/friends', params: limit: 50
.exec()
```
