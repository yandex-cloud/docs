# CORS

Расширения `x-yc-apigateway-cors-rules` и `x-yc-apigateway-cors` позволяют настроить автоматическую обработку [preflight-запросов](https://developer.mozilla.org/en-US/docs/Glossary/Preflight_request) в соответствии с механизмом [CORS](https://developer.mozilla.org/en-US/docs/Glossary/CORS).

## CorsRuleObject {#corsrule_object}

`CorsRuleObject` или правило CORS — набор параметров спецификации OpenAPI, который позволяет определить правило обработки preflight-запросов в соответствии с [CORS](https://developer.mozilla.org/en-US/docs/Glossary/CORS).

### Параметры {#corsrule_object_parameters}

В таблице ниже перечислены параметры объекта `CorsRuleObject`.

 Параметр               | Тип                             | Обязательный | Описание                                                                                                                                                                                                                                                                                                                                                                                   
------------------------|---------------------------------|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 `origin`               | `boolean`, `string`, `string[]` | Да           | Определяет содержимое заголовка `Access-Control-Allow-Origin`. Если значение равно `false`, обработка CORS не выполняется и заголовок не передается в ответе. Если значение равно `true`, в заголовке передается содержимое заголовка запроса `Origin`. Если значение задано строкой или массивом строк, оно подставляется без изменений в заголовок ответа `Access-Control-Allow-Origin`.
 `methods`              | `string`, `string[]`            | Нет          | Определяет содержимое заголовка `Access-Control-Allow-Methods`. Может задаваться строкой с перечислением разрешенных HTTP-методов через запятую или массивом строк по одному HTTP-методу в каждой. Если не задан, в заголовке передается содержимое заголовка запроса `Access-Control-Request-Headers`.                                                                             
 `allowedHeaders`       | `string`, `string[]`            | Нет          | Определяет содержимое заголовка `Access-Control-Allow-Headers`. Может задаваться строкой с перечислением разрешенных заголовков через запятую или массивом строк по заголовку в каждой. Если не задан, заголовок не передается в ответе.                                                                                                                                                
 `exposedHeaders`       | `string`, `string[]`            | Нет          | Определяет содержимое заголовка `Access-Control-Expose-Headers`. Может задаваться строкой с перечислением разрешенных заголовков через запятую или массивом строк по заголовку в каждой.  Если не задан, заголовок не передается в ответе.                                                                                                                                              
 `credentials`          | `boolean`                       | Нет          | Определяет содержимое заголовка `Access-Control-Allow-Credentials`. Если не задан, заголовок не передается в ответе.                                                                                                                                                                                                                                                                    
 `maxAge`               | `integer`                       | Нет          | Определяет содержимое заголовка `Access-Control-Max-Age`. Если не задан, заголовок не передается в ответе.                                                                                                                                                                                                                                                                              
 `optionsSuccessStatus` | `integer`                       | Нет          | Определяет код успешного ответа для preflight-запроса. Значение по-умолчанию — 200.                                                                                                                                                                                                                                                                                                          

## Расширение x-yc-apigateway-cors-rules {#cors-rules}

Расширение `x-yc-apigateway-cors-rules` позволяет описывать различные правила обработки preflight-запросов в секции [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object). На определенные таким образом правила можно ссылаться с помощью параметра `$ref` в расширении `x-yc-apigateway-cors` и подключать их к разным путям или ко всему API-шлюзу (см. параметр `cors` [расширения `x-yc-apigateway`](index.md#top-level)).

## Расширение x-yc-apigateway-cors {#cors}

Расширение `x-yc-apigateway-cors` позволяет подключать правило обработки preflight-запросов к конкретному [пути](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#path-item-object) и имеет тип [CorsRuleObject](#corsrule_object).

## Примеры спецификаций {#spec}

### Пример спецификации с правилом, разрешающим любые HTTP-запросы с любыми заголовками и с любых доменов

В данном примере обработка preflight-запросов CORS настроена для всего API-шлюза. Правило определяется на верхнем уровне через параметр `cors` расширения `x-yc-apigateway`.

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

### Пример спецификации с переопределением правила CORS

В данном примере общее правило, определенное на верхнем уровне для всего API-шлюза, переопределяется на уровне конкретного пути. Значение `false` параметра `origin` отключает обработку preflight-запросов в API-шлюзе, и запрос передается в функцию-интеграцию. Все СОRS-заголовки, которые приходят в ответе от функции, прокидываются без изменения в ответ от API-шлюза.

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

### Пример спецификации с правилом CORS, копирующим заголовок `Origin` в ответ

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

### Пример спецификации с определением правила CORS в секции components

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
