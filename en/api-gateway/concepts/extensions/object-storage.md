# x-yc-apigateway-integration:object_storage extension

The `x-yc-apigateway-integration:object_storage` extension delegates request handling to {{ objstorage-short-name }} for static file distribution.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Parameter | Type | Description 
----|----|----
`bucket` | `string` | [Bucket](../../../storage/concepts/bucket.md) name.
`object` | `string` | [Object](../../../storage/concepts/object.md) name. It supports parameter templating from the initial request path. <br>The parameters are subsituted into `object`.
`error_object` | `string \| ErrorObjectSettings` | This is an optional parameter. The name of the [object](../../../storage/concepts/object.md) and the optional response code returned if `object` does not exist in the specified `bucket`. The parameters are subsituted into `error_object`.
`service_account_id` | `string` | ID of the service account used for authorization when accessing {{ objstorage-short-name }}. If you omit the parameter, the `service_account_id` [top-level parameter](./index.md#top-level) value will be used. If the parent parameter is also missing, the object will be available without authorization.

The `ErrorObjectSettings` object may contain the following parameters:

Parameter | Type | Description
----|----|----
`object` | `string` | [Object](../../../storage/concepts/object.md) name. The parameters are subsituted into `object`.
`statusCode` | `number` |  Returned response code


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
