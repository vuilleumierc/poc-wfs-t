#!/bin/bash

export USER=admin
export PASSWORD=geoserver
export WORKSPACE=geo

# Script to initialize geoserver config on composition start-up using the REST API
# It should be called from the /server directory

# Create a workspace
until curl -v -u $USER:$PASSWORD -POST -H "Content-type: text/xml"  -d "<workspace><name>$WORKSPACE</name></workspace>"  $GEOSERVER_URL"rest/workspaces"
do
    sleep 2
done

# Add postgis datastore
until curl -v -u $USER:$PASSWORD -XPOST -T "config/datastore/datastore_postgis.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/datastores"
do
    sleep 2
done

# Add postgis layers
until curl -v -u $USER:$PASSWORD -XPOST -T "config/layers/layer_location.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/featuretypes"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPOST -T "config/layers/layer_line.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/featuretypes"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPOST -T "config/layers/layer_area.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/featuretypes"
do
    sleep 2
done

# Add point style
until curl -v -u $USER:$PASSWORD -XPOST -H "Content-type: text/xml" -d "<style><name>color_point</name><filename>color_point.sld</filename></style>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/color_point.sld" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/color_point"
do
    sleep 2
done

# Add line style
until curl -v -u $USER:$PASSWORD -XPOST -H "Content-type: text/xml" -d "<style><name>color_line</name><filename>color_line.sld</filename></style>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/color_line.sld" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/color_line"
do
    sleep 2
done

# Add svg styles
until curl -v -u $USER:$PASSWORD -XPOST -H "Content-type: text/xml" -d "<style><name>svg_local_point</name><filename>svg_local_point.sld</filename></style>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/svg_local_point.sld" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/svg_local_point"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPOST -H "Content-type: text/xml" -d "<style><name>svg_online_point</name><filename>svg_online_point.sld</filename></style>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/svg_online_point.sld" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/svg_online_point"
do
    sleep 2
done

until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: text/xml" -d "<layer><styles><style><name>svg_local_point</name></style><style><name>svg_online_point</name></style></styles></layer>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/layers/location"
do
    sleep 2
done

# Add polygon style
until curl -v -u $USER:$PASSWORD -XPOST -H "Content-type: text/xml" -d "<style><name>color_polygon</name><filename>color_polygon.sld</filename></style>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/color_polygon.sld" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/color_polygon"
do
    sleep 2
done

# Link style to layer (default)
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: text/xml" -d "<layer><defaultStyle><name>svg_online_point</name></defaultStyle></layer>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/layers/location"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: text/xml" -d "<layer><defaultStyle><name>color_line</name></defaultStyle></layer>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/layers/line"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: text/xml" -d "<layer><defaultStyle><name>color_polygon</name></defaultStyle></layer>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/layers/area"
do
    sleep 2
done

# Add write permission to layer
until curl -u $USER:$PASSWORD -XPOST -T "config/security/rules.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/security/acl/layers"
do
    sleep 2
done

# Add layer and style to test legends

until curl -v -u $USER:$PASSWORD -XPOST -T "config/layers/layer_eld_pane_1_polygon.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/featuretypes"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPOST -H "Content-type: text/xml" -d "<style><name>localized</name><filename>localized.sld</filename></style>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/localized.sld" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/styles/localized"
do
    sleep 2
done
until curl -v -u $USER:$PASSWORD -XPUT -H "Content-type: text/xml" -d "<layer><defaultStyle><name>localized</name></defaultStyle></layer>" $GEOSERVER_URL"rest/workspaces/$WORKSPACE/layers/eld_pane_1_polygon"
do
    sleep 2
done
