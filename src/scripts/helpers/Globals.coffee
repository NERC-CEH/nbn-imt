define [
  'underscore'
], (_) ->
  ###
  Define the servers which should be used based on the where the IMT
  is currently operating
  ###
  servers: 
    switch window.location.host
      when "localhost:8080", "dev-data.nbn.org.uk" 
        api: "dev-data.nbn.org.uk/api"
        gis: "dev-data.nbn.org.uk/gis"
        portal: "dev-data.nbn.org.uk" 
      when "staging.testnbn.net" 
        api: "staging.testnbn.net/api"
        gis: "staging.testnbn.net/gis"
        portal: "staging.testnbn.net" 
      else  
        api: "data.nbn.org.uk/api"
        gis: "data.nbn.org.uk/gis"
        portal: "data.nbn.org.uk"

  api: (path, attr) -> "http://#{@servers.api}/#{path}?callback=?&#{@_buildQueryString(attr)}"
  gis: (path, attr) -> "http://#{@servers.gis}/#{path}?#{@_buildQueryString(attr)}"
  portal: (path) -> "http://#{@servers.portal}/#{path}"
  
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