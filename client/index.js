import "ol/ol.css";
import { Map, View, Feature } from "ol";
import Point from 'ol/geom/Point';
import GeoJSON from 'ol/format/GeoJSON';
import TileLayer from "ol/layer/Tile";
import OSM from "ol/source/OSM";
import VectorSource from 'ol/source/Vector'
import {Vector as VectorLayer} from 'ol/layer';
import {bbox as bboxStrategy} from 'ol/loadingstrategy';
import {WFS as WFSFormat, GML as GMLFormat} from 'ol/format';
import {Draw, Modify, Snap} from 'ol/interaction';

const vectorSource = new VectorSource({
  format: new GeoJSON(),
  url: function (extent) {
    return (
      'http://localhost:61590/geoserver/ows?service=wfs&' +
      'version=2.0.0&request=GetFeature&typeNames=geo:location&' +
      'outputFormat=application/json&srsname=EPSG:3857&' +
      'bbox=' +
      extent.join(',') +
      ',EPSG:3857'
    );
  },
  strategy: bboxStrategy,
});

const vector = new VectorLayer({
  source: vectorSource,
});

const map = new Map({
  target: "map",
  layers: [
    new TileLayer({
      className: 'bw',
      source: new OSM(),
    }),
    vector,
  ],
  view: new View({
    center: [828064.77, 5934093.19],
    zoom: 12,
  }),
});

///

const formatWFS = new WFSFormat();

const formatGML = new GMLFormat({
    featureNS: 'geo',
    featureType: 'location',
    srsName: 'EPSG:3857'
});

const xs = new XMLSerializer();
const request = new XMLHttpRequest();

const transactWFS = function (mode, feature) {
    let node;
    switch (mode) {
        case 'insert':
            node = formatWFS.writeTransaction([feature], null, null, formatGML);
            break;
        case 'update':
            node = formatWFS.writeTransaction(null, [feature], null, formatGML);
            break;
        case 'delete':
            node = formatWFS.writeTransaction(null, null, [feature], formatGML);
            break;
    }
    const body = xs.serializeToString(node);
    request.open('POST', 'http://localhost:61590/geoserver/geo/wfs');
    request.setRequestHeader('dataType', 'xml')
    request.setRequestHeader('contentType', 'application/xml')
    request.send(body);
};

const feature = new Feature({
  geometry: new Point([828064.77, 5934093.19]),
  name: 'new point'
});
transactWFS('insert', feature);

const modify = new Modify({source: vectorSource});
map.addInteraction(modify);

let draw, snap; // global so we can remove them later
const typeSelect = document.getElementById('type');

function addInteractions() {
  draw = new Draw({
    source: vectorSource,
    type: typeSelect.value,
  });
  map.addInteraction(draw);
  snap = new Snap({source: vectorSource});
  map.addInteraction(snap);
}

/**
 * Handle change event.
 */
typeSelect.onchange = function () {
  map.removeInteraction(draw);
  map.removeInteraction(snap);
  addInteractions();
};

addInteractions();
