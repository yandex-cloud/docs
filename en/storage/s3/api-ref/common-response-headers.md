---
title: What response headers exist in the {{ objstorage-full-name }} S3 API
description: In this article, you will learn about the response headers existing in the S3 API.
---

# Common response headers

Apart from the [standard HTTP headers](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields), Yandex {{ objstorage-name }} uses additional response headers.

The table below describes additional headers as well as standard headers requiring clarification.

Header | Description
----- | -----
`ETag` | [MD5 hash](https://en.wikipedia.org/wiki/MD5) of an object if the object is uploaded as a single file. If the object is uploaded as a [multipart upload](../../concepts/multipart.md), then to calculate the `ETag` value, you need to get the MD5 hash sum of the uploaded parts (`MD5_sum`) and add the number of parts (`N`) to the resulting string: `"MD5_sum-N"`.<br/><br/>It does not include object metadata.
`X-Amz-Request-Id` | Unique request ID.<br/><br/>You may need it when contacting the {{ yandex-cloud }} support service if any problems occur.

If a request is sent with CORS headers, the response may contain [headers for a response](object/options.md#response-headers) to the `options` preflight request.

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}