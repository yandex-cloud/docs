# Common response headers

Apart from [standard HTTP headers](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields), Yandex [!KEYREF objstorage-name] uses additional headers that can be present in responses.

The table below describes additional headers as well as standard headers that need to be explained in more detail.

| Header name | Description |
| ----- | ----- |
| `ETag` | Object hash.<br/><br/>Does not include object metadata. |
| `x-amz-id-2` | Special ID that is used with the `x-amz-request-id` header when solving problems with [!KEYREF objstorage-name]. |
| `x-amz-request-id` | Unique request ID.<br/><br/>You may need it when contacting the Yandex.Cloud support service if any problems occur. |

