import React from 'react'
import { string, number } from 'prop-types'

const Deal = (props) => (
  <div className='deal'>
    <img src={`images/${props.image}`} className='deal-image' />
    <div className='deal-details'>
      <h3 className='deal-title'>{props.title}</h3>
      <h4 className='deal-series'>Series ({props.series})</h4>
      <p className='deal-description'>{props.description}</p>
    </div>
  </div>
)

Deal.propTypes = {
  title: string.isRequired,
  image: string.isRequired,
  series: number.isRequired,
  description: string.isRequired
}

export default Deal
