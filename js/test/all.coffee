json = '[{"name":"root","id":1,"children":[{"name":"node1","id":2,"opened":false},{"name":"node2","id":3,"children":[{"name":"node2.1","id":4}]},{"name":"node3","id":5}]}]'

describe "Tree and nodes core functionality tests", ->
  it "compares json input and output", ->
    expect(new Tree(JSON.parse(json)).json()).toBe(json)
  it "root node loaded with no children", ->
    expect(new Tree([{name: 'a1'}]).root.children.length).toBe(0)
  it "root node loaded with 1 child", ->
    expect(new Tree([{name: 'a1', children: [{name: 'a2'}]}]).root.children.length).toBe(1)
  it "root node has ID=1", ->
    tree = new Tree([{name: 'root'}])
    expect(tree.root.id).toBe(1)
  it "new node creates with next ID=2", ->
    tree = new Tree([{name: 'root'}])
    expect(tree.root.createChild('sub').id).toBe(2)
  it "new node creates with next ID=2 if root node ID is static", ->
    tree = new Tree([{name: 'root', id: 1}])
    expect(tree.root.createChild('sub').id).toBe(2)
  it "root node children has changed after node removing", ->
    tree = new Tree([{name: 'root', children: [{name: 'a'}]}])
    tree.root.children[0].delete()
    expect(tree.root.children.length).toBe(0)
  it "tree data has changed after node removing", ->
    tree = new Tree([{name: 'root', id: 1, children: [{name: 'a'}]}])
    tree.root.children[0].delete()
    expect(tree.json()).toBe('[{"name":"root","id":1}]')

describe "Storage tests", ->
  it "Data has restored successfully after create, update & delete node", ->
    TreeStored.clean('abc') # cleanup storage
    # create check
    treeStored = new TreeStored('abc', new Tree([{name: 'root'}]))
    treeStored.tree.root.createChild('sub') # stores on create
    treeStored = new TreeStored('abc', new Tree([{name: 'root'}]))  # recreate tree from storage
    expect(treeStored.tree.data()[0].children[0].name).toBe('sub')
    # update check
    treeStored = new TreeStored('abc', new Tree([{name: 'root'}]))
    treeStored.tree.root.children[0].updateName('subNew')
    treeStored = new TreeStored('abc', new Tree([{name: 'root'}]))  # recreate tree from storage
    expect(treeStored.tree.data()[0].children[0].name).toBe('subNew')
    # delete check
    treeStored = new TreeStored('abc', new Tree([{name: 'root'}]))
    treeStored.tree.root.children[0].delete()
    treeStored = new TreeStored('abc', new Tree([{name: 'root'}]))  # recreate tree from storage
    expect(treeStored.tree.data()[0].children).toBe(undefined)

simulateEventFire = (el, etype) ->
  if el.fireEvent
    el.fireEvent('on' + etype)
  else
    evObj = document.createEvent('Events')
    evObj.initEvent(etype, true, false)
    el.dispatchEvent(evObj)

makePreviewContainer = () ->
  div = document.createElement('div');
  # document.getElementsByTagName('body')[0].appendChild(div) # uncomment for preview
  return div

describe "Interface tests", ->
  it "Has 'opened' class in LI element on node toggle", ->
    tree = new Tree([{name: 'root', children: [{name: 'a'}]}])
    rootElement = tree.render()
    expect(rootElement.getElementsByTagName('li')[0].className).toBe('hasChildren opened')
    #makePreviewContainer().appendChild(rootElement)
  it "No 'opened' class in LI element on node toggle", ->
    tree = new Tree([{name: 'root', children: [{name: 'a'}]}], makePreviewContainer())
    tree.html()
    simulateEventFire(tree.parent.getElementsByTagName('span')[0], 'click')
    expect(tree.parent.getElementsByTagName('li')[0].className).toBe('hasChildren')
  it "No 'hasChildren' class in LI element on child delete & no opened on toggle", ->
    tree = new Tree([{name: 'root', children: [{name: 'a'}]}], makePreviewContainer())
    tree.html()
    # getting delete button
    li = tree.parent.getElementsByTagName('li')[1]
    deleteBtn = li.getElementsByTagName('a')[2]
    # click on delete button
    simulateEventFire(deleteBtn, 'click')
    expect(tree.parent.getElementsByTagName('li')[0].className).toBe('opened')
    # toggle
    simulateEventFire(tree.parent.getElementsByTagName('span')[0], 'click')
    expect(tree.parent.getElementsByTagName('li')[0].className).toBe('')