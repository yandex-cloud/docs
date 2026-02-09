---
subcategory: Cloud Logging
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/api_gateway.md
---

# yandex_api_gateway (Resource)

Allows management of [Yandex Cloud API Gateway](https://yandex.cloud/docs/api-gateway/).

## Example usage

```terraform
//
// Create a new API Gateway
//
resource "yandex_api_gateway" "test-api-gateway" {
  name        = "some_name"
  description = "any description"
  labels = {
    label       = "label"
    empty-label = ""
  }
  custom_domains {
    fqdn           = "test.example.com"
    certificate_id = "<certificate_id_from_cert_manager>"
  }
  connectivity {
    network_id = "<dynamic network id>"
  }
  variables = {
    installation = "prod"
  }
  canary {
    weight = 20
    variables = {
      installation = "dev"
    }
  }
  log_options {
    log_group_id = "<log group id>"
    min_level    = "ERROR"
  }
  execution_timeout = "300"
  spec              = <<-EOT
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Test API
x-yc-apigateway:
  variables:
    installation:
      default: "prod"
      enum:
       - "prod"
       - "dev"
paths:
  /hello:
    get:
      summary: Say hello
      operationId: hello
      parameters:
        - name: user
          in: query
          description: User name to appear in greetings
          required: false
          schema:
            type: string
            default: 'world'
      responses:
        '200':
          description: Greeting
          content:
            'text/plain':
              schema:
                type: "string"
      x-yc-apigateway-integration:
        type: dummy
        http_code: 200
        http_headers:
          'Content-Type': "text/plain"
        content:
          'text/plain': "Hello again, {user} from ${apigw.installation} release!\n"
EOT
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `domain` (*Read-Only*) (String). Default domain for the Yandex Cloud API Gateway. Generated at creation time.
- `execution_timeout` (String). Execution timeout in seconds for the Yandex Cloud API Gateway.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group_id` (*Read-Only*) (String). ID of the log group for the Yandex Cloud API Gateway.
- `name` (**Required**)(String). The resource name.
- `spec` (**Required**)(String). The OpenAPI specification for Yandex Cloud API Gateway.
- `status` (*Read-Only*) (String). Status of the Yandex Cloud API Gateway.
- `user_domains` (*Read-Only*) (Set Of String). 

    {% note warning %}

    **DEPRECATED** Use `custom_domains` instead. Set of user domains attached to Yandex Cloud API Gateway.

    {% endnote %}
- `variables` (Map Of String). A set of values for variables in gateway specification.
- `canary` [Block]. Canary release settings of gateway.
  - `variables` (Map Of String). A list of values for variables in gateway specification of canary release.
  - `weight` (Number). Percentage of requests, which will be processed by canary release.
- `connectivity` [Block]. Gateway connectivity. If specified the gateway will be attached to specified network.
  - `network_id` (**Required**)(String). Network the gateway will have access to. It's essential to specify network with subnets in all availability zones.
- `custom_domains` [Block]. Set of custom domains to be attached to Yandex Cloud API Gateway.
  - `certificate_id` (**Required**)(String). 
  - `domain_id` (String). 
  - `fqdn` (**Required**)(String). 
- `log_options` [Block]. Options for logging from Yandex Cloud API Gateway.
  - `disabled` (Bool). Is logging from Yandex Cloud API Gateway disabled.
  - `folder_id` (String). Log entries are written to default log group for specified folder.
  - `log_group_id` (String). Log entries are written to specified log group.
  - `min_level` (String). Minimum log entry level.


