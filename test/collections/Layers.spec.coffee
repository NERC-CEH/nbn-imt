define [
	"cs!collections/Layers"
  "cs!models/SingleSpeciesLayer"
  "cs!models/TaxonObservationTypes"
], (Layers, SingleSpeciesLayer, TaxonObservationTypes)-> 
  describe "the layers collection", ->
    layers = null

    beforeEach ->
      layers = new Layers
      
    it "notifies grid layers that auto resolution has changed", ->    
      testLayer = new SingleSpeciesLayer;
      layers.add testLayer

      layers.setResolution 200

      expect(testLayer.get 'autoResolution').toBe "10km"

    it "notifies grid layers that max resolution has changed", ->
      testLayer = new SingleSpeciesLayer;
      layers.add testLayer

      layers.setResolution 2

      expect(testLayer.get 'maxResolution').toBe "100m"
    
    it "can reposition layers which have already been added", ->
      layer1 = new SingleSpeciesLayer
      layer2 = new SingleSpeciesLayer
      layers.add [layer1, layer2]

      layers.position 0, 1

      expect(layers.at(1)).toBe layer1
      expect(layers.at(0)).toBe layer2
    
    it "syncs the max/auto resolution state with new layers", ->
      layers.setResolution 50
      testLayer = new SingleSpeciesLayer

      layers.add testLayer

      expect(testLayer.get 'maxResolution').toBe "1km"
      expect(testLayer.get 'autoResolution').toBe "2km"

    it "adds the given layers absence and/or polygon layers if they are requested", ->
      testLayer = new SingleSpeciesLayer

      spyOn(testLayer, 'getTaxonObservationTypes').andCallFake -> 
        fetch: (callback) -> 
          callback.success new TaxonObservationTypes 
            defaultLayer: testLayer
            hasGridAbsence: true

      layers.add testLayer, addOtherTypes: true

      expect(testLayer.getTaxonObservationTypes).toHaveBeenCalled()
      expect(layers.length).toBe 2
      expect(layers.at(1).get 'isPresence').toBe false

    describe "auto resolution", ->
      it "goes to 10km at 200 resolution", ->
        layers.setResolution 200
        expect(layers.state.get 'autoResolution').toBe '10km'

      it "goes to 2km at 160 resolution", ->
        layers.setResolution 160
        expect(layers.state.get 'autoResolution').toBe '2km'

      it "goes to 1km at 30 resolution", ->
        layers.setResolution 30
        expect(layers.state.get 'autoResolution').toBe '1km'

      it "goes to 100m at 4 resolution", ->
        layers.setResolution 4
        expect(layers.state.get 'autoResolution').toBe '100m'

    describe "max resolution", ->
      it "goes to Polygon at 7000 resolution", ->
        layers.setResolution 7000
        expect(layers.state.get 'maxResolution').toBe 'Polygon'

      it "goes to 10km at 5000 resolution", ->
        layers.setResolution 5000
        expect(layers.state.get 'maxResolution').toBe '10km'

      it "goes to 2km at 500 resolution", ->
        layers.setResolution 500
        expect(layers.state.get 'maxResolution').toBe '2km'

      it "goes to 1km at 340 resolution", ->
        layers.setResolution 340
        expect(layers.state.get 'maxResolution').toBe '1km'

      it "goes to 100m at 30 resolution", ->
        layers.setResolution 30
        expect(layers.state.get 'maxResolution').toBe '100m'