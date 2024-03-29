SET standard_conforming_strings = OFF;

\set schema 'public'

DROP TABLE IF EXISTS :schema."location" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'location' AND f_table_schema = :'schema';
BEGIN;
CREATE TABLE :schema."location" ( "id" BIGINT, CONSTRAINT "location_pk" PRIMARY KEY ("id") );
SELECT AddGeometryColumn(:'schema','location','geometry',3857,'POINT',2);
CREATE INDEX "location_geometry_geom_idx" ON :schema."location" USING GIST ("geometry");
ALTER TABLE :schema."location" ADD COLUMN "event_id" BIGINT;
ALTER TABLE :schema."location" ADD COLUMN "name" VARCHAR;
ALTER TABLE :schema."location" ADD COLUMN "color" VARCHAR;
ALTER TABLE :schema."location" ADD COLUMN "icon" VARCHAR;
ALTER TABLE :schema."location" ADD COLUMN "timestamp" timestamp with time zone;
ALTER TABLE :schema."location" ADD COLUMN geometry_4326 geometry(Point, 4326);

CREATE OR REPLACE FUNCTION transform_and_update_geometry()
RETURNS TRIGGER AS $$
BEGIN
    NEW.geometry_4326 := ST_Transform(NEW.geometry, 4326);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger that fires the trigger function before insert
CREATE TRIGGER transform_geometry_trigger
BEFORE INSERT ON location
FOR EACH ROW EXECUTE FUNCTION transform_and_update_geometry();
COMMIT;

DROP TABLE IF EXISTS :schema."line" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'line' AND f_table_schema = :'schema';
BEGIN;
CREATE TABLE :schema."line" ( "id" BIGINT, CONSTRAINT "line_pk" PRIMARY KEY ("id") );
SELECT AddGeometryColumn(:'schema','line','geometry',3857,'LINESTRING',2);
CREATE INDEX "line_geometry_geom_idx" ON :schema."line" USING GIST ("geometry");
ALTER TABLE :schema."line" ADD COLUMN "event_id" BIGINT;
ALTER TABLE :schema."line" ADD COLUMN "name" VARCHAR;
ALTER TABLE :schema."line" ADD COLUMN "color" VARCHAR;
ALTER TABLE :schema."line" ADD COLUMN "icon" VARCHAR;
ALTER TABLE :schema."line" ADD COLUMN "timestamp" timestamp with time zone;
COMMIT;

DROP TABLE IF EXISTS :schema."area" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'area' AND f_table_schema = :'schema';
BEGIN;
CREATE TABLE :schema."area" ( "id" BIGINT, CONSTRAINT "area_pk" PRIMARY KEY ("id") );
SELECT AddGeometryColumn(:'schema','area','geometry',3857,'POLYGON',2);
CREATE INDEX "area_geometry_geom_idx" ON :schema."area" USING GIST ("geometry");
ALTER TABLE :schema."area" ADD COLUMN "event_id" BIGINT;
ALTER TABLE :schema."area" ADD COLUMN "name" VARCHAR;
ALTER TABLE :schema."area" ADD COLUMN "color" VARCHAR;
ALTER TABLE :schema."area" ADD COLUMN "icon" VARCHAR;
ALTER TABLE :schema."area" ADD COLUMN "timestamp" timestamp with time zone;
COMMIT;

CREATE TABLE IF NOT EXISTS :schema."eld_pane_1_polygon" (
    id BIGINT PRIMARY KEY,
    naz_rw INT,
    description_de JSONB,
    description_fr JSONB,
    description_it JSONB,
    description_en JSONB,
    geometry GEOMETRY (POLYGON, 4326),
    rule_id BIGINT,
    legend_default VARCHAR,
    legend_de VARCHAR,
    legend_fr VARCHAR,
    legend_it VARCHAR,
    start_date TIMESTAMP,
    end_date TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_eld_pane_1_polygon_rule_id ON :schema."eld_pane_1_polygon" (rule_id);
CREATE INDEX IF NOT EXISTS idx_eld_pane_1_polygon_geometry_gist ON :schema."eld_pane_1_polygon" USING GIST (geometry);
CREATE INDEX IF NOT EXISTS idx_eld_pane_1_polygon_start_date ON :schema."eld_pane_1_polygon" (start_date);
CREATE INDEX IF NOT EXISTS idx_eld_pane_1_polygon_end_date ON :schema."eld_pane_1_polygon" (end_date);