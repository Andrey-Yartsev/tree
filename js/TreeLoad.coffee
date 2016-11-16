class TreeLoad
  constructor: (@tree)->
  load: (items) ->
    nodes = [];
    for item in items
      node = new Node(@tree, item)
      nodes.push(node)
      if item.children
        @loadR(item.children, node)
    return nodes;
  loadR: (items, parentNode) ->
    for item in items
      node = new Node(@tree, item, parentNode)
      parentNode.children.push(node)
      if item.children
        @loadR(item.children, node)

window.TreeLoad = TreeLoad