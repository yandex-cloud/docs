# CORS

The `x-yc-apigateway-cors-rules` and `x-yc-apigateway-cors` extensions allow you to configure automatic processing of [preflight requests](https://developer.mozilla.org/en-US/docs/Glossary/Preflight_request) based on the [CORS](https://developer.mozilla.org/en-US/docs/Glossary/CORS) feature.

## CorsRuleObject {#corsrule_object}

`CorsRuleObject` contains OpenAPI specification parameters that allow you to define a rule for handling [CORS](https://developer.mozilla.org/en-US/docs/Glossary/CORS) preflight requests.

### Parameters {#corsrule_object_parameters}

The table below lists the `CorsRuleObject` parameters.

 Parameter               | Type                             | Required | Description                                                                                                                                                                                                                                                                                                                                                                                   
------------------------|---------------------------------|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 `origin`               | `boolean`, `string`, `string[]` | Yes           | Defines the `Access-Control-Allow-Origin` header contents. If `false`, there is no CORS processing and the header is not included in the response. If `true`, the header will include the `Origin` request header contents. If the value is set as a string or an array of strings, it is inserted into the `Access-Control-Allow-Origin` response header as is.
 `methods`              | `string`, `string[]`            | No          | Defines the contents of the `Access-Control-Allow-Methods` header. It can be set as a string with a comma-separated list of allowed HTTP methods or as an array of strings with one HTTP method in each. If not specified, the header will include the `Access-Control-Request-Headers` request header contents.                                                                             
 `allowedHeaders`       | `string`, `string[]`            | No          | Defines the contents of the `Access-Control-Allow-Headers` header. It can be set as a string with a comma-separated list of allowed headers or as an array of strings with one header in each. If it is not specified, the header is not included in the response.                                                                                                                                                
 `exposedHeaders`       | `string`, `string[]`            | No          | Defines the contents of the `Access-Control-Expose-Headers` header. It can be set as a string with a comma-separated list of allowed headers or as an array of strings with one header in each.  If it is not specified, the header is not included in the response.                                                                                                                                              
 `credentials`          | `boolean`                       | No          | Defines the contents of the `Access-Control-Allow-Credentials` header. If it is not specified, the header is not included in the response.                                                                                                                                                                                                                                                                    
 `maxAge`               | `integer`                       | No          | Defines the contents of the `Access-Control-Max-Age` header. If it is not specified, the header is not included in the response.                                                                                                                                                                                                                                                                              
 `optionsSuccessStatus` | `integer`                       | No          | Determines the successful response code for a preflight request. The default value is 200.                                                                                                                                                                                                                                                                                                          

## X-yc-apigateway-cors-rules extension {#cors-rules}

With `x-yc-apigateway-cors-rules`, you can describe rules for handling preflight requests in the [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object) section. You can reference the rules set in this way using the `$ref` parameter in the `x-yc-apigateway-cors` extension and apply them to different paths or the entire API gateway. For details, see `cors` for [`x-yc-apigateway` extension](index.md#top-level).

## X-yc-apigateway-cors extension {#cors}

With `x-yc-apigateway-cors`, you can apply a rule for handling preflight requests to a specific [path](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#path-item-object). The extension type is [CorsRuleObject](#corsrule_object).

## Specification examples {#spec}

### Example of a specification with a rule that allows any HTTP requests with any headers and from any domains

In this example, CORS preflight request processing is set up for the entire API gateway. The rule is set at the top level using the `x-yc-apigateway` extension's `cors` parameter.

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

x-yc-apigateway:
  cors:
    origin: '*'
    methods: '*'
    allowedHeaders: '*'

paths:
  /pets/{petId}:
    get:
      operationId: petById
      parameters:
        - in: path
          name: petId
          schema:
            type: integer
          required: true
          description: Pet identifier
      responses:
        '200':
          description: Pet
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/Pet"
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95icn**********

components:
  schemas:
    Pet:
      type: object
      required:
        - id
        - name
      properties:
        id:
          type: integer
        name:
          type: string
```

### Example of a specification that overrides a CORS rule

In this example, a general rule defined at the top level for the entire API gateway is overridden at the level of a specific path. The `false` value of the `origin` parameter disables preflight request processing in the API gateway, and the request is sent to an integration function. All CORS headers received in function responses are transmitted as is to a response from the API gateway.

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

x-yc-apigateway:
  cors:
    origin: '*'
    methods: '*'
    allowedHeaders: '*'

paths:
  /pets/{petId}:
    x-yc-apigateway-cors:
      origin: false
    options:
      operationId: prefligh********
      parameters:
        - in: path
          name: petId
          schema:
            type: integer
          required: true
          description: Pet identifier
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95icn**********
```

### Specification example with a CORS rule that copies the `Origin` header to a response

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

paths:
  /pets/{petId}:
    x-yc-apigateway-cors:
      origin: true
      methods: [GET,POST,DELETE]
      allowedHeaders: x-custom-header
      exposedHeaders: x-custom-header
      maxAge: 3600
    get:
      operationId: petById
      parameters:
        - in: path
          name: petId
          schema:
            type: integer
          required: true
          description: Pet identifier
      responses:
        '200':
          description: Pet
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/Pet"
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95icn**********

components:
  schemas:
    Pet:
      type: object
      required:
        - id
        - name
      properties:
        id:
          type: integer
        name:
          type: string
```

### Example of a specification with a CORS rule defined in the `components` section

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

paths:
  /pets/{petId}:
    x-yc-apigateway-cors:
      $ref: "#/components/x-yc-apigateway-cors-rules/cors-rule"
    get:
      operationId: petById
      parameters:
        - in: path
          name: petId
          schema:
            type: integer
          required: true
          description: Pet identifier
      responses:
        '200':
          description: Pet
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/Pet"
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95icn**********

components:
  x-yc-apigateway-cors-rules:
    cors-rule:
      origin:
        - https://foo.bar.org
        - https://foo1.bar2.org
      methods:
        - GET
        - POST
      allowedHeaders:
        - x-header-1
        - x-header-2
      exposedHeaders:
        - x-header-1
        - x-header-2
      credentials: true
      maxAge: 3600
      optionsSuccessStatus: 204

  schemas:
    Pet:
      type: object
      required:
        - id
        - name
      properties:
        id:
          type: integer
        name:
          type: string
```
