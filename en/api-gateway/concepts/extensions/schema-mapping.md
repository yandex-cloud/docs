# x-yc-schema-mapping extension

The `x-yc-schema-mapping` extension allows you to transform the JSON body of a request to an integration or response from it.

The extension works with the `Schema` object from the OpenAPI specification.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
--- | --- | ---
| `type` | `string` | Transformation type. Possible values: `static` (body described by a static resource). |
| `template` | `map[string]TemplateObject` | Full body description in `<field_name>: "<field_value>"` format. |

## Extension specification {#spec}

Specification example:

```json
x-yc-schema-mapping:
 type:static
 template:
   property1: "value1"
   property2: "${.baseProperty1.baseProperty2}"
```

Example of response body transformation where a user gets in response a two-field message if the {{ sf-name }} function returns code 200 and the `Content-Type: application/json` header:

```json
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

paths:
  /pets:
    get:
      responses:
        '200':
          description: Pet
          content:
            application/json:
              schema:
                type: object
                x-yc-schema-mapping:
                  type: static
                  template:
                    Name: "Dog"
                    Breed: "${.nestedProperty1.nestedProperty2}"
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95icn**********
```
