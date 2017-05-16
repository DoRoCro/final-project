import React from 'react'
import AjaxRequest from '../services/AjaxRequest'

class SignUp extends React.Component {
  constructor (props) {
    super(props)
    this.signUp = this.signUp.bind(this)
    this.handleOnChangeEmail = this.handleOnChangeEmail.bind(this)
    this.handleOnChangePassword = this.handleOnChangePassword.bind(this)
    this.handleOnChangePassConf = this.handleOnChangePassConf.bind(this)
    this.state = {
      email: '',
      password: '',
      passwordConfirmation: ''
    }
  }

  signUp (event) {
    // sign up request here, called when form is submitted
    event.preventDefault()   // stop the form POSTing as HTML
    const req = new AjaxRequest()    // create a new request
    // create object to send with the request
    const data = {
      user: {
        email: this.state.email,
        password: this.state.password,
        password_confirmation: this.state.password_confirmation
      }
    }
    req.post(this.props.url, JSON.stringify(data), (err, res) => {  // send the request
      console.log('Response = ', res)
    })
  }

  handleOnChangeEmail (event) {
    this.setState({email: event.target.value})
  }

  handleOnChangePassword (event) {
    this.setState({password: event.target.value})
  }

  handleOnChangePassConf (event) {
    this.setState({passwordConfirmation: event.target.value})
  }

  render () {
    return (
      <form onSubmit={this.signUp} className='login-form'>
        <input type='text' onChange={this.handleOnChangeEmail} placeholder='Email' />
        <input type='password' onChange={this.handleOnChangePassword} placeholder='Password' />
        <input type='password' onChange={this.handleOnChangePassConf} placeholder='Password Confirmation' />

        <button onClick={this.signUp}>  Sign Up </button>
      </form>
    )
  }
}

export default SignUp
