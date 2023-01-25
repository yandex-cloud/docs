# Content segmentation

You can _segment_ CDN content: request it from origins and store it on servers in parts. Segmentation is enabled in the resource settings.

If the setting is enabled:

* Files with a size of 10 MB or more are requested from origins in parts. The maximum size of each part is 10 MB.

  > For example, a 42 MB file will be split into four 10 MB parts and one 2 MB part.

  All parts are requested in parallel, each in its own thread. This lets you download the entire file and start sending it to the client faster.

  {% note warning %}

  For segmentation to work correctly, origins must support partial GET requests with the `Range` header. Regardless of a group's origin that a file part is requested from, responses carrying this part must have the same values of the `Content-Length` and `ETag` headers.

  {% endnote %}

* To send a whole file to the client, all the parts are combined back into one file before sending.

* If [caching on CDN servers](caching.md#server-side) is enabled, the file parts will continue to be stored on the server.

#### See also {#see-also}

* [Instructions for enabling file segmentation](../operations/resources/enable-segmentation.md).