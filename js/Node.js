// Generated by CoffeeScript 1.11.1
(function() {
  var Node;

  Node = (function() {
    function Node(tree, data, parentNode) {
      this.tree = tree;
      this.data = data;
      this.parentNode = parentNode;
      if (this.data.opened === void 0) {
        this.data.opened = true;
      }
      this.children = [];
      if (this.data.id) {
        this.id = this.data.id;
        if (this.id > this.tree.lastId) {
          this.tree.lastId = this.id;
        }
      } else {
        this.tree.lastId++;
        this.id = this.tree.lastId;
      }
    }

    Node.prototype.getData = function() {
      var o;
      o = {
        name: this.data.name,
        id: this.id
      };
      if (!this.data.opened) {
        o.opened = false;
      }
      return o;
    };

    Node.prototype.getOpened = function() {
      return this.data.opened;
    };

    Node.prototype.createChild = function(name) {
      var node;
      node = new Node(this.tree, {
        name: name
      }, this);
      this.children.push(node);
      this.fireChangeEvent();
      return node;
    };

    Node.prototype.updateName = function(name) {
      this.data.name = name;
      return this.fireChangeEvent();
    };

    Node.prototype["delete"] = function() {
      if (!this.parentNode) {
        throw new Error('can not remove node having no parent');
      }
      this.parentNode.deleteChild(this.id);
      return this.fireChangeEvent();
    };

    Node.prototype.deleteChild = function(id) {
      var child, i, index, j, len, ref;
      if (!this.children.length) {
        return;
      }
      index = -1;
      ref = this.children;
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        child = ref[i];
        if (child.id === id) {
          index = i;
        }
      }
      if (index > -1) {
        return this.children.splice(index, 1);
      }
    };

    Node.prototype.fireChangeEvent = function() {
      return this.tree.fireChangeEvent();
    };

    return Node;

  })();

  Node.lastId = 0;

  window.Node = Node;

}).call(this);

//# sourceMappingURL=Node.js.map
