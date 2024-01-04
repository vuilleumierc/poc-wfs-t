# poc-wfs-t
POC to test the interactive creation of geographic features using OpenLayers, WFS-T and GeoServer

### Quick start
To start the server, go in the directory `server` and run:

```
make serve
```

To export the data that has been added through the client you can use the target `make data-dump`

To start the client application, go in the directory `client` and run:

```
npm install
npm start
```

The application will be available at http://localhost:1234/

#### Legends (GSBAB-36)

Documentation: https://docs.geoserver.org/latest/en/user/services/wms/get_legend_graphic/index.html

Localized legend (query parameter `language`):

http://localhost:61590/geoserver/ows?service=WMS&version=1.3.0&request=GetLegendGraphic&format=image%2Fpng&layer=geo%3Aeld_pane_1_polygon&language=ger

http://localhost:61590/geoserver/ows?service=WMS&version=1.3.0&request=GetLegendGraphic&format=image%2Fpng&layer=geo%3Aeld_pane_1_polygon&language=fre

http://localhost:61590/geoserver/ows?service=WMS&version=1.3.0&request=GetLegendGraphic&format=image%2Fpng&layer=geo%3Aeld_pane_1_polygon&language=ita


CQL_FILTER (attribute `rule_id`):

http://localhost:61590/geoserver/ows?service=WMS&version=1.3.0&request=GetLegendGraphic&format=image%2Fpng&layer=geo%3Aeld_pane_1_polygon&language=eng&CQL_FILTER=rule_id=12&legend_options=countMatched:true;fontAntiAliasing:true;hideEmptyRules:true;forceLabels:on

-> the number of matched features is displayed after the labels
http://localhost:61590/geoserver/ows?service=WMS&version=1.3.0&request=GetLegendGraphic&format=image%2Fpng&layer=geo%3Aeld_pane_1_polygon&language=eng&CQL_FILTER=rule_id=12&legend_options=fontAntiAliasing:true;hideEmptyRules:true;forceLabels:on

JSON output
http://localhost:61590/geoserver/ows?service=WMS&version=1.3.0&request=GetLegendGraphic&format=application/json&layer=geo%3Aeld_pane_1_polygon&language=eng&l
