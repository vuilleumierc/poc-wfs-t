import "ol/ol.css";
import { Map, View } from "ol";
import GeoJSON from 'ol/format/GeoJSON';
import TileLayer from "ol/layer/Tile";
import OSM from "ol/source/OSM";
import VectorSource from 'ol/source/Vector'
import {Vector as VectorLayer} from 'ol/layer';
import {bbox as bboxStrategy} from 'ol/loadingstrategy';
import {WFS as WFSFormat, GML as GMLFormat} from 'ol/format';
import {Draw, Modify, Select, Snap} from 'ol/interaction';
import Popup from 'ol-popup';

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

// Initializations for WFS-T request
const formatWFS = new WFSFormat();
const formatGML = new GMLFormat({
    featureNS: 'geo',
    featureType: 'location',
    srsName: 'EPSG:3857'
});
const xs = new XMLSerializer();
const request = new XMLHttpRequest();

// Prepare and send WFS-T request
const transactWFS = function (mode, features) {
  let node;
  switch (mode) {
      case 'insert':
          node = formatWFS.writeTransaction(features, null, null, formatGML);
          break;
      case 'update':
          node = formatWFS.writeTransaction(null, features, null, formatGML);
          break;
      case 'delete':
          node = formatWFS.writeTransaction(null, null, features, formatGML);
          break;
      default:
        throw 'WFS-T mode ' + mode + ' is not supported'
  }
  const body = xs.serializeToString(node);
  request.open('POST', 'http://localhost:61590/geoserver/geo/wfs');
  request.setRequestHeader('dataType', 'xml')
  request.setRequestHeader('contentType', 'application/xml')
  request.send(body);
};

// Add interactions with the map
const features = [];
const modify = new Modify({source: vectorSource});
map.addInteraction(modify);

// Global variables so we can remove them later
let draw;
let select;
const snap = new Snap({source: vectorSource});
const typeSelect = document.getElementById('type');
const editMode = document.getElementById('mode');
let interactionIsActive = false;

function addInteractions() {
  interactionIsActive = true;
  if (editMode.value === "insert") {
    addDrawInteraction();
  }
  else if (editMode.value === "update") {
    addSelectInteraction();
  }
}

function removeInteractions() {
  if (interactionIsActive) {
    map.removeInteraction(draw);
    map.removeInteraction(snap);
    map.removeInteraction(select);
    interactionIsActive = false;
  }
}

function addDrawInteraction() {
  draw = new Draw({
    source: vectorSource,
    type: typeSelect.value,
  });
  map.addInteraction(draw);
  map.addInteraction(snap);

  draw.on('drawend', function(evt) {
    let feature = evt.feature;
    feature.setProperties({'timestamp': new Date().toISOString()});
    features.push(feature);
  });
}

function addSelectInteraction() {
  select = new Select({
    hitTolerance: 10
  });
  map.addInteraction(select);
  select.on('select', function({selected, deselected, mapBrowserEvent}) {
    let feature = selected[0].values_.features[0];
    console.log("selected feature id: " + feature.getId())
    feature.setProperties({'timestamp': new Date().toISOString()});
    features.push(feature);
  });
}

function toggleEditing() {
  if (!interactionIsActive) {
    addInteractions();
  } else {
    removeInteractions();
  }
}
window.toggleEditing = toggleEditing;

editMode.onchange = function () {
  map.removeInteraction(draw);
  map.removeInteraction(snap);
  map.removeInteraction(select);
  addInteractions();
};

// Read data from form and trigger WFS-T request
function sendData() {
  if (features.length == 0) {
    return;
  }
  const elem = document.getElementById("attrs")
  let properties = {};
  for (let i = 0; i < elem.length; i++) {
    properties[elem[i].name] = elem[i].value;
  }
  features.forEach(feature => feature.setProperties(properties));
  try {
    if (features[0].getId() == null) {
      transactWFS('insert', features)
    }
    else {
      transactWFS('update', features)
    }
  } catch (e) {
    console.error(e);
  }
}
window.sendData = sendData;

// Add attribute popup
function showLabels() {
  vectorSource.getFeatures().forEach(function(feature) {
    const popup = new Popup({offset: [0, -32]});
    map.addOverlay(popup);
    const cell_id = feature.values_.cell_id;
    popup.show(feature.getGeometry().flatCoordinates, '<div class="popup">Cell ID: ' + cell_id + '</div>');
  })
};
window.showLabels = showLabels;
