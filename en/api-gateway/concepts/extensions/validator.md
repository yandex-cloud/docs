---
title: "Data validation in {{ api-gw-full-name }}"
description: "In this tutorial, you will learn about {{ api-gw-name }} extensions that allow you to define a validator for schemas described in the API gateway specification."
---

# Data validation

The `x-yc-apigateway-validators` and `x-yc-apigateway-validator` extensions enable you to define a validator for the following schemas described in the API gateway specification within an [operation](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#operation-object):
* HTTP request body schema (the `content` field in [Request Body Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#request-body-object))
* HTTP request parameter schema (the `schema` field in [Parameter Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#parameter-object))
* HTTP response body schema (the `content` field in [Response Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#response-object))
* HTTP response header schema (the `schema` field in [Header Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#header-object))

## ValidatorObject {#validator_object}

`ValidatorObject` contains OpenAPI specification parameters that allow you to configure HTTP request and response validation by the API gateway.

### Parameters {#validator_object_parameters}

The table below lists the `ValidatorObject` parameters.

 Parameter                    | Type            | Required | Default value | Description
-----------------------------|----------------|--------------|-----------------------|--------------------------------------------------------------
 `validateRequestBody`       | `boolean`      | No          | `false`               | Enabling or disabling request body validation.                                                                       
 `validateRequestParameters` | `boolean`      | No          | `false`               | Enabling or disabling request parameter validation.                                                                 
 `validateResponseBody`      | `boolean`      | No          | `false`               | Enabling or disabling response body validation.                                                                        
 `validateResponseHeaders`   | `string`       | No          | `undefined`           | [Type of response body validation](#type). It may take one of the following values: `any`, `superset`, `subset`, or `exact`. 
 `validationErrorHandler`    | `ErrorHandler` | No          | `undefined`           | [Validation error handler](#errorhandler).

#### Types of response header validation

* `any`: Ignores missing or additional response headers and only checks the header types listed in the specification.
* `superset`: Checks that the headers listed in the specification are included in the list of response headers.
* `subset`: Checks that response headers are included in the list of headers in the specification.
* `exact`: Checks that the list of response headers is exactly the same as the list of headers in the specification.

## ErrorHandler object {#errorhandler}

This object contains parameters for providing validation errors to the integration. For example, you can provide errors to handle to a [function](cloud-functions.md), [container](containers.md), [HTTP integration](http.md) or [return an object from a bucket](object-storage.md).

### Parameters {#errorhandler_parameters}

The table below lists the `ErrorHandler` parameters.

 Parameter                      | Type                                                            | Required | Description 
-------------------------------|----------------------------------------------------------------|--------------|------------------------------------
 `x-yc-apigateway-integration` | [x-yc-apigateway-integration extension](index.md#integration) | Yes           | Integration to invoke if there is a validation error.
 `statusCode`                  | `number`                                                       | No          | Response code the user will get along with the integration response.

If the `ErrorHandler` integration returns a `200` status code in its response, that response will be sent to the user who made the request to the API gateway. To change the response code sent to the user, you can use the `statusCode` parameter in `ErrorHandler`.

If the `ErrorHandler` integration returns an error, the user will get a default validation error message.

## ErrorHandlerEvent object {#errorhandlerevent}

If the API gateway detects an error in the request during validation, it will invoke the integration specified in `ErrorHandler`. The `ErrorHandlerEvent` object with error information is sent to this integration.

### Parameters {#errorhandlerevent_parameters}

The table below lists the `ErrorHandlerEvent` parameters.

 Parameter     | Type             | Description                                                                                      
--------------|-----------------|-------------------------------------------------------------------------------------------------------------------
 `errorType`  | `string`        | Possible values: `response-body-validation-error`, `response-headers-validation-error`, and `request-validation-error`.
 `errorData`  | `ErrorObject[]` | Validation error array
 `statusCode` | `number`        | Validation error code
 `path`       | `string`        | Path in the OpenAPI specification
 `request`    | `object`        | Request that resulted in the error.

## X-yc-apigateway-validators extension {#validators}

The `x-yc-apigateway-validators` extension allows you to describe validators in the [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object) section. You can refer to these validators using the `$ref` parameter in the `x-yc-apigateway-validator` extension and link the same validators to multiple operations or to the entire API gateway. For details, see the `validator` parameter in the [`x-yc-apigateway` extension](index.md#top-level).

## x-yc-apigateway-validator extension {#validator}

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

### Example of a specification with an error handler

```yaml
openapi: "3.0.0"
info:
  title: Sample API
  version: 1.0.0

paths:
  /path-for-humans/{id}:
    get:
      parameters:
        - in: path
          name: id
          schema:
            type: integer
          required: true
          description: Numeric path parameter
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': Hello, World!
        http_code: 200
        http_headers:
          Content-Type: text/plain
      x-yc-apigateway-validator:
        validateRequestParameters: true
        validationErrorHandler:
          x-yc-apigateway-integration:
            bucket: bucket
            type: object_storage
            object: error.html
          statusCode: 400
```
