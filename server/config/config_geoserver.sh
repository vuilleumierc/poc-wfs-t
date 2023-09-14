#/bin/bash

# Script to initialize geoserver config on composition start-up using the REST API

# Create a workspace
until curl -u admin:geoserver -POST -H "Content-type: text/xml"  -d "<workspace><name>geo</name></workspace>"  $GEOSERVER_URL"rest/workspaces" 2> /dev/null
do
    sleep 2
done

# Add postgis datastore
until curl -u admin:geoserver -XPOST -T "config/datastore/datastore_postgis.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/geo/datastores" 2> /dev/null
do
    sleep 2
done

# Add postgis point layer
until curl -u admin:geoserver -XPOST -T "config/layers/layer_location.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/geo/featuretypes"
do
    sleep 2
done

# Add point style
until curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<style><name>color_point</name><filename>color_point.sld</filename></style>" $GEOSERVER_URL"rest/workspaces/geo/styles/"
do
    sleep 2
done
until curl -v -u admin:geoserver -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/color_point.sld" $GEOSERVER_URL"rest/workspaces/geo/styles/color_point"
do
    sleep 2
done

# Link style to layer
until curl -v -u admin:geoserver -XPUT -H "Content-type: text/xml" -d "<layer><defaultStyle><name>color_point</name></defaultStyle></layer>" $GEOSERVER_URL"rest/workspaces/geo/layers/location"
do
    sleep 2
done

# Add write permission to layer
until curl -u admin:geoserver -XPOST -T "config/security/rules.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/security/acl/layers"
do
    sleep 2
done
