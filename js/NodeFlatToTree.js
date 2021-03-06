// Generated by CoffeeScript 1.11.1
(function() {
  window.NodeFlatToTree = {
    convert: function(nodes) {
      var i, j, len, map, node, roots;
      map = {};
      roots = [];
      for (i = j = 0, len = nodes.length; j < len; i = ++j) {
        node = nodes[i];
        node.children = [];
        map[node.id] = i;
        if (node.parentId !== 0) {
          nodes[map[node.parentId]].children.push(node);
        } else {
          roots.push(node);
        }
      }
      return roots;
    }
  };

}).call(this);

//# sourceMappingURL=NodeFlatToTree.js.map
