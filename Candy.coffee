###!

Candy JS
~ Simple Javascript Library

###

do (window) ->
  document = window.document
  push = [].push
  slice = [].slice
  splice = [].splice
  forEach = [].forEach
  # handle the use of $(...)

  candy = (selector) ->
    # auto-create new instance without the 'new' keyword
    if !(this instanceof candy)
      return new candy(selector)
    # no selector, return empty candy object
    if !selector
      return this
    # already a candy object
    if selector instanceof candy
      return selector
    # already a dom element?
    if selector.nodeType
      @[0] = selector
      @length = 1
      return this
    # is css selector, query the dom
    if typeof selector == 'string'
      # find elements, turn NodeList to array and push them to candy
      return push.apply(this, slice.call(document.querySelectorAll(selector)))
    # it's a function, call it when DOM is ready
    if typeof selector == 'function'
      return candy(document).ready(selector)
    return

  candy.prototype =
    length: 0
    ready: (callback) ->
      # first check if already loaded
      if /t/.test(document.readyState)
        callback candy
        # listen when it loads
      else
        document.addEventListener 'DOMContentLoaded', (->
          callback candy
          return
        ), false
      return
    each: (callback) ->
      forEach.call this, (el, i) ->
        callback.call el, i, el
        return
      return
    text: (value) ->
      1
    httpGet: (url) ->
      output = undefined
      xmlhttp = undefined
      xmlhttp = undefined
      @url = url
      if window.XMLHttpRequest
        xmlhttp = new XMLHttpRequest
      else
        xmlhttp = new ActiveXObject('Microsoft.XMLHTTP')

      xmlhttp.onreadystatechange = ->
        if xmlhttp.readyState == XMLHttpRequest.DONE
          if xmlhttp.status == 200
            document.getElementById('myDiv').innerHTML = xmlhttp.responseText
          else if xmlhttp.status == 400
            alert 'There was an error 400'
          else
            console.log 'Error something else other than 200 was returned'
        return

output = xmlhttp.open('GET', @url, true)
      xmlhttp.send()
      output
    shuffle: (contents) ->
      output = undefined
      @contents = contents
      output = @contents[Math.floor(Math.random() * @contents.length)]
      output
    rand: (arg, arg_2) ->
      output = undefined
      output = Math.floor(Math.random() * (arg - arg_2 + 1)) + arg_2
      output
    toVar: (arg, contains) ->
      @arg = arg
      @contains = contains
      window[arg] = contains
      return
    write: (arg, arg2) ->
      `var w`
      w = undefined
      w = undefined
      if @arg2 == true
        console.log @arg
      else if @arg2 == undefined
        w = document.createElement('div')
        w.textContent = @arg
        document.body.appendChild w
      else
        w = document.createElement('div')
        w.textContent = @arg
        document.body.appendChild w
      return
    time: ->
      ampm = undefined
      candy_time = undefined
      d = undefined
      hour = undefined
      min = undefined
      d = new Date
      hour = if d.getHours() == 0 then 12 else if d.getHours() > 12 then d.getHours() - 12 else d.getHours()
      min = if d.getMinutes() < 10 then '0' + d.getMinutes() else d.getMinutes()
      ampm = if d.getHours() < 12 then 'AM' else 'PM'
      candy_time = hour + ':' + min + ' ' + ampm
      candy_time
    contains: (array, value) ->
      @array = array
      @value = value
      if @array.indexOf(@value) != -1
        true
      else
        false
    newList: (items, tags) ->
      i = undefined
      listContainer = undefined
      listData = undefined
      listElement = undefined
      listItem = undefined
      numberOfListItems = undefined
      @tags = tags
      @items = items
      listData = @items
      listContainer = document.createElement('div')
      document.getElementsByTagName('body')[0].appendChild listContainer
      listElement = document.createElement(@tags[0])
      listContainer.appendChild listElement
      numberOfListItems = listData.length
      i = 0
      while i < numberOfListItems
        listItem = document.createElement(@tags[1])
        listItem.innerHTML = listData[i]
        listElement.appendChild listItem
        ++i
      return
    getIP: ->
      '<!--#echo var="REMOTE_ADDR"-->'
  # abbreviate "prototype" to "fn"
  Candy = candy.prototype
  # just to have an array like instanceof candy object
  candy::splice = splice
  # expose to global object
  window.candy = window.$ = candy
  return

# ---
# generated by js2coffee 2.1.0
