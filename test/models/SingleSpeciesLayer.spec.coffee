define [
  "cs!models/SingleSpeciesLayer"
], (SingleSpeciesLayer)-> 
  describe "SingleSpeciesLayer", ->
    it "can filter start year", ->
      layer = new SingleSpeciesLayer key: "NHMSYS0000080191", startDate: 2012
      expect(layer.getWMS()[0]).toContain "startyear=2012"

    it "can filter end year", ->
      layer = new SingleSpeciesLayer key: "NHMSYS0000080191", endDate: 2012
      expect(layer.getWMS()[0]).toContain "endyear=2012"

    it "doesnt apply a temporal filter when default years are used", ->
      layer = new SingleSpeciesLayer key: "NHMSYS0000080191"
      expect(layer.getWMS()[0]).not.toContain "endyear"
      expect(layer.getWMS()[0]).not.toContain "startyear"