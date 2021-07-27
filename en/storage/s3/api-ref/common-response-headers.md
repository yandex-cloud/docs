---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Common response headers

Apart from [standard HTTP headers](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields), Yandex {{ objstorage-name }} uses additional headers that can be present in responses.

The table below describes additional headers as well as standard headers that need to be explained in more detail.

| Header | Description |
| ----- | ----- |
| `ETag` | [MD5 hash](https://en.wikipedia.org/wiki/MD5) of an object if the object is uploaded as a single file. If the object is uploaded as a [multipart upload](../../concepts/multipart.md), then to calculate the `ETag`, you need to get the MD5 hash sum of the uploaded parts (let's call it `MD5_sum`) and attach the number of parts (`N`) to the resulting string: `"MD5_sum-N"`.<br/><br/>Does not include object metadata. |
| `x-amz-request-id` | Unique request ID.<br/><br/>You may need it when contacting the Yandex.Cloud support service if any problems occur. |

If a request is sent with CORS headers, the response may contain [headers for a response](object/options.md#response-headers) to the `options` preflight request.

