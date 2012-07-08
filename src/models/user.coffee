
module.exports = DS.Model.extend
  # ##Properties
  firstName: DS.attr 'string'
  lastName: DS.attr 'string'

  # ##Computed Properties
  fullName: (()->

  ).property 'firstName','lastName'