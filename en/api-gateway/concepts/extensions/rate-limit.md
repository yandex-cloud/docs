# Request rate limit

{% include [note-preview-by-request](../../../_includes/note-preview.md) %}

The `x-yc-apigateway-rate-limits` and `x-yc-apigateway-rate-limit` extensions allow you to set a request rate limit. You can set limits for an API gateway or specific paths and HTTP methods. If the number of requests at a given time exceeds the value set in the specification, new requests will not be handled and you will get the `429 Too Many Requests` HTTP status code.

{{ api-gw-name }} does not guarantee that it will always limit the request handling rate to the exact value provided in the specification.

## RateLimitObject {#rate_limit_object}

`RateLimitObject` is a set of OpenAPI specification parameters that allows you to set the request rate limit.

`RateLimitObject` has the following structure:

```yaml
  allRequests:
    rps: <maximum_number_of_requests_per_second>
    rpm: <maximum_number_of_requests_per_minute>
```

You should specify either `rps` or `rpm` but not both at once.

## x-yc-apigateway-rate-limits extension {#rate-limits}

The `x-yc-apigateway-rate-limits` extension allows you to set request rate limits in the [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object) section. You can reference these limits using the `$ref` parameter in the `x-yc-apigateway-rate-limit` extension and link them to different paths and operations (HTTP methods) or to the entire API gateway. For details, see `rateLimit` for [`x-yc-apigateway`](index.md#top-level).

## x-yc-apigateway-rate-limit extension {#rate-limit}

The `x-yc-apigateway-rate-limit` extension allows you to set the request rate limit for all operations in a [path](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#path-item-object) or for a specific [operation](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#operation-object). The extension type is [RateLimitObject](#rate_limit_object). Limits for paths with [greedy parameters](greedy-parameters.md) are currently not supported.

## Specification examples {#spec}

### Example of a specification with a limit on the number of requests per second that applies to the entire API gateway

In this example, the rate is limited for all requests to the API gateway. The limit is set at the top level using the `rateLimit` parameter of the `x-yc-apigateway` extension.

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

x-yc-apigateway:
  rateLimit:
    allRequests:
      rps: 10

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

### Example of a specification with a global limit overridden at the path level

In this example, a general request rate limit set at the top level for the entire API gateway is overridden at the level of a specific path.

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

x-yc-apigateway:
  rateLimit:
    allRequests:
      rps: 10

paths:
  /pets/{petId}:
    x-yc-apigateway-rate-limit:
      allRequests:
        rpm: 100
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

### Example of a specification with a limit set for a specific operation

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

paths:
  /pets/{petId}:
    get:
      x-yc-apigateway-rate-limit:
        allRequests:
          rpm: 10
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

### Example of a specification with a limit set in the `components` section

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

paths:
  /pets/{petId}:
    x-yc-apigateway-rate-limit:
      $ref: "#/components/x-yc-apigateway-rate-limits/get-rate-limit"
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
  x-yc-apigateway-rate-limits:
    get-rate-limit:
      allRequests:
        rpm: 10

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
