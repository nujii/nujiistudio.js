module.exports = DS.Model.extend

  _version: DS.attr 'string'
  
  # Used as a workaround for bug
  # [#329](https://github.com/emberjs/data/issues/329)
  changeVersion: ()->
    @set '_version', require('lib/util').guidGenerator()

  addRelObject: (Klass, defaults, relationProperty, reverseProperty)->
    newObj = Klass.createRecord(defaults)
    newObj.set(reverseProperty, @)
    @get(relationProperty).pushObject newObj
    # TODO: remove this once the bug is fixed
    @changeVersion()
    newObj
    # @get(relationProperty).createRecord defaults