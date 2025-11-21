# Changelog

Semua perubahan signifikan pada dataset PMTiles untuk administrasi kabupaten/kota Indonesia dicatat di sini.

## [Unreleased]

* Struktur folder project dan script sudah diperbarui.
* Menambahkan screenshot properti di `public/properties_data.png`.
* Menambahkan preview MapLibre/Mapbox untuk subset PMTiles.

## [2025-11-21] - Initial Release

* PMTiles per KDPPUM berhasil di-generate menggunakan Tippecanoe.
* Data diambil dari PostGIS `adm_kabkot_id` dengan kolom:

  * `id` (OBJECTID)
  * `WADMPR`, `WADMKD`, `SRS_ID`, `NAMOBJ`, `METADATA`, `LUASWH`, `KDPPUM`, `KDPKAB`
  * `geom` (2D Multipolygon)
* GeoJSON sementara disimpan di `tmp_geojson/`.
* File PMTiles dihasilkan di `pmtiles/`.
* Preview data dapat dilihat di [PMTiles Preview](https://pmtiles.io/#map=6.6/-5.93/108.492&inspectFeatures=true&showTileBoundaries=true).
* Menggunakan ST_Force2D untuk memastikan geometri 2D.
* Script otomatis: `generate_pmtiles_per_kdppum.sh`.
