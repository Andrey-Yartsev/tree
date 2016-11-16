class NodeHtml
  constructor: (@node, parentElement) ->
    @li = document.createElement('li')
    parentElement.appendChild(@li)

    @li.appendChild(document.createElement('i');)

    @span = document.createElement('span');
    @span.id = @node.id

    @span.innerHTML = @node.data.name
    @li.appendChild(@span)

    @ul = document.createElement('ul')
    @li.appendChild(@ul)

    @updateClass()

    # state
    state = @node.getOpened()
    if state != null && state == false
      @ul.style.display = 'none'

    controls = document.createElement('div');
    controls.className = 'controls';
    @li.appendChild(controls)

    # controls
    #   edit
    @btnEdit = document.createElement('a')
    @btnEdit.href = '#'
    @btnEdit.innerHTML = 'edit'
    controls.appendChild(@btnEdit)
    @btnEdit.addEventListener 'click', ((e)->
      e.preventDefault()
      @editAction()
    ).bind(this)
    #   create
    @btnCreate = document.createElement('a')
    @btnCreate.href = '#'
    @btnCreate.innerHTML = 'create'
    controls.appendChild(@btnCreate)
    @btnCreate.addEventListener 'click', ((e)->
      e.preventDefault()
      @createAction()
    ).bind(this)
    #   delete
    @btnDelete = document.createElement('a')
    @btnDelete.href = '#'
    @btnDelete.innerHTML = 'delete'
    controls.appendChild(@btnDelete)
    @btnDelete.addEventListener 'click', ((e)->
      e.preventDefault()
      @deleteAction()
    ).bind(this)

    # events
    @span.addEventListener 'click', (->
      this.toggle()
    ).bind(this)

  updateClass: ->
    className = ''
    if @node.children.length
      className += 'hasChildren'
    if @node.getOpened()
      className += ' opened'
    @li.className = className

  toggle: ->
    if @node.data.opened
      @node.data.opened = false
      @ul.style.display = 'none'
    else
      @node.data.opened = true
      @ul.style.display = 'block'
    @updateClass()
    @fireChangeEvent()

  editAction: ->
    newName = prompt('Edit node name', @node.data.name)
    if newName && newName != @node.data.name
      @node.data.name = newName
      @span.innerHTML = newName
    @fireChangeEvent()

  createAction: ->
    newName = prompt('Enter new node name')
    if !newName
      return
    node = new Node(@node.tree, {
      name: newName
    }, @node)
    @node.children.push(node)
    new NodeHtml(node, @ul)
    @node.tree.html()
    @fireChangeEvent()

  deleteAction: ->
    if @node.parentNode
      @node.parentNode.deleteChild(@node.id)
      @li.parentNode.removeChild(@li)
    @node.tree.html()
    @fireChangeEvent()

  fireChangeEvent: ->
    @node.tree.fireChangeEvent()

window.NodeHtml = NodeHtml