class TreeStored
  constructor: (@id, @tree) ->
    @tree.onChange = (->
      this.storeState()
    ).bind(this)
    state = @getState()
    if state
      @tree.load(state)
  storeState: ->

    localStorage.setItem('tree' + @id, @tree.json())
  getState: ->
    storedState = localStorage.getItem('tree' + @id)
    if storedState
      return JSON.parse(storedState)
    return false

TreeStored.clean = (id) ->
  localStorage.removeItem('tree' + id)

window.TreeStored = TreeStored