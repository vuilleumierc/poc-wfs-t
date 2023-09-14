SET standard_conforming_strings = OFF;
DROP TABLE IF EXISTS "public"."location" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'location' AND f_table_schema = 'public';
BEGIN;
CREATE TABLE "public"."location" ( "id" BIGINT, CONSTRAINT "location_pk" PRIMARY KEY ("id") );
SELECT AddGeometryColumn('public','location','geometry',3857,'POINT',2);
CREATE INDEX "location_geometry_geom_idx" ON "public"."location" USING GIST ("geometry");
ALTER TABLE "public"."location" ADD COLUMN "name" VARCHAR;
ALTER TABLE "public"."location" ADD COLUMN "color" VARCHAR;
ALTER TABLE "public"."location" ADD COLUMN "timestamp" timestamp with time zone;
COMMIT;
