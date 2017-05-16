class AjaxRequest {
  get (url, done) {
    const xhr = new XMLHttpRequest()
    xhr.withCredentials = true
    xhr.open('GET', url)

    // when request completes, do the callback passed in
    xhr.onload = () => {
      done(null, JSON.parse(xhr.response), xhr.status)
    }

    // add some error handling for unsuccessful requests (NB - 401 unauthorised in NOT an error)
    xhr.onerror = () => {
      // give the error back to the caller to deal with
      done(xhr.response)
    }
    xhr.send()
  }

  post (url, payload, done) {
    const xhr = new XMLHttpRequest()
    xhr.open('POST', url)
    xhr.setRequestHeader('Content-Type', 'application/json')
    xhr.withCredentials = true

    xhr.onload = () => {   // send the response back to caller, with error=null
      done(null, JSON.parse(xhr.response))
    }

    xhr.onerror = () => {  // send any error back to caller to deal with
      done(xhr.response)
    }

    xhr.send(payload)
  }

  delete (url, done) {
    const xhr = new XMLHttpRequest()
    xhr.open('DELETE', url)
    xhr.setRequestHeader('Content-Type', 'application/json')
    xhr.withCredentials = true

    xhr.onload = () => {
      done(null, xhr.status)
    }

    xhr.onerror = () => {
      done(xhr.response)
    }

    xhr.send()
  }
}

export default AjaxRequest
