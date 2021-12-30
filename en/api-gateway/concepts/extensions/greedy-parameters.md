# Greedy parameters

[The OpenAPI Specification 3.0](https://github.com/OAI/OpenAPI-Specification) only allows capturing a single URL segment. To capture multiple segments, add `+` after the parameter name: `/prefix/{param+}/suffix`.

For example, to capture `/static/js/main.js`, add to the specification `/static/{file+}` instead of `/static/{file}`.

Greedy parameters are compatible with all [x-yc-apigateway-integration](./index.md#integration) extension types.

## Extension specification {#spec}

Sample specification:

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

