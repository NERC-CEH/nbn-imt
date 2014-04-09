define [
  'underscore'
], (_) ->
  ###
  Define the servers which should be used based on the where the IMT
  is currently operating
  ###
  servers: 
    switch window.location.host
      when "data-developer.nbn.org.uk" 
        api: "data-developer.nbn.org.uk/api"
        gis: ["gis-developer.nbn.org.uk"]
        portal: "data-developer.nbn.org.uk" 
      when "dev-data.nbn.org.uk" 
        api: "dev-data.nbn.org.uk/api"
        gis: ["dev-gis.nbn.org.uk"]
        portal: "dev-data.nbn.org.uk" 
      when "staging-data.nbn.org.uk" 
        api: "staging-data.nbn.org.uk/api"
        gis: ["staging-gis.nbn.org.uk"]
        portal: "staging-data.nbn.org.uk" 
      else  
        api: "data.nbn.org.uk/api"
        gis: ["gis1.nbn.org.uk", "gis2.nbn.org.uk", "gis3.nbn.org.uk", "gis4.nbn.org.uk"]
        portal: "data.nbn.org.uk"

  api: (path) -> "https://#{@servers.api}/#{path}?callback=?"

  ###
  Generate an array of gis end points which we can use to maximize parallel image requests
  ###
  gis: (path, attr) -> 
    query = @_buildQueryString(attr) #Query string is same for each gis end point
    return _.map(@servers.gis, (server) -> "https://#{server}/#{path}?#{query}")

  ###
  Generate an array of gis tms endpoints for the given TMS endpoint
  ###
  tms: (path) -> return _.map(@servers.gis, (server) -> "https://#{server}/#{path}/")
  
  portal: (path) -> "https://#{@servers.portal}/#{path}"
  
  ###
  The following function will build a query string from an object of
  filters. If an attribute is provided in that object which does not
  have a value or the value is "" (an empty string), then that attribute
  will be omited from the resultant querystring
  ###
  _buildQueryString: (attributes)->
    _.chain(attributes)
      .pairs()
      .reject( (curr) -> not curr[1]? or curr[1] is "")
      .map( (curr) -> "#{curr[0]}=#{curr[1]}" )
      .value()
      .join '&'