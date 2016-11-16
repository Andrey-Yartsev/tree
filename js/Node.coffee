class Node
  constructor: (@tree, @data, @parentNode) ->
    if @data.opened == undefined
      @data.opened = true
    @children = []
    if @data.id
      @id = @data.id
    else
      Node.lastId++
      @id = Node.lastId
  # returns node data in initial format
  getData: ->
    o = {
      name: @data.name
      id: @id
    }
    if !@data.opened
      o.opened = false
    return o
  getOpened: ->
    return @data.opened
#    stored = NodeStorage.get(@id)
#    if stored == null
#      return @data.opened
#    else
#      return stored
  deleteChild: (id) ->
    if !@children.length
      return
    index = -1
    for child, i in @children
      if child.id == id
        index = i
    console.log index
    if index > -1
      @children.splice(index, 1)

Node.lastId = 0
window.Node = Node