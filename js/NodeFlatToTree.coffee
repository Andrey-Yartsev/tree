window.NodeFlatToTree = {
  convert: (nodes) ->
    map = {}
    roots = []
    for node, i in nodes
      node.children = [];
      map[node.id] = i
      if node.parentId != 0
        nodes[map[node.parentId]].children.push(node)
      else
        roots.push(node)
    return roots
}
