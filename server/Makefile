UID=$(shell id -u)
GID=$(shell id -g)
serve: export GEOSERVER_URL = http://localhost:61590/geoserver/

.PHONY: serve

serve:
	docker-compose up -d
	bash config/config_geoserver.sh

.PHONY: data-dump

data-dump:
	PGPASSWORD=postgres pg_dump --data-only --file=updated_sample_data.sql --table=location --table=line --table=area --host=localhost --port=61543 --username=postgres --verbose postgres
