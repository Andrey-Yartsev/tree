// Generated by CoffeeScript 1.11.1
(function() {
  var NodeHtml;

  NodeHtml = (function() {
    function NodeHtml(node1, parentElement) {
      var controls, state;
      this.node = node1;
      this.li = document.createElement('li');
      parentElement.appendChild(this.li);
      this.li.appendChild(document.createElement('i'));
      this.span = document.createElement('span');
      this.span.id = this.node.id;
      this.span.innerHTML = this.node.data.name;
      this.li.appendChild(this.span);
      this.ul = document.createElement('ul');
      this.li.appendChild(this.ul);
      this.updateClass();
      state = this.node.getOpened();
      if (state !== null && state === false) {
        this.ul.style.display = 'none';
      }
      controls = document.createElement('div');
      controls.className = 'controls';
      this.li.appendChild(controls);
      this.btnEdit = document.createElement('a');
      this.btnEdit.href = '#';
      this.btnEdit.innerHTML = 'edit';
      controls.appendChild(this.btnEdit);
      this.btnEdit.addEventListener('click', (function(e) {
        e.preventDefault();
        return this.editAction();
      }).bind(this));
      this.btnCreate = document.createElement('a');
      this.btnCreate.href = '#';
      this.btnCreate.innerHTML = 'create';
      controls.appendChild(this.btnCreate);
      this.btnCreate.addEventListener('click', (function(e) {
        e.preventDefault();
        return this.createAction();
      }).bind(this));
      this.btnDelete = document.createElement('a');
      this.btnDelete.href = '#';
      this.btnDelete.innerHTML = 'delete';
      controls.appendChild(this.btnDelete);
      this.btnDelete.addEventListener('click', (function(e) {
        e.preventDefault();
        return this.deleteAction();
      }).bind(this));
      this.span.addEventListener('click', (function() {
        return this.toggle();
      }).bind(this));
    }

    NodeHtml.prototype.updateClass = function() {
      var className;
      className = '';
      if (this.node.children.length) {
        className += 'hasChildren';
      }
      if (this.node.getOpened()) {
        className += ' opened';
      }
      return this.li.className = className;
    };

    NodeHtml.prototype.toggle = function() {
      if (this.node.data.opened) {
        this.node.data.opened = false;
        this.ul.style.display = 'none';
      } else {
        this.node.data.opened = true;
        this.ul.style.display = 'block';
      }
      this.updateClass();
      return this.fireChangeEvent();
    };

    NodeHtml.prototype.editAction = function() {
      var newName;
      newName = prompt('Edit node name', this.node.data.name);
      if (newName && newName !== this.node.data.name) {
        this.node.data.name = newName;
        this.span.innerHTML = newName;
      }
      return this.fireChangeEvent();
    };

    NodeHtml.prototype.createAction = function() {
      var newName, node;
      newName = prompt('Enter new node name');
      if (!newName) {
        return;
      }
      node = new Node(this.node.tree, {
        name: newName
      }, this.node);
      this.node.children.push(node);
      new NodeHtml(node, this.ul);
      this.node.tree.html();
      return this.fireChangeEvent();
    };

    NodeHtml.prototype.deleteAction = function() {
      if (this.node.parentNode) {
        this.node.parentNode.deleteChild(this.node.id);
        this.li.parentNode.removeChild(this.li);
      }
      this.node.tree.html();
      return this.fireChangeEvent();
    };

    NodeHtml.prototype.fireChangeEvent = function() {
      return this.node.tree.fireChangeEvent();
    };

    return NodeHtml;

  })();

  window.NodeHtml = NodeHtml;

}).call(this);

//# sourceMappingURL=NodeHtml.js.map
