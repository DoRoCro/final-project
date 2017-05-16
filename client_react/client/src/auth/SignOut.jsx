import React from 'react'
import { Link } from 'react-router-dom'
import AjaxRequest from '../services/AjaxRequest'

class SignOut extends React.Component {
  constructor () {
    super()
    this.signOut = this.signOut.bind(this)
  }

  signOut (event) {
    // sign out request here
    const req = new AjaxRequest()

    req.delete(this.props.url, (err, status) => {
      if (err) { throw err }
      if (status === 204) { // have been logged out
        this.props.onSignOut(null)
      }
    })
  }

  render () {
    return (
      <div>
        <button onClick={this.signOut}>Sign Out</button>
        <Link className='shows-link' to='/shows'>View Shows</Link>
      </div>
    )
  }
}

export default SignOut
