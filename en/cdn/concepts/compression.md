# Content compression

You can transmit content from CDN servers to clients in a compressed format. You can enable compression in the resource settings.

[GZIP](https://en.wikipedia.org/wiki/Gzip) compression is used. Content is sent in compressed form only if the client's request contains an HTTP header indicating gzip support: `Accept-Encoding: gzip`. Otherwise, an uncompressed file is sent.

[Enabling content compression](../operations/resources/enable-compression.md) also helps avoid the situation where compressed files are delivered to users who had not requested compressed content. For more information, see [Troubleshooting in {{ cdn-name }}](../troubleshooting.md#compressed-files).

Files of the following MIME types can be compressed:

* `application/javascript`
* `application/json`
* `application/x-javascript`
* `application/xml`
* `application/xml+rss`
* `image/svg+xml`
* `text/css`
* `text/html`
* `text/javascript`
* `text/plain`
* `text/xml`

The MIME type is determined by the `Content-Type` HTTP header value in the origin's response to the CDN server request.

#### See also {#see-also}

* [Instructions for enabling file compression](../operations/resources/enable-compression.md).