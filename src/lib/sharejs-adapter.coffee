get = Ember.get
set = Ember.set
# getPath = Ember.getPath

module.exports = DS.Adapter.extend
  createRecord: (store, type, record) ->
    isRootDoc = @isRootDoc type
    path = @pathForType type
    data = record.toJSON()

    if isRootDoc
      that = @
      sharejs.open path, 'json', (error, doc)->
        Ember.assert 'There was an error while saving the document '+path, error
        record._doc = doc
        @didCreateRecord store, type, record, doc.snapshot

    else
      # We need to figure out how to do this correctly
      Ember.assert 'You need to load the parent '+'
                    document before modifying this subdoc',
                    record.parentDoc
      #record.parentDoc.
      @didCreateRecord store, type, record, data

  didCreateRecord: (store, type, record, json) ->
    root = @rootForType type
    @sideload store, type, json, root
    store.didCreateRecord record, json[root]

  didCreateRecords: (store, type, records, json) ->
    root = @rootForType(type)
    @sideload store, type, json, root
    store.didCreateRecords type, records, json[root]

  updateRecord: (store, type, record) ->
    id = get record, 'id'
    root = @rootForType type
    data = record.toJSON()
    @ajax @buildURL(root, id), 'PUT',
      data: data
      context: this
      success: (json) ->
        @didUpdateRecord store, type, record, json

  didUpdateRecord: (store, type, record, json) ->
    root = @rootForType(type)
    @sideload store, type, json, root
    store.didUpdateRecord record, json and json[root]

  updateRecords: (store, type, records) ->
    return @_super(store, type, records)  if get(this, "bulkCommit") is false
    root = @rootForType(type)
    plural = @pluralize(root)
    data = {}
    data[plural] = records.map((record) ->
      record.toJSON()
    )
    @ajax @buildURL(root, "bulk"), "PUT",
      data: data
      context: this
      success: (json) ->
        @didUpdateRecords store, type, records, json

  didUpdateRecords: (store, type, records, json) ->
    root = @pluralize(@rootForType(type))
    @sideload store, type, json, root
    store.didUpdateRecords records, json[root]

  deleteRecord: (store, type, record) ->
    id = get(record, "id")
    root = @rootForType(type)
    @ajax @buildURL(root, id), "DELETE",
      context: this
      success: (json) ->
        @didDeleteRecord store, type, record, json

  didDeleteRecord: (store, type, record, json) ->
    @sideload store, type, json  if json
    store.didDeleteRecord record

  deleteRecords: (store, type, records) ->
    return @_super(store, type, records)  if get(this, "bulkCommit") is false
    root = @rootForType(type)
    plural = @pluralize(root)
    data = {}
    data[plural] = records.map((record) ->
      get record, "id"
    )
    @ajax @buildURL(root, "bulk"), "DELETE",
      data: data
      context: this
      success: (json) ->
        @didDeleteRecords store, type, records, json

  didDeleteRecords: (store, type, records, json) ->
    @sideload store, type, json  if json
    store.didDeleteRecords records

  find: (store, type, id) ->
    root = @rootForType(type)
    @ajax @buildURL(root, id), "GET",
      success: (json) ->
        @sideload store, type, json, root
        store.load type, json[root]

  findMany: (store, type, ids) ->
    root = @rootForType(type)
    plural = @pluralize(root)
    @ajax @buildURL(root), "GET",
      data:
        ids: ids

      success: (json) ->
        @sideload store, type, json, plural
        store.loadMany type, json[plural]

  findAll: (store, type) ->
    root = @rootForType(type)
    plural = @pluralize(root)
    @ajax @buildURL(root), "GET",
      success: (json) ->
        @sideload store, type, json, plural
        store.loadMany type, json[plural]

  findQuery: (store, type, query, recordArray) ->
    root = @rootForType(type)
    plural = @pluralize(root)
    @ajax @buildURL(root), "GET",
      data: query
      success: (json) ->
        @sideload store, type, json, plural
        recordArray.load json[plural]

  plurals: {}
  pluralize: (name) ->
    @plurals[name] or name + "s"

  rootForType: (type) ->
    return type.url  if type.url
    parts = type.toString().split(".")
    name = parts[parts.length - 1]
    name.replace(/([A-Z])/g, "_$1").toLowerCase().slice 1

  ajax: (url, type, hash) ->
    hash.url = url
    hash.type = type
    hash.dataType = "json"
    hash.contentType = "application/json; charset=utf-8"
    hash.context = this
    hash.data = JSON.stringify(hash.data)  if hash.data and type isnt "GET"
    jQuery.ajax hash

  sideload: (store, type, json, root) ->
    sideloadedType = undefined
    mappings = undefined
    loaded = {}
    loaded[root] = true
    for prop of json
      continue  unless json.hasOwnProperty(prop)
      continue  if prop is root
      sideloadedType = type.typeForAssociation(prop)
      unless sideloadedType
        mappings = get(this, "mappings")
        Ember.assert "Your server returned a hash with the key " +
                      prop +
                      " but you have no mappings", !!mappings
        sideloadedType = get(mappings, prop)
        if typeof sideloadedType is "string"
          sideloadedType = getPath(window, sideloadedType)
        Ember.assert "Your server returned a hash with the key " +
                      prop +
                      " but you have no mapping for it", !!sideloadedType
      @sideloadAssociations store, sideloadedType, json, prop, loaded

  sideloadAssociations: (store, type, json, prop, loaded) ->
    loaded[prop] = true
    get(type, "associationsByName").forEach ((key, meta) ->
      key = meta.key or key
      key = @pluralize(key)  if meta.kind is "belongsTo"
      if json[key] and not loaded[key]
        @sideloadAssociations store, meta.type, json, key, loaded
    ), this
    @loadValue store, type, json[prop]

  loadValue: (store, type, value) ->
    if value instanceof Array
      store.loadMany type, value
    else
      store.load type, value

DS.Adapter.extend

  root: null

  find: (store, type, id) ->
    Ember.assert('A root document needs to be open', @root) if not type.isRoot
    path = @pathForIDAndType id, type

  findMany: (store, type, ids) ->
    Ember.assert 'Multiple root documents cannot be open at once', !!type.isRoot

  findAll: (store, type) ->
    Ember.assert 'Multiple root documents cannot be open at once', !!type.isRoot

  findQuery: (store, type, query, array) ->
    Ember.assert 'Root documents cannot be queried', !!type.isRoot

  createRecord: (store, type, record) ->
    Ember.assert 'You cannot create a root document from here', !!type.isRoot
    fixture = @mockJSON(type, record)
    fixture.id = @generateIdForRecord(store, record)
    @simulateRemoteCall (->
      store.didCreateRecord record, fixture
    ), store, type, record

  updateRecord: (store, type, record) ->
    fixture = @mockJSON(type, record)
    @simulateRemoteCall (->
      store.didUpdateRecord record, fixture
    ), store, type, record

  deleteRecord: (store, type, record) ->
    @simulateRemoteCall (->
      store.didDeleteRecord record
    ), store, type, record