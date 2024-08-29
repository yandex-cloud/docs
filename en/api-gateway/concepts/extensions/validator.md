---
title: "Data validation in {{ api-gw-full-name }}"
description: "In this tutorial, you will learn about {{ api-gw-name }} extensions that allow you to define a validator for schemas described in an API gateway's specification."
---

# Data validation

The `x-yc-apigateway-validators` and `x-yc-apigateway-validator` extensions allow you to define a validator for the following schemas described in the API gateway specification within an [operation](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#operation-object):
* HTTP request body schema (the `content` field in [Request Body Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#request-body-object)).
* HTTP request parameter schema (the `schema` field in [Parameter Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#parameter-object)).
* HTTP response body schema (the `content` field in [Response Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#response-object)).
* HTTP response header schema (the `schema` field in [Header Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#header-object)).

## ValidatorObject {#validator_object}

`ValidatorObject` contains OpenAPI specification parameters that allow you to configure HTTP request and response validation by the API gateway.

### Parameters {#validator_object_parameters}

The table below lists the `ValidatorObject` parameters.

| Parameter | Type | Required | Default value | Description |
-----------------------------|-----------|--------------|-----------------------|--------------------------------------------------------------------------------------------------------------------
| `validateRequestBody` | `boolean` | No | `false` | Enabling or disabling request body validation. |
| `validateRequestParameters` | `boolean` | No | `false` | Enabling or disabling request parameter validation. |
| `validateResponseBody` | `boolean` | No | `false` | Enabling or disabling response body validation. |
| `validateResponseHeaders` | `string` | No | `undefined` | [Type of response body validation](#type). The possible values are `any`, `superset`, `subset`, and `exact`. |

#### Types of response header validation

* `Any`: Ignores missing or additional response headers and only validates the header types listed in the specification.
* `Superset`: Checks that the headers listed in the specification are included in the list of response headers.
* `Subset`: Checks that response headers are included in the list of headers in the specification.
* `Exact`: Checks that the list of response headers is exactly the same as the list of headers in the specification.

## X-yc-apigateway-validators extension {#validators}

The `x-yc-apigateway-validators` extension allows you to describe validators in the [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object) section. You can refer to these validators using the `$ref` parameter in the `x-yc-apigateway-validator` extension and link the same validators to multiple operations or to the entire API gateway. For details, see `validator` for [`x-yc-apigateway`](index.md#top-level).

## X-yc-apigateway-validator extension {#validator}

The `x-yc-apigateway-validator` extension allows you to link a validator to an [operation](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#operation-object). The extension type is [ValidatorObject](#validator_object).

## Specification examples {#spec}

### Example of a specification with HTTP request URI and path parameter validation

In this example, validation is set up for all operations of the API gateway. The validator is defined at the top level using the `validator` parameter of the `x-yc-apigateway` extension.

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

x-yc-apigateway:
  validator:
    validateRequestParameters: true

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

### Example of a specification with HTTP request query parameter validation

In this example, the validator is moved to the `components` section. This allows you to reference the same validator in different operations.

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

paths:
  /pets:
    get:
      operationId: petsByIds
      parameters:
        - in: query
          name: ids
          style: form
          explode: false
          schema:
            type: array
            items:
              type: integer
              minItems: 1
      responses:
        '200':
          description: Pets
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/Pets"
      x-yc-apigateway-validator:
        $ref: "#/components/x-yc-apigateway-validators/request-params-validator"
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95icn**********

components:
  x-yc-apigateway-validators:
    request-params-validator:
      validateRequestParameters: true

  schemas:
    Pets:
      items:
        "$ref": "#/components/schemas/Pet"
      type: array
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

### Example of a specification with HTTP request and response header validation

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

x-yc-apigateway:
  validator:
    $ref: "#/components/x-yc-apigateway-validators/auth-validator"

paths:
  /users/me:
    get:
      operationId: myUserProfile
      parameters:
        - in: header
          name: Authorization
          schema:
            type: string
          required: true
          description: Authorization token
      responses:
        '200':
          description: User
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/User"
        '401':
          description: User
          headers:
            WWW-Authenticate:
              schema:
                type: string
              required: true
              description: Authentication scheme
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95icn**********

components:
  x-yc-apigateway-validators:
    auth-validator:
      validateRequestParameters: true
      validateResponseHeaders: superset

  schemas:
    User:
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

### Example of a specification with HTTP request and response body validation

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Petstore API

paths:
  /pets:
    post:
      operationId: creatPet
      requestBody:
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/Pet"
      responses:
        '200':
          description: Pet
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/Pet"
      x-yc-apigateway-validator:
        validateRequestBody: true
        validateResponseBody: true
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
