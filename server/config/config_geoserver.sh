#/bin/bash

# Script to initialize geoserver config on composition start-up using the REST API

# Create a workspace
until curl -u admin:geoserver -POST -H "Content-type: text/xml"  -d "<workspace><name>geo</name></workspace>"  $GEOSERVER_URL"rest/workspaces" 2> /dev/null
do
    sleep 2
done

# Add postgis datastore
until curl -u admin:geoserver -XPOST -T "config/datastore_postgis.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/geo/datastores" 2> /dev/null
do
    sleep 2
done

# Add postgis layer
until curl -u admin:geoserver -XPOST -T "config/layer_location.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/geo/featuretypes"
do
    sleep 2
done

# Add write permission to layer
until curl -u admin:geoserver -XPOST -T "config/security/rules.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/security/acl/layers"
do
    sleep 2
done
