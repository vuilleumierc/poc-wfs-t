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
