define [
  "cs!models/DesignationSpeciesDensityLayer"
], (DesignationSpeciesDensityLayer)-> 
  describe "DesignationSpeciesDensityLayer", ->
    it "can filter start year", ->
      layer = new DesignationSpeciesDensityLayer code: "BERN-A1", startDate: 2012
      expect(layer.getWMS()[0]).toContain "startyear=2012"

    it "can filter end year", ->
      layer = new DesignationSpeciesDensityLayer code: "BERN-A1", endDate: 2012
      expect(layer.getWMS()[0]).toContain "endyear=2012"

    it "doesnt apply a temporal filter when default years are used", ->
      layer = new DesignationSpeciesDensityLayer code: "BERN-A1"
      expect(layer.getWMS()[0]).not.toContain "endyear"
      expect(layer.getWMS()[0]).not.toContain "startyear"