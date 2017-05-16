import React from 'react'
import { Link, Router } from 'react-router-dom'
import Show from './Show'

class Listing extends React.Component {

  constructor(props) {
    super(props)
    this.doSearch = this.doSearch.bind(this)
    this.state = { 
      searchQuery: '', 
      shows: [] 
    }
  }

  componentDidMount(){
    var url = 'http://localhost:5000/api/shows'
    var request = new XMLHttpRequest()
    request.open('GET', url)

    request.setRequestHeader('Content-Type', "application/json")
    request.withCredentials = true

    request.onload = () => {
       if(request.status === 200){
        console.log("request: ", request.responseText)
        var data = JSON.parse(request.responseText)
        this.setState( { shows: data } )
       } else{
        console.log("Uh oh you're not logged in!")
        this.props.history.goBack()
       }
    }
    request.send(null)
  }

  doSearch(event){
    this.setState({searchQuery: event.target.value})
  }

  render(){
    return(
      <div className="listing">
        <nav>
          <Link to='/' className='title'>notflix</Link>
          <input className='search-box' type='text' placeholder='Search...' value={this.state.searchQuery} onChange={this.doSearch} />
        </nav>

        <div className='shows-container'>
          {
            this.state.shows.filter((show) => `${show.title} ${show.description}`.toUpperCase().indexOf(this.state.searchQuery.toUpperCase()) >= 0)
             .map((show) => (
              <Show { ...show } key={show.programmeID}/>
            ))

          }
        </div>
      
      </div>
    )
  }

}

export default Listing