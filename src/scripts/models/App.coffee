define [
  'backbone', 
  'cs!collections/Search',
  'cs!collections/Layers'
], (Backbone, Search, Layers) -> Backbone.Model.extend 
  defaults :
    viewport: 
      minX: -24.90413904330953
      minY: 42.925823307748196
      maxX: 18.29410313645321
      maxY: 64.17861427158351
    baseLayer: "Aerial"
    layers : new Layers()

  ###
  Return this models layers collection
  ###
  getLayers: -> @get "layers"

  ### 
  Return an instance of the NBN Gateways search api
  ###
  getSearch: -> new Search()

  getBaseLayers: -> ["OS", "Outline", "Shaded", "Aerial", "Hybrid"]

  ###
  Process a search result and update the application accordingly
  ###
  addSearchResult: (searchResult) ->
    @set "viewport", searchResult.worldBoundingBox if searchResult.worldBoundingBox
    @getLayers().add searchResult if not searchResult.worldBoundingBox