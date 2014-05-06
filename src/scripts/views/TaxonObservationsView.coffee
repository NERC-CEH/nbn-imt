define [
  "jquery"
  "backbone"
  "tpl!templates/TaxonObservations.tpl"
  "DataTables"
], ($, Backbone, template) -> Backbone.View.extend
  initialize:->
    @listenTo @collection, 'sync', @render

  render: ->  
    @$el.html template
      observations: @collection.toJSON()
      isFilteredByTaxon: @collection.isFilteredByTaxon()

    @$('table').dataTable
      "bJQueryUI": true
      "bLengthChange": false
      "oLanguage":
        "sSearch": "Search within these results:"
      "aoColumnDefs": [
        {
          "sWidth":"11%"
          "aTargets":[4,5]
        }
      ]

    if (@collection.apiFailed)
      $(".polygonErrorMessage").text  @collection.apiFailureMessage
    else
      $(".polygonErrorMessage").clear
    return []        