
get = Em.get

module.exports = DS.Adapter.extend

  # ###Public

  host: "http://#{window.location.hostname || 'localhost'}:8080/sockjs"

  find: (store, type, id) ->
    if type.isRoot and @rootID != id
      that = @
      sharejs.open id, 'json', @host, (error, doc)->
        throw error if error
        that.root = doc
        that.rootID = id

        callback = (error)->
          throw error if error

          path = that.pathForType type
          subdoc = doc.at path

          rootDoc = doc.at()
          rootDoc.on 'replace', (pos, old, newVal)->
            that.updateStore store, type, subdoc, id

          that.updateStore store, type, subdoc, id

        if !doc.snapshot
          doc.set type.defaults || {}, callback
        else
          callback()
    else if @rootID == id
      path = @pathForType type
      subdoc = @subdocAtPath path
      @updateStore store, type, subdoc, id
    else
      Em.assert('A root document needs to be open', @root)
      @watchType store, type
      path = @pathForType type
      subdoc = @subdocAtPath [path, id]
      snapshot = subdoc.get()
      snapshot.id = id
      store.load type, snapshot

  findMany: (store, type, ids) ->
    Em.assert 'Multiple root documents cannot be open at once', !type.isRoot
    for id in ids
      @find store, type, id

  findAll: (store, type) ->
    Em.assert 'Multiple root documents cannot be open at once', !!type.isRoot

  findQuery: (store, type, query, array) ->
    Em.assert 'Root documents cannot be queried', !!type.isRoot

  createRecord: (store, type, record) ->
    Em.assert 'You cannot create a root document from here', !type.isRoot
    record.set 'id', @generateIdForRecord store, record
    @saveRecord record, type, ()->
      store.didCreateRecord record, record.toJSON associations: true

  updateRecord: (store, type, record) ->
    @saveRecord record, type, ()->
      store.didUpdateRecord record, record.toJSON associations: true

  deleteRecord: (store, type, record) ->
    Em.assert 'You cannot delete a root document from here', !!type.isRoot
    path = @pathForType type
    subdoc = @subdocAtPath [path, record.get('id')]
    subdoc.remove ()->
      store.didDeleteRecord record

  # commit: (store, commitDetails)->

  #   commitDetails.updated.eachType ((type, array) ->
  #     @updateRecords store, type, array.slice()
  #   ), this
  #   commitDetails.created.eachType ((type, array) ->
  #     @createRecords store, type, array.slice()
  #   ), this
  #   commitDetails.deleted.eachType ((type, array) ->
  #     @deleteRecords store, type, array.slice()
  #   ), this

  # ###Private

  # Current root document
  root: null
  rootID: null

  watchType: (store, type)->
    path = @pathForType type
    docType = @root.at path
    that = @
    docType.on 'replace', (pos, old, newVal)->
      subdoc = that.root.at [path, pos]
      that.updateStore store, type, subdoc, pos

  updateStore: (store, type, subdoc, id)->
    snapshot = subdoc.get()
    snapshot.id = id
    store.load type, snapshot

  pathForType: (type) ->
    return type.path if type.path
    parts = type.toString().split(".")
    name = parts[parts.length - 1]
    name.replace(/([A-Z])/g, "_$1").toLowerCase().slice(1)+'s'

  subdocAtPath: (path)->
    @root.at path

  # This will need to request an ID from the server in the future to avoid
  # ID collisions
  generateIdForRecord: (store, record)->
    Em.guidFor record

  # This method takes a record and saves it at the path
  saveRecord: (record, type, cb)->
    path = @pathForType type
    subdoc = @subdocAtPath path if type.isRoot
    subdoc = @subdocAtPath [path, record.get('id')] if !type.isRoot
    json = record.toJSON associations: true
    delete json.id
    subdoc.set json, (err)->
      cb(err)

