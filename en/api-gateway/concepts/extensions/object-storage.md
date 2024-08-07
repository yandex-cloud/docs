# x-yc-apigateway-integration:object_storage extension

The `x-yc-apigateway-integration:object_storage` extension turns over control of request handling to {{ objstorage-short-name }} to distribute static files.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `bucket` | `string` | [Bucket](../../../storage/concepts/bucket.md) name |
| `object` | `string` | [Object](../../../storage/concepts/object.md) name. Supports parameter standardization from the path of the original request. <br>Parameters are substituted in `object`. |
| `error_object` | `string` | This is an optional parameter. [Object](../../../storage/concepts/object.md) name returned if an HTTP error code 4xx is received instead of `object`. Parameters are substituted in `error_object`. |
| `default_object` | `string` | This is an optional parameter. The name of the [object](../../../storage/concepts/object.md) returned if an HTTP error code 404 is received instead of `object`. Parameters are substituted in `default_object`. |
| `service_account_id` | `string` | ID of the service account used for authorization when accessing {{ objstorage-short-name }}. If not specified, it defaults to the [top-level](./index.md#top-level) `service_account_id` parameter. If there is no top-level parameter either, the object is available without authorization. |


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
        bucket: <bucket_name>
        object: '{file}'
        error_object: error.html
        service_account_id: ajehfe65fhl********
```
