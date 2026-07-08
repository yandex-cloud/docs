Example of an API gateway description in the {{ TF }} configuration:

```hcl
resource "yandex_api_gateway" "test-api-gateway" {
  name        = "my-gateway"
  description = "any description"
  labels      = {
    label       = "label"
    empty-label = ""
  }
  spec = <<-EOT
    openapi: 3.0.0
    info:
      title: Sample API
      version: 1.0.0
    paths:
      /:
        get:
          x-yc-apigateway-integration:
            type: dummy
            content:
              '*': Hello, World!
            http_code: 200
            http_headers:
              Content-Type: text/plain
  EOT
}
```

For more on the properties of the `yandex_api_gateway` resource in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/api_gateway).