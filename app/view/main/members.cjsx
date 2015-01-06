React = require 'react'

module.exports = React.createClass
  render: ->
    {members} = @props.data

    MemberRows = for member, i in members
      {firstname, lastname, position, bars} = member
      key = firstname+lastname

      BarList = for bar, i in bars
        {name, url} = bar

        <li key={name}>
          <a href={url}>{name}</a>
        </li>

      <tr className="member" key={key}>
        <td><p>
          <span className="fname">{firstname}</span> <span className="lname">{lastname}</span>
        </p></td>
        <td><p>{position}</p></td>
        <td><ul>
          {BarList}
        </ul></td></tr>

    <section id="instagram">
      <h3>Members</h3>
      <table id="bbg">
        <thead>
          <tr>
            <th className="views-align-left">Member</th>
            <th></th>
            <th className="views-align-left">Bar</th>
          </tr>
        </thead>
        <tbody>
          {MemberRows}
        </tbody>
      </table>
    </section>
