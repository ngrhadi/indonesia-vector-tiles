# Contributing

Terima kasih telah tertarik untuk berkontribusi pada project PMTiles Administrasi Kabupaten/Kota Indonesia.

Berikut panduan singkat:

## 1. Setup Environment

* Pastikan memiliki **PostgreSQL/PostGIS** untuk akses database.
* Install dependencies:

  * `ogr2ogr` (GDAL)
  * `tippecanoe`
* (Opsional) buat folder `tmp_geojson/` dan `pmtiles/` jika belum ada:

  ```bash
  mkdir -p tmp_geojson pmtiles
  ```

## 2. Menambahkan / Memperbarui Data

* Gunakan script `generate_pmtiles_per_kdppum.sh` untuk generate PMTiles baru atau update KDPPUM tertentu.
* Pastikan setiap feature memiliki kolom `id` unik dari `OBJECTID`.
* Jangan gunakan nama kolom `id` lain yang menyebabkan konflik dengan Tippecanoe.

## 3. Preview Data

* Gunakan [PMTiles Preview](https://pmtiles.io/#map=6.6/-5.93/108.492&inspectFeatures=true&showTileBoundaries=true) untuk memeriksa tiles.
* Atau jalankan `public/map_preview.html` dengan MapLibre/Mapbox.

## 4. Commit Guidelines

* Gunakan branch terpisah untuk perubahan besar.
* Jangan commit file `.geojson` atau `.pmtiles` besar ke repository; gunakan `.gitignore`.
* Update `CHANGELOG.md` jika menambahkan atau memperbarui data.

## 5. Issues & Bug

* Laporkan masalah terkait script atau data melalui GitHub Issues.
* Sertakan detail KDPPUM atau file PMTiles terkait saat melaporkan bug.

---

Dengan mengikuti panduan ini, project tetap terstruktur, mudah di-update, dan dapat digunakan oleh developer lain.
