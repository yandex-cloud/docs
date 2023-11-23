---
title: "Валидация данных в {{ api-gw-full-name }}"
description: "Из статьи вы узнаете, какие расширения {{ api-gw-name }} позволяют определить валидатор для схем, описанных в спецификации API-шлюза."
---

# Валидация данных

Расширения `x-yc-apigateway-validators` и `x-yc-apigateway-validator` позволяют определить валидатор для следующих схем, описанных в спецификации API-шлюза внутри [операции](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#operation-object):
* схема тела HTTP-запроса (поле `content` в [Request Body Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#request-body-object));
* схема параметров HTTP-запроса (поле `schema` в [Parameter Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#parameter-object));
* cхема тела HTTP-ответа (поле `content` в [Response Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#response-object));
* схема заголовков HTTP-ответа (поле `schema` в [Header Object](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#header-object)).

## ValidatorObject {#validator_object}

`ValidatorObject` или валидатор — набор параметров спецификации OpenAPI, который позволяет настроить валидацию HTTP-запросов и ответов API-шлюзом.

### Параметры {#validator_object_parameters}

В таблице ниже перечислены параметры объекта `ValidatorObject`.

 Параметр                    | Тип       | Обязательный | Значение по-умолчанию | Описание                                                                                                           
-----------------------------|-----------|--------------|-----------------------|--------------------------------------------------------------------------------------------------------------------
 `validateRequestBody`       | `boolean` | Нет          | `false`               | Включить или выключить валидацию тела запроса.                                                                       
 `validateRequestParameters` | `boolean` | Нет          | `false`               | Включить или выключить валидацию параметров запроса.                                                                 
 `validateResponseBody`      | `boolean` | Нет          | `false`               | Включить или выключить валидацию тела ответа.                                                                        
 `validateResponseHeaders`   | `string`  | Нет          | `undefined`           | [Тип валидации заголовков ответа](#type). Может принимать одно из следующих значений: `any`, `superset`, `subset`, `exact`. 

#### Типы валидации заголовков ответа

* `any` — игнорируются отсутствующие или дополнительные заголовки ответа, проверяются только типы заголовков, перечисленных в спецификации.
* `superset` — проверяется, что заголовки, перечисленные в спецификации, входят в список заголовков ответа.
* `subset` — проверяется, что заголовки ответа входят в список заголовков, перечисленных в спецификации.
* `exact` — проверяется, что список заголовков ответа полностью соответствует списку заголовков, перечисленных в спецификации.

## Расширение x-yc-apigateway-validators {#validators}

Расширение `x-yc-apigateway-validators` позволяет описывать валидаторы в секции [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object). На определенные таким образом валидаторы можно ссылаться с помощью параметра `$ref` в расширении `x-yc-apigateway-validator` и подключать одни и те же валидаторы к разным операциям или ко всему API-шлюзу (см. параметр `validator` [расширения `x-yc-apigateway`](index.md#top-level)).

## Расширение x-yc-apigateway-validator {#validator}

Расширение `x-yc-apigateway-validator` позволяет подключать валидатор к [операции](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#operation-object) и имеет тип [ValidatorObject](#validator_object).

## Примеры спецификаций {#spec}

### Пример спецификации с валидацией URI или path-параметров HTTP-запроса

В данном примере валидация настроена для всех операций API-шлюза. Валидатор определяется на верхнем уровне через параметр `validator` расширения `x-yc-apigateway`.

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

### Пример спецификации с валидацией query-параметров HTTP-запроса

В данном примере валидатор вынесен в секцию `components`. Это позволяет ссылаться на один и тот же валидатор в разных операциях.

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

### Пример спецификации с валидацией заголовков HTTP-запроса и ответа

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

### Пример спецификации с валидацией тела HTTP-запроса и ответа

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
