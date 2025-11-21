#!/bin/bash

# -------------------------
# CONFIGURATION
# -------------------------
PG_USERNAME=""
PG_PASSWORD=""
PG_HOST=""
PG_DATABASE=""
PG_CONN="postgresql://$PG_USERNAME:$PG_PASSWORD@$PG_HOST/$PG_DATABASE"
TABLE_NAME='public.adm_kabkot_id'
GEOM_COLUMN="geom"              # kolom geometri
ID_COLUMN="\"KDPPUM\""          # kolom provinsi id
TMP_DIR="./tmp_geojson"
OUTPUT_DIR="./pmtiles"

# -------------------------
# PREPARE OUTPUT DIRECTORY
# -------------------------
mkdir -p "$TMP_DIR"
mkdir -p "$OUTPUT_DIR"

echo "🔍 Fetching unique KDPPUM..."
KDPPUM_LIST=$(psql "$PG_CONN" -t -c "SELECT DISTINCT $ID_COLUMN FROM $TABLE_NAME ORDER BY $ID_COLUMN;")

echo "Total unique KDPPUM:"
echo "$KDPPUM_LIST"

echo "==========================================="
echo "🚀 Start generating PMTiles..."
echo "==========================================="

for KD in $KDPPUM_LIST; do
    echo "▶ Processing KDPPUM: $KD"

    GEOJSON_FILE="$TMP_DIR/$KD.geojson"
    PMTILE_FILE="$OUTPUT_DIR/$KD.pmtiles"

    # Export subset GeoJSON
    echo "  - Exporting GeoJSON..."
    ogr2ogr -f GeoJSON \
        "$GEOJSON_FILE" \
        PG:"$PG_CONN" \
        -sql "SELECT \"OBJECTID\" AS id,
                    \"WADMPR\",
                    \"WADMKD\",
                    \"SRS_ID\",
                    \"NAMOBJ\",
                    \"METADATA\",
                    \"LUASWH\",
                    \"KDPPUM\",
                    \"KDPKAB\",
                    ST_Force2D(geom) AS geom
              FROM $TABLE_NAME
              WHERE \"KDPPUM\" = '$KD'" \
        -nln "$KD"

    # Generate PMTiles
    echo "  - Generating PMTiles..."
    tippecanoe \
        -o "$PMTILE_FILE" \
        --force \
        --no-feature-limit \
        --no-tile-size-limit \
        --projection=EPSG:4326 \
        --generate-ids \
        "$GEOJSON_FILE"

    echo "  ✔ Done $KD"
    echo ""
done

echo "==========================================="
echo "ALL PMTiles generated in folder: $OUTPUT_DIR"
echo "==========================================="
