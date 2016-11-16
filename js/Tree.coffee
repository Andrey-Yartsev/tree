class Tree
  constructor: (items, parent) ->
    @parent = parent || document.getElementsByTagName('body')[0]
    if items
      @load(items)
  load: (items) ->
    @nodes = new TreeLoad(this).load(items)
    @root = @nodes[0]
  html: ->
    @parent.innerHTML = ''
    @parent.appendChild(new NodeRender().html(@root))
  json: ->
    return JSON.stringify([@jsonR(@root)])
  jsonR: (node) ->
    json = node.getData()
    if node.children.length
      json.children = []
      for _node in node.children
        json.children.push(@jsonR(_node))
    return json
  onChange: null
  fireChangeEvent: ->
    if @onChange
      @onChange()

window.Tree = Tree