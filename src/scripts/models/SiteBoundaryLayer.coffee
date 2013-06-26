define [
  "underscore"
  "cs!models/Layer"
  "cs!models/Dataset"
  "cs!models/mixins/PolygonFillMixin"
  "cs!helpers/Globals"
], (_, Layer, Dataset, PolygonFillMixin, Globals) -> Layer.extend _.extend {}, PolygonFillMixin,
  defaults:
    entityType: 'site boundarydataset'
    opacity: 1
    wms: Globals.gis "SiteBoundaryDatasets"

  url: -> Globals.api "siteBoundaryDatasets/#{@id}"

  idAttribute: "key"

  initialize: ()->
    @set "name", @attributes.title
    @set "layer", @id
    PolygonFillMixin.initialize.call(this, arguments); #initalize the mixin

  getUsedDatasets: -> [ new Dataset @attributes ]