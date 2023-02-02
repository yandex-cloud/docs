# x-yc-apigateway-integration:object_storage extension

The `x-yc-apigateway-integration:object_storage` extension passes request handling control to {{ objstorage-short-name }} for distributing static files. Lets you manage the object access key and enables static data distribution directly from {{ objstorage-short-name }} by redirecting to a signed URL.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `bucket` | `string` | [Bucket](../../../storage/concepts/bucket.md) name. |
| `object` | `string` | [Object](../../../storage/concepts/object.md) name. Supports parameter standardization from the path of the original request. <br>Parameters are substituted in `object`. |
| `error_object` | `string` | Optional. [Object](../../../storage/concepts/object.md) name returned if HTTP error code 4xx is received instead of `object`. |
| `presigned_redirect` | `bool` | If the value is `true`, a [pre-signed URL](../../../storage/concepts/pre-signed-urls.md) is generated and a redirect is returned to the client. |
| `service_account_id` | `string` | ID of the service account used for authorization when accessing {{ objstorage-short-name }}. If the parameter is omitted, the value of the [top-level](./index.md#top-level) `service_account_id` parameter is used. If there is no top-level parameter, the object is available without authorization. |


## Extension specification {#spec}

Example specification:

```yaml
  /static/{file}:
    get:
      summary: Serve static file from Yandex Cloud Object Storage
      parameters:
        - name: file
          in: path
          required: true
          schema:
            type: string
      x-yc-apigateway-integration:
        type: object_storage
        bucket: my-example-bucket
        object: '{file}'
        error_object: error.html
        presigned_redirect: true
        service_account_id: ajehfe65fhliq4n28q1
```
