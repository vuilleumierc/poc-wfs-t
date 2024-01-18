#/bin/bash

# Create feature type
until curl -v -u admin:geoserver -XPOST -T "config/featuretypes/featuretype.xml" -H "Content-type: text/xml" $GEOSERVER_URL"rest/workspaces/geo/featuretypes"
do
    sleep 2
done

# Create style
until curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<style><name>localized_point</name><filename>localized_point.sld</filename></style>" $GEOSERVER_URL"rest/workspaces/geo/styles/"
do
    sleep 2
done
until curl -v -u admin:geoserver -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -T "config/styles/localized_point.sld" $GEOSERVER_URL"rest/workspaces/geo/styles/localized_point"
do
    sleep 2
done

# Set style as defautl for the layer
until curl -v -u admin:geoserver -XPUT -H "Content-type: text/xml" -d "<layer><defaultStyle><name>localized_point</name></defaultStyle></layer>" $GEOSERVER_URL"rest/workspaces/geo/layers/eld_pane_1_point"
do
    sleep 2
done
