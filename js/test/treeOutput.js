// Generated by CoffeeScript 1.11.1
(function() {
  var json;

  json = '[{"name":"root","id":1,"children":[{"name":"node1","id":2,"opened":false},{"name":"node2","id":3,"children":[{"name":"node2.1","id":4}]},{"name":"node3","id":5}]}]';

  if (new Tree(JSON.parse(json)).json() !== json) {
    throw new Error('json input output test failed');
  }

}).call(this);

//# sourceMappingURL=treeOutput.js.map
