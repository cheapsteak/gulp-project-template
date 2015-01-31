React = require('react')

module.exports = React.createFactory React.createClass
  render: ->
    <div className="rad-component">
      <p>is this component rad? {@props.rad}</p>
    </div>
