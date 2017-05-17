import React from 'react'
import { Link, Router } from 'react-router-dom'
// import Show from './Show'
import Deal from './Deal'

class ListingDeals extends React.Component {
  constructor (props) {
    super(props)
    this.doSearch = this.doSearch.bind(this)
    this.state = {
      searchQuery: '',
      deals: []
    }
  }

  componentDidMount () {
    var url = 'http://localhost:5000/api/deals'
    var request = new XMLHttpRequest()
    request.open('GET', url)

    request.setRequestHeader('Content-Type', 'application/json')
    request.withCredentials = true

    request.onload = () => {
      if (request.status === 200) {
        console.log('request: ', request.responseText)
        var data = JSON.parse(request.responseText)
        this.setState({ deals: data })
      } else {
        console.log("Uh oh you're not logged in!")
        this.props.history.goBack()
      }
    }
    request.send(null)
  }

  doSearch (event) {
    this.setState({searchQuery: event.target.value})
  }

  render () {
    return (
      <div className='listing'>
        <nav>
          <Link to='/' className='title'>Burger Tracker</Link>
          <input className='search-box' type='text' placeholder='Search...' value={this.state.searchQuery} onChange={this.doSearch} />
        </nav>

        <div className='shows-container'>
          {
            this.state.deals.filter((deal) => `${deal.description}`.toUpperCase().indexOf(this.state.searchQuery.toUpperCase()) >= 0)
             .map((deal) => (
               <Deal {...deal} key={deal.id} />
            ))

          }
        </div>

      </div>
    )
  }
}

export default ListingDeals
