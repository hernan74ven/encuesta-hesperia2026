const CACHE = 'hesperia-encuesta-v1';
const URLS = [
  './encuesta_satisfaccion_hesperia.html',
  './'
];

self.addEventListener('install', e => {
  e.waitUntil(
    caches.open(CACHE).then(c => c.addAll(URLS))
  );
});

self.addEventListener('fetch', e => {
  e.respondWith(
    caches.match(e.request).then(r => r || fetch(e.request))
  );
});
