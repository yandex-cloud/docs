# x-yc-schema-mapping extension

The `x-yc-schema-mapping` extension allows you to transform the JSON body of a request to an integration or response from it.

The extension is intended for the `Schema` object of the OpenAPI specification.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

#|
||
**Parameter**
|
**Type**
|
**Description**
||
||
`type`
|
`string`
|
Transformation type. The possible value is `static`, i.e., the body is described by a static resource.
||
|| `template` {align="center"} | `map[string]TemplateObject` | Full body description as a dictionary in `<field_name>: "<field_value>"` format. ||
||
^
|
`string`
|
String containing a valid [jq](https://github.com/jqlang/jq) template for extracting the required data from the body, e.g., `"${.numbers.firstNumber}"`.
|#

## Extension specification {#spec}

Extension specification depends on the `template` value type.

Specification example:

{% list tabs %}

- Object (dictionary)

  ```json
  x-yc-schema-mapping:
    type:static
    template:
      property1: "value1"
      property2: "${.baseProperty1.baseProperty2}"
  ```

  Example of response body transformation where a user gets a two-field response if the {{ sf-name }} function returns code 200 and the `Content-Type: application/json` header:

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

- jq_template

  ```json
  x-yc-schema-mapping:
    type: static
    template: "${.numbers.firstNumber}"
  ```

  Example of response body transformation where a user gets a key value from the incoming JSON object (`12`), obtained after applying the jq template set under `template`:

  ```json
  openapi: "3.0.0"
  info:
    version: 1.0.0
    title: Test API

  paths:
    /test:
      get:
        summary: Number
        operationId: Number
        responses:
          200:
            description: Another example
            content:
              application/json:
                schema:
                  type: object
                  x-yc-schema-mapping:
                    type: static
                    template: "${.numbers.firstNumber}"
            x-yc-status-mapping: 201
          x-yc-mapping-index:
            200: application/json
        x-yc-apigateway-integration:
          http_code: 200
          http_headers:
            Content-Type: application/json
            Content-Length: '10'
          type: dummy
          content:
            application/json: '{"numbers":{"firstNumber": 12, "secondNumber": 32}}'
  ```

{% endlist %}

## Use cases {#examples}

* [{#T}](../../tutorials/speechkit-integrarion-via-agi-gw.md)