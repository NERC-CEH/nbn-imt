define [
  "backbone",
  "cs!models/HabitatLayer",
  "cs!models/SiteBoundaryLayer",
  "cs!models/SingleSpeciesLayer"
  "cs!models/DatasetSpeciesDensityLayer"
  "cs!models/DesignationSpeciesDensityLayer"
], (Backbone, HabitatLayer, SiteBoundaryLayer, SingleSpeciesLayer, DatasetSpeciesDensityLayer, DesignationSpeciesDensityLayer) -> Backbone.Collection.extend
  model: (attr, options)->
    switch attr.entityType
      when "habitatdataset"       then return new HabitatLayer attr, options
      when "site boundarydataset" then return new SiteBoundaryLayer attr, options
      when "taxon"                then return new SingleSpeciesLayer attr, options
      when "taxondataset"         then return new DatasetSpeciesDensityLayer attr, options
      when "designation"          then return new DesignationSpeciesDensityLayer attr, options

  ###
  Internal state, just a place to store the autoResolution 
  for this Layers collection
  ###
  state : new Backbone.Model
    autoResolution: "10km"
    maxResolution: "10km"

  initialize: ->
    #When a layer is added, synchronize that layer to this layers state
    syncAllLayers = => @forEach (layer) => @_syncLayer(layer) 
    @on "add", @_addOtherTypes
    @on "add", @_syncLayer
    @on "reset", syncAllLayers
    @listenTo @state, "change", syncAllLayers

  ###
  Moves an existing element in the the collection from position index 
  to newPosition. Any "position" listeners of this instance will be 
  notified with the arguments: 
    model - the model which moved
    collection - this Layers instance
    newPosition - the new position of the model
    oldPosition - the position the model was in
  ###
  position: (index, newPosition) ->
    toMove = (@models.splice index, 1)[0]
    @models.splice newPosition, 0, toMove
    @trigger "position", toMove, @, newPosition, index

  ###
  Lets mapping views notify when the mapping resolution level has changed.
  The resolution level dictates which autoResolution and which resolutions
  are viewable in the map. This method will notify the relevant Layers
  of these changes and disable/reenable the Layers of this collection
  ###
  setResolution: (resolution) ->
    @state.set "autoResolution", 
      if 20 > resolution then '100m'
      else if 155 > resolution then '1km'
      else if 310 > resolution then '2km'
      else '10km'

    @state.set "maxResolution",
      if 40 > resolution then '100m'
      else if 350 > resolution then '1km'
      else if 1300 > resolution then '2km'
      else if 6000 > resolution then '10km'
      else 'Polygon'

  _syncLayer: (layer) -> layer.set @state.attributes if layer.isGridLayer

  _addOtherTypes:(layer, collection, options)->
    if options.addOtherTypes and layer.getTaxonObservationTypes?
      #get the diferent types of layers available, then add instances of each
      layer.getTaxonObservationTypes().fetch 
        success: (types) => @add types.getOtherLayers()

  ###
  Gets all the layers used datasets of this collection and return
  them merged together
  ###
  getUsedDatasets: ->
    @chain()
    .map( (layer) ->  layer.getUsedDatasets() )
    .flatten()
    .groupBy( (dataset) -> dataset.id )
    .map( (val, key) -> val[0])
    .value()

  ###
  Override the default get method for the collection. Backbone doesn't
  like it when collections contain two versions of a model with the same
  id.

  This get method reverts to using backbones client id, which is unique for
  all backbone models created
  ###
  get: (model)-> Backbone.Collection.prototype.get.call(this, model.cid)