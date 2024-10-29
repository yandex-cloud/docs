# x-yc-apigateway-integration:object_storage extension

The `x-yc-apigateway-integration:object_storage` extension enables {{ objstorage-short-name }} to manage request handling for serving static files.
{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `bucket` | `string` | [Bucket](../../../storage/concepts/bucket.md) name |
| `object` | `string` | [Object](../../../storage/concepts/object.md) name. It supports parameter templating from the path of the original request. <br>`object` is used for parameter substitution. |
| `error_object` | `string` | This is an optional parameter. It specifies the [object](../../../storage/concepts/object.md) name returned if an HTTP error code 4xx is received instead of `object`. `error_object` is used for parameter substitution. |
| `default_object` | `string` | This is an optional parameter. It specifies the name of the [object](../../../storage/concepts/object.md) returned if an HTTP error code 404 is received instead of `object`. `default_object` is used for parameter substitution. |
| `service_account_id` | `string` | ID of the service account used for authorization when accessing {{ objstorage-short-name }}. If it is not specified, its default value is taken from the [parent](./index.md#top-level) `service_account_id`. If the parent parameter is also missing, the object will be available without authorization. |


## Extension specification {#spec}

Specification example:

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
