SET standard_conforming_strings = OFF;

\set schema 'public'

DROP TABLE IF EXISTS :schema."location" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'location' AND f_table_schema = :'schema';
BEGIN;
CREATE TABLE :schema."location" ( "id" BIGINT, CONSTRAINT "location_pk" PRIMARY KEY ("id") );
SELECT AddGeometryColumn(:'schema','location','geometry',3857,'POINT',2);
CREATE INDEX "location_geometry_geom_idx" ON :schema."location" USING GIST ("geometry");
ALTER TABLE :schema."location" ADD COLUMN "name" VARCHAR;
ALTER TABLE :schema."location" ADD COLUMN "color" VARCHAR;
ALTER TABLE :schema."location" ADD COLUMN "timestamp" timestamp with time zone;
COMMIT;

DROP TABLE IF EXISTS :schema."line" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'line' AND f_table_schema = :'schema';
BEGIN;
CREATE TABLE :schema."line" ( "id" BIGINT, CONSTRAINT "line_pk" PRIMARY KEY ("id") );
SELECT AddGeometryColumn(:'schema','line','geometry',3857,'LINESTRING',2);
CREATE INDEX "line_geometry_geom_idx" ON :schema."line" USING GIST ("geometry");
ALTER TABLE :schema."line" ADD COLUMN "name" VARCHAR;
ALTER TABLE :schema."line" ADD COLUMN "color" VARCHAR;
ALTER TABLE :schema."line" ADD COLUMN "timestamp" timestamp with time zone;
COMMIT;