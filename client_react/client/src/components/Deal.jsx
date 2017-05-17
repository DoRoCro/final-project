import React from 'react'
import { string, number } from 'prop-types'

const Deal = (props) => (
  <div className='deal'>
    {/* <img src={`images/${props.image}`} className='deal-image' /> */}
    <div className='deal-details'>
      <h3 className='deal-title'>{props.label}</h3>
      {/* <h4 className='deal-series'>Series ({props.series})</h4> */}
      {/* <p className='deal-description'>{props.description}</p> */}
    </div>
  </div>
)

Deal.propTypes = {
  label: string.isRequired,
  start_date: string.isRequired,
  discount_rate: string.isRequired,
  money_off: string.isRequired,
  restaurant_id: number.isRequired
}
  // image: string.isRequired,
  // series: number.isRequired,

// set some defaults for dates as undefined in seed data from original project

const today = new Date().setHours(0, 0, 0, 0)
// const endDay = new Date().setHours(23, 59, 59, 999)
Deal.defaultProps = {
  start_date: today
}

export default Deal
