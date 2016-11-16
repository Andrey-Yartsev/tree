class Tree
  lastId: 0
  constructor: (items, parent) ->
    @parent = parent || document.getElementsByTagName('body')[0]
    if items
      @load(items)
  load: (items) ->
    @nodes = new TreeLoad(this).load(items)
    @root = @nodes[0]
  render: ->
    return new NodeRender().html(@root)
  html: ->
    @parent.innerHTML = ''
    @parent.appendChild(@render())
  json: ->
    return JSON.stringify(@data())
  data: ->
    return [@dataR(@root)]
  dataR: (node) ->
    data = node.getData()
    if node.children.length
      data.children = []
      for _node in node.children
        data.children.push(@dataR(_node))
    return data
  onChange: null
  fireChangeEvent: ->
    if @onChange
      @onChange()

window.Tree = Tree