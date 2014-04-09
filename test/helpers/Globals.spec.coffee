define [
  "cs!helpers/Globals"
], (Globals)->
  describe "globals helper", ->
    it "can build an api url", ->
      path = Globals.api "testPath"
      expect(path).toBe "https://data.nbn.org.uk/api/testPath?callback=?"

    it "can build a gis url", ->
      path = Globals.gis("testPath", startYear: 1920, endYear: 1940)
      expect(path[0]).toBe "https://gis1.nbn.org.uk/testPath?startYear=1920&endYear=1940"
      expect(path[1]).toBe "https://gis2.nbn.org.uk/testPath?startYear=1920&endYear=1940"
      expect(path[2]).toBe "https://gis3.nbn.org.uk/testPath?startYear=1920&endYear=1940"
      expect(path[3]).toBe "https://gis4.nbn.org.uk/testPath?startYear=1920&endYear=1940"

    it "can build a portal url", ->
      path = Globals.portal "testPath"
      expect(path).toBe "https://data.nbn.org.uk/testPath"

    it "can build a tms path", ->
      path = Globals.tms "Tiled"
      expect(path[0]).toBe "https://gis1.nbn.org.uk/Tiled/"
      expect(path[1]).toBe "https://gis2.nbn.org.uk/Tiled/"
      expect(path[2]).toBe "https://gis3.nbn.org.uk/Tiled/"
      expect(path[3]).toBe "https://gis4.nbn.org.uk/Tiled/"