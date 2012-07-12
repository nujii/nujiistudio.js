
module.exports = DS.FixtureAdapter.extend

  # Implement this method in order to query fixtures data
  queryFixtures: (fixtures, query) ->
    fixtures

  # Implement this method in order to provide provide json for CRUD methods
  mockJSON: (type, record) ->
    record.toJSON associations: true

  latency: 10