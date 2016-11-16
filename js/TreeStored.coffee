class TreeStored
  constructor: (@id, @tree) ->
    @tree.onChange = (->
      this.storeState()
    ).bind(this)
    state = @getState()
    if state
      @tree.load(state)

  storeState: ->
    #console.log @tree.json()
    localStorage.setItem('tree' + @id, @tree.json())
  getState: ->
    storedState = localStorage.getItem('tree' + @id)
    if storedState
      return JSON.parse(storedState)
    return false

window.TreeStored = TreeStored