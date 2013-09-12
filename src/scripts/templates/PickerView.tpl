<%if(loggedIn){%>
  <%if(hasResults){%>
    <button type="button" class="btn clearResults">Redraw Selection</button>
    <div class="results"></div>
  <%} else {%>
    <div class="notice">Draw a bounding box on the map to view the selected records.</div>
  <%}%>
<%} else {%>
  <div class="notice">You must be registered and logged in to view records.</div>
<%}%>