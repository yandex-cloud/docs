# Greedy parameters

[OpenAPI Specification 3.0](https://github.com/OAI/OpenAPI-Specification) only allows capturing a single URL segment. To capture multiple segments, add `+` after the parameter name, such as `/prefix/{param+}/suffix`.

For example, to capture `/static/js/main.js`, add `/static/{file+}` instead of `/static/{file}` to the specification.

Greedy parameters are compatible with all the [x-yc-apigateway-integration](./index.md#integration) extension types.

## Extension specification {#spec}

Specification example:

```yaml
/static/{file+}:
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
```

## Use cases {#examples}

* [{#T}](../../tutorials/deploy-app-container.md)
