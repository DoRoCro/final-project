import React from 'react'
import AjaxRequest from '../services/AjaxRequest'

class SignIn extends React.Component {
  constructor (props) {
    super(props)
    this.handleOnChangeEmail = this.handleOnChangeEmail.bind(this)
    this.handleOnChangePassword = this.handleOnChangePassword.bind(this)
    this.signIn = this.signIn.bind(this)
    this.state = {
      email: '',
      password: ''
    }
  }

  handleOnChangeEmail (event) {
    this.setState({email: event.target.value})
  }

  handleOnChangePassword (event) {
    this.setState({password: event.target.value})
  }

  signIn (event) {
    // sign in request here
    // sign up request here, called when form is submitted
    // event.preventDefault()   // stop the form POSTing as HTML
    const req = new AjaxRequest()    // create a new request
    // create object to send with the request
    const data = {
      user: {
        email: this.state.email,
        password: this.state.password
      }
    }
    req.post(this.props.url, JSON.stringify(data), (err, res) => {  // send the request
      console.log('Response = ', res)
      console.log('err = ', err)
      if (!res.error) {
        // call method passed down in props
        this.props.onSignIn(res)
      }
    })
  }

  render () {
    return (
      <form className='login-form' >
        <input type='text' onChange={this.handleOnChangeEmail} placeholder='Email' />
        <input type='password' onChange={this.handleOnChangePassword} placeholder='Password' />
        <button onClick={this.signIn}>  Sign In </button>
      </form>
    )
  }
}

export default SignIn
