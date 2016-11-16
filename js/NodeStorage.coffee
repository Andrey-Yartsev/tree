window.NodeStorage = {
  set: (id, state) ->
    localStorage.setItem(id, state)
  get: (id) ->
    v = localStorage.getItem(id)
    if v == null
      return null
    else
      return !!parseInt(v)
}

window.NodeStorage = NodeStorage