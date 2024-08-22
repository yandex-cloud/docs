# x-yc-status-mapping extension

The `x-yc-status-mapping` extension allows you to replace a response code in an integration. For example, if you get the response code 404 in an [integration with {{ objstorage-name }}](object-storage.md), you can replace it with code 200.

The extension is intended for the `ResponseBody` object from the OpenAPI specification. The extension value is the new response code value.

## Extension specification {#spec}

Specification example:

```json
paths:
  /:
    get:
      responses:
        200:
          description: ""
          content:
            ...
          x-yc-status-mapping: 201
      ...

```
