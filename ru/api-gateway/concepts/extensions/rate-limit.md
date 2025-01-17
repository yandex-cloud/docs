---
title: Ограничение скорости обработки запросов
description: Расширения x-yc-apigateway-rate-limits и x-yc-apigateway-rate-limit позволяют ограничить скорость обработки запросов. Лимиты можно настроить на API-шлюз или конкретные пути и/или HTTP-методы.
---

# Ограничение скорости обработки запросов

{% note warning %}

Данное расширение устарело и больше не поддерживается. Чтобы ограничить скорость обработки запросов, используйте [интеграцию с {{ sws-full-name }}](sws.md).

{% endnote %}

Расширения `x-yc-apigateway-rate-limits` и `x-yc-apigateway-rate-limit` позволяют ограничить скорость обработки запросов. Лимиты можно настроить на API-шлюз или конкретные пути и/или HTTP-методы. Если количество запросов в заданный период времени превышает значение, которое указано в спецификации, новые запросы не обрабатываются и не тарифицируются, а в ответ возвращается статус-код `429 Too Many Requests`.

{{ api-gw-name }} не гарантирует, что всегда точно будет ограничивать скорость обработки запросов до указанной в спецификации.

## RateLimitObject {#rate_limit_object}

`RateLimitObject` — набор параметров спецификации OpenAPI, который позволяет ограничить скорость обработки запросов.

Структура объекта `RateLimitObject`:

```yaml
  allRequests:
    rps: <максимальное_количество_запросов_в_секунду>
    rpm: <максимальное_количество_запросов_в_минуту>
```

Необходимо определить `rps` или `rpm`, но не оба значения вместе.

## Расширение x-yc-apigateway-rate-limits {#rate-limits}

Расширение `x-yc-apigateway-rate-limits` позволяет описывать ограничения скорости обработки запросов в секции [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object). Можно ссылаться на ограничения, которые определены таким образом, с помощью параметра `$ref` в расширении `x-yc-apigateway-rate-limit` и подключать их к разным путям, операциям (HTTP-методам) или ко всему API-шлюзу (см. параметр `rateLimit` [расширения `x-yc-apigateway`](index.md#top-level)).

## Расширение x-yc-apigateway-rate-limit {#rate-limit}

Расширение `x-yc-apigateway-rate-limit` позволяет ограничить скорость обработки запросов для всех операций [пути](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#path-item-object) или для конкретной [операции](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#operation-object). Имеет тип [RateLimitObject](#rate_limit_object). На данный момент не поддерживаются ограничения для путей с [жадными параметрами](greedy-parameters.md).

## Примеры спецификаций {#spec}

### Пример спецификации с ограничением количества запросов в секунду на весь API-шлюз

В данном примере скорость ограничена на все запросы, которые приходят в API-шлюз. Лимит определяется на верхнем уровне через параметр `rateLimit` расширения `x-yc-apigateway`.

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

### Пример спецификации с переопределением глобального лимита на уровне пути

В данном примере общее ограничение скорости запросов, которое определено на верхнем уровне для всего API-шлюза, переопределяется на уровне конкретного пути.

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

### Пример спецификации с ограничением для конкретной операции

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

### Пример спецификации с настройкой лимита в секции `components`

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
