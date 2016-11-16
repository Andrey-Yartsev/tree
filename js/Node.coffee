class Node
  constructor: (@tree, @data, @parentNode) ->
    if @data.opened == undefined
      @data.opened = true
    @children = []
    if @data.id
      @id = @data.id
      if @id > @tree.lastId
        @tree.lastId = @id
    else
      @tree.lastId++
      @id = @tree.lastId
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
  createChild: (name) ->
    node = new Node(@tree, {
      name: name
    }, @)
    @children.push(node)
    @fireChangeEvent()
    return node
  updateName: (name) ->
    @data.name = name
    @fireChangeEvent()
  delete: ->
    if !@parentNode
      throw new Error('can not remove node having no parent')
    @parentNode.deleteChild(@id)
    @fireChangeEvent()
  deleteChild: (id) ->
    if !@children.length
      return
    index = -1
    for child, i in @children
      if child.id == id
        index = i
    if index > -1
      @children.splice(index, 1)
  fireChangeEvent: ->
    @tree.fireChangeEvent()

Node.lastId = 0
window.Node = Node