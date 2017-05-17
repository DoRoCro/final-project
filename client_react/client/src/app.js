import React from 'react'
import ReactDOM from 'react-dom'
import Home from './components/Home'
// import Listing from './components/Listing'
import ListingDeals from './components/ListingDeals'
// import {Router, Route, IndexRoute, hashHistory} from 'react-router'
import { HashRouter, Route, IndexRoute } from 'react-router-dom'

class App extends React.Component {
  render () {
    return (
      <HashRouter>
        <div className='container'>
          <Route exact path='/' component={Home} />
          <Route path='/deals' component={ListingDeals} />
          {/*   <Route path='/restaurants' component={ListingRestaurants} />
          <Route path='/burgers' component={ListingBurgers} /> */}
        </div>
      </HashRouter>
    )
  }
}

ReactDOM.render(<App />, document.getElementById('app'))
