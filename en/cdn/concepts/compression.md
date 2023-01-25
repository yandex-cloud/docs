# Compressing content

You can transmit content from CDN servers to clients in a compressed format. You can enable compression in the resource settings.

[gzip](https://en.wikipedia.org/wiki/Gzip) compression is used. The compressed content is sent only if the client request has an HTTP header indicating GZIP support: `Accept-Encoding: gzip`. Otherwise, an uncompressed file is sent.

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

The MIME type is determined by the value of the `Content-Type` HTTP header in the origin's response to the CDN server request.

#### See also {#see-also}

* [Instructions for enabling file compression](../operations/resources/enable-compression.md).