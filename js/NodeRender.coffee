class NodeRender
  html: (node) ->
    ul = document.createElement('ul')
    @htmlR(node, ul)
    return ul
  htmlR: (node, parentElement) ->
    nodeHtml = new NodeHtml(node, parentElement)
    for child in node.children
      @htmlR(child, nodeHtml.ul)

window.NodeRender = NodeRender