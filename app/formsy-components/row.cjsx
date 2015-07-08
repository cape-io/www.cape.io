React = require('react')

module.exports = React.createClass
  propTypes:
    label: React.PropTypes.string
    required: React.PropTypes.bool
    hasErrors: React.PropTypes.bool
    fakeLabel: React.PropTypes.bool
    layout: React.PropTypes.oneOf([
      'horizontal'
      'vertical'
      'elementOnly'
    ])
    htmlFor: React.PropTypes.string

  getDefaultProps: ->
    {
      label: ''
      required: false
      hasErrors: false
      fakeLabel: false
    }

  renderLabel: ->
    if @props.layout == 'elementOnly'
      return ''
    labelWrapper = []
    labelWrapper.push 'control-label'
    if @props.layout == 'horizontal'
      labelWrapper.push 'col-sm-3'

    if @props.fakeLabel
      label =
        <div className={labelWrapper.join(' ')}>
          <strong>
            {this.props.label}
            {this.props.required ? ' *' : null}
          </strong>
        </div>
    else
      label =
        <label className={labelWrapper.join(' ')} htmlFor={this.props.htmlFor}>
          {this.props.label}
          {this.props.required ? ' *' : null}
        </label>
    return label

  render: ->
    {layout, children} = @props

    if layout == 'elementOnly'
      return <span>{this.props.children}</span>

    classNames =
      formGroup: [ 'form-group' ]
      elementWrapper: []
    if @props.layout == 'horizontal'
      classNames.elementWrapper.push 'col-sm-9'
    if @props.hasErrors
      classNames.formGroup.push 'has-error'
      classNames.formGroup.push 'has-feedback'
    element = @props.children
    if @props.layout == 'horizontal'
      element =
        <div className={classNames.elementWrapper.join(' ')}>
          {this.props.children}
        </div>
    <div className={classNames.formGroup.join(' ')}>
      {this.renderLabel()}
      {element}
    </div>
