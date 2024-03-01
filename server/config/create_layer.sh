#!/bin/bash

export GEOSERVER_URL="http://localhost:61590/geoserver/"
export USER=admin
export PASSWORD=geoserver
export WORKSPACE=geo

# Script to create a feature type, layer and associated style.
# The workspace and Postgis datastore should already exist before running it.
# This will also create the database table of the layer if it does not exist.
# It should be called from the /server directory

# Create feature type
until curl -v -u $USER:$PASSWORD -XPOST -T "config/featuretypes/featuretype.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/featuretypes"
do
    sleep 2
done

# Create style
until curl -v -u $USER:$PASSWORD -XPOST -H "Content-type: text/xml" -d "<style><name>localized_point</name><filename>localized_point.sld</filename></style>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/localized_point.sld" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/localized_point"
do
    sleep 2
done

# Set style as default for the layer
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: text/xml" -d "<layer><defaultStyle><name>localized_point</name></defaultStyle></layer>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/layers/eld_pane_1_point"
do
    sleep 2
done
