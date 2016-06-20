assert = require('chai').assert
Bulk = require '../src/fbulk'

describe 'fbulk', ->
  it 'should return a exec()-able and addTask()-able object', ->
    obj = Bulk access_token: 'nice-token'
    assert.isFunction obj.addCall
    assert.isFunction obj.exec
