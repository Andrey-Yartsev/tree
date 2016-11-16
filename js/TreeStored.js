// Generated by CoffeeScript 1.11.1
(function() {
  var TreeStored;

  TreeStored = (function() {
    function TreeStored(id1, tree) {
      var state;
      this.id = id1;
      this.tree = tree;
      this.tree.onChange = (function() {
        return this.storeState();
      }).bind(this);
      state = this.getState();
      if (state) {
        this.tree.load(state);
      }
    }

    TreeStored.prototype.storeState = function() {
      return localStorage.setItem('tree' + this.id, this.tree.json());
    };

    TreeStored.prototype.getState = function() {
      var storedState;
      storedState = localStorage.getItem('tree' + this.id);
      if (storedState) {
        return JSON.parse(storedState);
      }
      return false;
    };

    return TreeStored;

  })();

  TreeStored.clean = function(id) {
    return localStorage.removeItem('tree' + id);
  };

  window.TreeStored = TreeStored;

}).call(this);

//# sourceMappingURL=TreeStored.js.map
