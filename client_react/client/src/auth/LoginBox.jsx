import React from 'react'
import SignIn from './SignIn'
import SignUp from './SignUp'
import SignOut from './SignOut'
import AjaxRequest from '../services/AjaxRequest'

class LoginBox extends React.Component {
  constructor (props) {
    super(props)
    this.setUser = this.setUser.bind(this)
    this.state = {
      currentUser: null
    }
  }

  setUser (user) {
    this.setState({currentUser: user, favlist: []})
  }

  fetchUser () {
    // Fetch current user here
    const req = new AjaxRequest()
    req.get(`${this.props.url}users.json`, (err, user, status) => {
      if (err) { throw err }

      console.log('User = ', user)

      if (status === 200) {
        this.setState({
          currentUser: user
        })
      } else if (status === 401) {
        this.setUser(null)
      }
    })
  }

  componentDidMount () {
    this.fetchUser()
  }

  render () {
    var mainDiv = <div>
      <h4> Please Sign In/Up </h4>
      <SignIn url={this.props.url + 'users/sign_in.json'} onSignIn={this.setUser} />
      <SignUp url={this.props.url + 'users.json'} onSignUp={this.setUser} />
    </div>
    if (this.state.currentUser) {
      mainDiv = <div>
        <h4> Welcome {this.state.currentUser.email}</h4>
        <SignOut url={this.props.url + 'users/sign_out.json'} onSignOut={this.setUser} />
      </div>
    }
    return (
      <div>
        { mainDiv }
      </div>
    )
  }
}

export default LoginBox
