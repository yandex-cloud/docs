### How can I get a point's coordinates from its address? {#make-geocode}

You could use the `GEOCODE()` function for that; however, it is not supported anymore.
Use the Yandex Maps API [geocoder](https://yandex.com/dev/maps/geocoder) instead. Please note the API [license terms](https://yandex.com/dev/maps/commercial/doc/concepts/jsapi-geocoder.html).

See [this example of a Jupyter notebook](https://github.com/yandex-cloud-examples/yc-datalens-get-coordinates-by-location) with address geocoding scripts.
