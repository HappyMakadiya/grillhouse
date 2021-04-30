'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "a5968ce4c14b92b28028019721293571",
"assets/assets/food_app.json": "4033767435218d541adf046249e7dfb4",
"assets/assets/icon.png": "9ed89ec93f67f818379d9e307d6335eb",
"assets/assets/images/avatar1.png": "7fb6af72f58d6bf46baf78f68b89535a",
"assets/assets/images/avatar2.png": "5a4a46f3d7176efd93b7163b2d155a2b",
"assets/assets/images/avatar3.png": "24e0fbe0425a72a900cff9d4fbb67fce",
"assets/assets/images/avatar4.png": "468505ace1adc570c9a985a6eefce1a9",
"assets/assets/images/bgIcon.png": "4ca755d43a6cad06ca05f7ed37bc318b",
"assets/assets/images/burger.png": "44e8198ff12b9bb510e5cb896d04d2da",
"assets/assets/images/burger1.png": "fc7698b97267cc2a3105a57c9dd82985",
"assets/assets/images/chef.png": "b05d4710d19028889873f1dd42a7c4e5",
"assets/assets/images/chef.svg": "d3958a872c298d7dd2d1680b9cbc23b8",
"assets/assets/images/coffee.png": "8f1bb1dc0b25cab8864f110dd7916413",
"assets/assets/images/coffee1.png": "a7e3b24cdb1b32e071c28e9fc3517e97",
"assets/assets/images/cola.png": "2fbaad85b8de6599c63adbf1aa58bc84",
"assets/assets/images/cola1.png": "bdcd8869c048ddb63a282db027370504",
"assets/assets/images/empty_cart.png": "99b76197bfee4adb042383d3302ee222",
"assets/assets/images/french_fries.png": "aa3654fc11d8af4ea60d37c0a4df9238",
"assets/assets/images/french_fries1.png": "53373a4d67ff4a98be8143f10d09a16e",
"assets/assets/images/google.svg": "09aea0f59807f6f4f66af7f5719cba9e",
"assets/assets/images/pizza.png": "ae3f30ae6d5071c143aad5be58410d97",
"assets/assets/images/pizza1.png": "a3c1ff16db3493a26d123aac2913befd",
"assets/assets/images/popcorn.png": "f1b8b208ac2272f9efe4b3c22e345579",
"assets/assets/images/popcorn1.png": "669a71d0e7f1cbbae147b51479fe66f7",
"assets/assets/images/salad.png": "30f1bb9b980fd63ff682275654f71df7",
"assets/assets/images/salad1.png": "329b758c823f6cd4cf8ecd6d31af46f7",
"assets/assets/no_internet.png": "6573118ce2869a33329c32719f8acf92",
"assets/FontManifest.json": "fc0d32d83199a71ce11b3d58f94a25a7",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/fonts/OpenSans/OpenSans-Italic.ttf": "f6238deb7f40a7a03134c11fb63ad387",
"assets/fonts/OpenSans/OpenSans-Regular.ttf": "3ed9575dcc488c3e3a5bd66620bdf5a4",
"assets/NOTICES": "a3bfb520324704c430ba2e3ff9e413fe",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b14fcf3ee94e3ace300b192e9e7c8c5d",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/progress_dialog/assets/double_ring_loading_io.gif": "e5b006904226dc824fdb6b8027f7d930",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "0fb8520426f45d086f9fe268ebe2fdb1",
"/": "0fb8520426f45d086f9fe268ebe2fdb1",
"main.dart.js": "12077119f52ec521a630b073d4683a07",
"manifest.json": "91b89ba83aa71685ee7f16d7325aa7b3",
"version.json": "0618bc6a519c59d99ea7485c741e5bab"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
