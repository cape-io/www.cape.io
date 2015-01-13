cx = (classNames) ->
  if typeof classNames is "object"
    Object.keys(classNames).filter((className) ->
      classNames[className]
    ).join " "
  else
    Array::join.call arguments, " "
module.exports = cx
