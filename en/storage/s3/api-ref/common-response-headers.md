---
title: What response headers exist in the {{ objstorage-full-name }} S3 API
description: In this tutorial, you will learn about the request headers existing in the S3 API.
---

# Common response headers

Apart from [standard HTTP headers](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields), Yandex {{ objstorage-name }} uses additional headers that can be present in responses.

The table below describes additional headers as well as standard headers that need to be explained in more detail.

| Header | Description |
----- | -----
| `ETag` | [MD5 hash](https://en.wikipedia.org/wiki/MD5) of an object if the object is uploaded as a single file. If the object is uploaded as a [multipart](../../concepts/multipart.md) upload, then to calculate the `ETag`, you need to get the MD5 hash sum of the uploaded parts (let's call it `MD5_sum`) and attach the number of parts (`N`) to the resulting string: `"MD5_sum-N"`.<br/><br/>Does not include object metadata. |
| `X-Amz-Request-Id` | Unique request ID.<br/><br/>You may need it when contacting the {{ yandex-cloud }} support service if any problems occur. |

If a request is sent with CORS headers, the response may contain [headers for a response](object/options.md#response-headers) to the `options` preflight request.

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}