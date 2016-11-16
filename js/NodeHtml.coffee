class NodeHtml
  constructor: (@node, parentElement) ->
    @li = document.createElement('li')
    parentElement.appendChild(@li)

    @li.appendChild(document.createElement('i');)

    @span = document.createElement('span');
    @span.id = @node.id

    @span.innerHTML = @node.data.name + '(' + @node.id + ')'
    @li.appendChild(@span)

    @ul = document.createElement('ul')
    @li.appendChild(@ul)

    @updateClass()

    # state
    state = @node.getOpened()
    if state != null && state == false
      @ul.style.display = 'none'

    @initControls()

    # events
    @span.addEventListener 'click', (->
      this.toggle()
    ).bind(this)

  initControls: ->
    # controls
    controls = document.createElement('div');
    controls.className = 'controls';
    @li.appendChild(controls)

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
    if @node.parentNode
      #   delete
      @btnDelete = document.createElement('a')
      @btnDelete.href = '#'
      @btnDelete.innerHTML = 'delete'
      controls.appendChild(@btnDelete)
      @btnDelete.addEventListener 'click', ((e)->
        e.preventDefault()
        @deleteAction()
      ).bind(this)

  updateClass: ->
    className = ''
    if @node.children.length
      className += 'hasChildren'
    if @node.getOpened()
      className += ' opened'
    @li.className = className.trim()

  toggle: ->
    if @node.data.opened
      @node.data.opened = false
      @ul.style.display = 'none'
    else
      @node.data.opened = true
      @ul.style.display = 'block'
    @updateClass()
    @node.fireChangeEvent()

  editAction: ->
    newName = prompt('Edit node name', @node.data.name)
    if newName && newName != @node.data.name
      @node.updateName(newName)
      @span.innerHTML = newName

  createAction: ->
    newName = prompt('Enter new node name')
    if !newName
      return
    new NodeHtml(@node.createChild(newName), @ul)
    @node.tree.html()

  deleteAction: ->
    if @li.parentNode
      @li.parentNode.removeChild(@li)
    @node.delete()
    @node.tree.html()

window.NodeHtml = NodeHtml