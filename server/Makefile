UID=$(shell id -u)
GID=$(shell id -g)
serve: export GEOSERVER_URL = http://localhost:61590/geoserver/

.PHONY: serve

serve:
	UID=$(UID) GID=$(GID) docker-compose up -d
	bash config/config_geoserver.sh