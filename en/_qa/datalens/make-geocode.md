### How can I perform geocoding to get a point's coordinates from its address? {#make-geocode}

Previously, you could use the `GEOCODE()` function for that. Now it's not available.
You can use the Yandex Maps API [geocoder](https://yandex.com/dev/maps/geocoder). Please note the API [license terms](https://yandex.com/dev/maps/commercial/doc/concepts/jsapi-geocoder.html).

See a [sample Jupyter notebook](https://github.com/yandex-cloud/yc-architect-solution-library/tree/main/yc-datalens) with address geocoding scripts.
