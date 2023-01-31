# Расширение x-yc-apigateway-integration:cloud_ydb

Расширение `x-yc-apigateway-integration:cloud_ydb` позволяет выполнять операции с [документными таблицами](../../../ydb/concepts/dynamodb-tables.md) в базе данных {{ ydb-full-name }}. Чтобы взаимодействовать с {{ ydb-short-name }}, используется [Document API](../../../ydb/docapi/api-ref/index.md), который совместим с Amazon DynamoDB. 

## Поддерживаемые операции

Операция | Поддерживаемые параметры | Что вернет {{ api-gw-name }} в формате JSON,<br/>если операция выполнится успешно
----|----|-----
[PutItem](../../../ydb/docapi/api-ref/actions/putItem.md) | `table_name` | Элемент, сохраненный в таблице
[GetItem](../../../ydb/docapi/api-ref/actions/getItem.md) | `table_name`<br/>`key` | Элемент, прочитанный из таблицы
[UpdateItem](../../../ydb/docapi/api-ref/actions/updateItem.md) | `table_name`<br/>`key`<br/>`update_expression`<br/>`expression_attribute_values` | Элемент, обновленный в таблице
[DeleteItem](../../../ydb/docapi/api-ref/actions/deleteItem.md) | `table_name`<br/>`key` | Элемент, удаленный из таблицы
[Scan](../../../ydb/docapi/api-ref/actions/scan.md) | `table_name`<br/>`limit`<br/>`exclusive_start_key` | Список элементов, прочитанных из таблицы

Чтобы при выполнении операции `PutItem`, тело запроса преобразовалось в ассоциативный массив со значениями типа [AttributeValue](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html) и подставилось в параметр `Item`, передайте его в формате JSON.

Если для операции `UpdateItem` в теле запроса придет объект в формате JSON, из его полей сформируется набор изменений [AttributeUpdates](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributeUpdates.html) и подставится в соответствующий параметр операции.

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Обязательный | Подстановка<br/>параметров | Описание
----|----|-----|----|----
`action` | `string` | Да | Нет | Выполняемая операция. Возможные значения: `PutItem`, `GetItem`, `UpdateItem`, `DeleteItem`, `Scan`.
`database` | `string` | Да | Нет | Относительный путь к базе данных.
`service_account_id` | `string` | Да | Нет | Идентификатор сервисного аккаунта. Используется для авторизации при выполнении операции с базой данных. Если параметр не указан, используется значение [верхнеуровнего параметра](./index.md#top-level) `service_account_id`.
`table_name` | `string` | Да | Да | Название таблицы, с которой выполняется операция.
`key` | `string` | Нет | Да | Первичный ключ элемента, с которым выполняется операция. Набор атрибутов и их значений в формате JSON. Необходимо указать все ключевые атрибуты. Значения атрибутов автоматически преобразовываются в объекты типа [AttributeValue](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html). Используется в операциях [GetItem](../../../ydb/docapi/api-ref/actions/getItem.md), [UpdateItem](../../../ydb/docapi/api-ref/actions/updateItem.md) и [DeleteItem](../../../ydb/docapi/api-ref/actions/deleteItem.md).
`update_expression` | `string` |  Нет | Да | Выражение, которое определяет, как и какие атрибуты нужно обновить. Используется в операции [UpdateItem](../../../ydb/docapi/api-ref/actions/updateItem.md).
`expression_attribute_values` | `string` | Нет | Да | Алиас, который можно использовать в выражении `update_expression` вместо значения атрибута. Алиас должен начинаться с символа двоеточия `:`. Используется в операции [UpdateItem](../../../ydb/docapi/api-ref/actions/updateItem.md).
`limit` | `string` | Нет | Да | Максимальное количество прочитанных элементов. Используется в операции [Scan](../../../ydb/docapi/api-ref/actions/scan.md).
`exclusive_start_key` | `string` | Нет | Да | Первичный ключ элемента, с которого начнется поиск. Набор атрибутов и их значений в формате JSON. Значения атрибутов автоматически преобразовываются в объекты типа [AttributeValue](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html). Используется в операции [Scan](../../../ydb/docapi/api-ref/actions/scan.md).

## Спецификация расширения {#spec}

Пример [REST API](../../../glossary/rest-api.md) сервиса, который позволяет создавать, получать, обновлять и удалять сущности фильмов:

```yaml
openapi: 3.0.0
info:
  title: Movies API
  version: 1.0.0
servers:
  - url: https://d3drb9haai**********.apigw.yandexcloud.net
paths:
  /movies:
    get:
      description: Get movies
      x-yc-apigateway-integration:
        type: cloud_ydb
        action: Scan
        database: /ru-central1/b3g1emj917**********/etn1f5fa8f**********
        table_name: movie
        limit: '{limit}'
        exclusive_start_key: '{"id": "{from}"}'
      operationId: getMovies
      parameters:
        - description: Identifier from which will be queried movies in ascending order
          explode: true
          in: query
          name: from
          required: true
          schema:
            type: string
          style: form
        - description: Maximum number of movies in response
          explode: true
          in: query
          name: limit
          required: false
          schema:
            default: 10.0
            type: number
          style: form
      responses:
        '200':
          content:
            application/json:
              schema:
                items:
                  $ref: '#/components/schemas/Movie'
                type: array
          description: Movies
        default:
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
          description: error
    post:
      description: Create movie
      x-yc-apigateway-integration:
        type: cloud_ydb
        action: PutItem
        database: /ru-central1/b1g1emj927**********/etn1f4fa4f**********
        table_name: movie
      operationId: createMovie
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Movie'
        description: Movie to create
        required: true
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Movie'
          description: Created or updated movie
        default:
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
          description: error
  /movies/{movieId}:
    delete:
      description: Delete movie by id
      x-yc-apigateway-integration:
        type: cloud_ydb
        action: DeleteItem
        database: /ru-central1/b1g1emj927**********/etn1f4fa4f**********
        table_name: movie
        key: '{"id": "{movieId}"}'
      operationId: deleteMovieById
      parameters:
        - description: Identifier of movie
          explode: false
          in: path
          name: movieId
          required: true
          schema:
            type: string
          style: simple
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Movie'
          description: Deleted movie
        default:
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
          description: error
    get:
      description: Get movie by id
      x-yc-apigateway-integration:
        type: cloud_ydb
        action: GetItem
        database: /ru-central1/b1g1emj927**********/etn1f4fa4f**********
        table_name: movie
        key: '{"id": "{movieId}"}'
      operationId: getMovieById
      parameters:
        - description: Identifier of movie
          explode: false
          in: path
          name: movieId
          required: true
          schema:
            type: string
          style: simple
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Movie'
          description: Movie
        default:
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
          description: error
    put:
      description: Update movie by id
      x-yc-apigateway-integration:
        type: cloud_ydb
        action: UpdateItem
        database: /ru-central1/b1g1emj927**********/etn1f4fa4f**********
        table_name: movie
        key: '{"id": "{movieId}"}'
      operationId: updateMovieById
      parameters:
        - description: Identifier of movie
          explode: false
          in: path
          name: movieId
          required: true
          schema:
            type: string
          style: simple
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Movie'
        description: Movie or attributes to update
        required: true
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Movie'
          description: Updated movie
        default:
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
          description: error
components:
  schemas:
    Movie:
      properties:
        year:
          type: integer
        id:
          type: string
        title:
          type: string
      required:
        - id
        - title
        - year
      type: object
    Error:
      properties:
        message:
          type: string
      required:
        - message
      type: object
x-yc-apigateway:
  service_account_id: ajent55o2h**********
```
