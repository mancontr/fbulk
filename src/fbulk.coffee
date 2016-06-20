# Facebook Bulk Helper
# An aid to make Facebook API bulk requests more easily

###
Start a bulk request.
Returns an object with methods for chaining calls, and executing them.

Opts:
 - access_token: [required] The access token to use for the facebook calls.
 - headers: Whether or not to include headers in the responses. Default: false.
###
exports = module.exports = (opts = {}) ->
  calls = []

  ###
  Add a new call to the batch queue.
  Returns a promise for the result of this specific call.

  Params:
   - target: [required] The target edge.
   - method: The HTTP method for this call. Default: 'GET'.
   - params: The parameters and their values to add to the call.
   - name: A name for this call on the batch (for JSONPath references).
   - body: The body for the request, if any.
   - middleware: A function to process the result before resolving it.
      The function will receive the original result, and must return
      a promise for the processed result.
  ###
  addCall: (params) ->
    new Promise (resolve, reject) ->
      params.promise = resolve: resolve, reject: reject
      calls.push params

  ###
  Run the bulk request.
  Returns a promise for the whole processed result.
  ###
  exec: ->
    requests = calls.map (call) ->
      relative_url = call.target
      if call.params
        params = []
        for key, value of call.params
          params.push encodeURIComponent key + '=' + encodeURIComponent value
        if params.length
          relative_url += '?' + params.join '&'
      # Request JSON fragment
      relative_url: relative_url
      method: call.method or 'GET'
      name: call.name
      body: call.body

    body =
      access_token: opts.access_token
      batch: requests


    input = 'https://graph.facebook.com/'
    init =
      method: 'POST'
      body: JSON.stringify body
      include_headers: opts.headers or false

    fetch input, init
    .then (response) ->
      response.json()
    .then (data) ->
      results = calls.map (call, i) ->
        callResponse = data[i]
        if callResponse is null # Timed out
          err = new Error 'Timed out'
          call.promise.reject err
          Promise.reject err
        else
          callBody = JSON.parse callResponse.body
          if callBody.error
            err = new Error callBody.error
            call.promise.reject err
            Promise.reject err
          else
            ret = callBody
            if call.middleware
              ret = call.middleware callBody
            call.promise.resolve ret
            ret
      Promise.all results
