# Usage Guide - PMTiles Administrasi Kabupaten/Kota Indonesia

Dokumentasi ini menjelaskan cara menggunakan dataset PMTiles yang dihasilkan dari PostGIS.

---

## 1. Preview PMTiles

Untuk melihat data interaktif:

* [PMTiles Preview](https://pmtiles.io/#map=6.6/-5.93/108.492&inspectFeatures=true&showTileBoundaries=true)
* Gunakan `public/map_preview.html` untuk load PMTiles di **MapLibre / Mapbox** secara lokal.

---

## 2. Memuat PMTiles di MapLibre GL JS

Contoh JavaScript untuk menampilkan PMTiles:

```javascript
import maplibregl from 'maplibre-gl';

const map = new maplibregl.Map({
  container: 'map',
  style: 'https://demotiles.maplibre.org/style.json',
  center: [108.492, -5.93],
  zoom: 6
});

map.on('load', () => {
  map.addSource('adm_kabkot', {
    type: 'vector',
    url: '/pmtiles/11.pmtiles'  // ganti sesuai KDPPUM
  });

  map.addLayer({
    id: 'adm_kabkot-fill',
    type: 'fill',
    source: 'adm_kabkot',
    'source-layer': '11',       // ganti sesuai KDPPUM
    paint: { 'fill-color': '#f0c420', 'fill-opacity': 0.5 }
  });
});
```

---

## 3. Feature Properties

Setiap feature memiliki properti berikut:

| Field      | Deskripsi                         |
| ---------- | --------------------------------- |
| `id`       | ID unik dari `OBJECTID`           |
| `WADMPR`   | Kode provinsi                     |
| `SRS_ID`   | Sistem referensi koordinat (EPSG) |
| `NAMOBJ`   | Nama kabupaten/kota               |
| `METADATA` | Metadata tambahan                 |
| `LUASWH`   | Luas wilayah (hektar)             |
| `KDPPUM`   | Kode wilayah (unit pemekaran)     |
| `KDPKAB`   | Kode kabupaten                    |
| `geom`     | Geometri multipolygon 2D          |

Gunakan `feature.id` untuk interaksi seperti hover, select, zoom-event atau styling per feature.

