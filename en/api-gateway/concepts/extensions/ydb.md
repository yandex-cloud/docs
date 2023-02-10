# x-yc-apigateway-integration:cloud_ydb extension

`x-yc-apigateway-integration:cloud_ydb` enables you to perform operations with [document tables](../../../ydb/concepts/dynamodb-tables.md) in a {{ ydb-full-name }} database. For interaction with {{ ydb-short-name }}, the [Document API](../../../ydb/docapi/api-ref/index.md) compatible with Amazon DynamoDB is used.

## Supported operations

| Operation | Supported parameters | What returns {{ api-gw-name }} in JSON format<br/>if the operation is successful |
----|----|-----
| [PutItem](../../../ydb/docapi/api-ref/actions/putItem.md) | `table_name` | Element saved in the table |
| [GetItem](../../../ydb/docapi/api-ref/actions/getItem.md) | `table_name`<br/>`key` | Element read from table |
| [UpdateItem](../../../ydb/docapi/api-ref/actions/updateItem.md) | `table_name`<br/>`key`<br/>`update_expression`<br/>`expression_attribute_values` | Element updated in the table |
| [DeleteItem](../../../ydb/docapi/api-ref/actions/deleteItem.md) | `table_name`<br/>`key` | Element deleted from the table |
| [Scan](../../../ydb/docapi/api-ref/actions/scan.md) | `table_name`<br/>`limit`<br/>`exclusive_start_key` | A list of elements read from the table |

To convert the request body into an associative array with values of the [AttributeValue](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html) type and place it into the `Item` parameter when performing the `PutItem` operation, pass it in JSON format.

If an object in JSON format emerges for the `UpdateItem` operation, the [AttributeUpdates](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributeUpdates.html) set of changes will be generated and placed into the appropriate operation parameter.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Required | Parameter<br/>placement | Description |
----|----|-----|----|----
| `action` | `string` | Yes | No | Operation in progress. Possible values: `PutItem`, `GetItem`, `UpdateItem`, `DeleteItem`, or `Scan`. |
| `database` | `string` | Yes | No | Relative path to the database. |
| `service_account_id` | `string` | Yes | No | ID of the service account. Used for authorization when performing a database operation. If the parameter is omitted, the value of the `service_account_id` [top-level parameter](./index.md#top-level) is used. |
| `table_name` | `string` | Yes | Yes | Name of the table with which the operation is performed. |
| `key` | `string` | No | Yes | Primary key of the element with which the operation is performed. A set of attributes and their values in JSON format. You must specify all key attributes. Attribute values are automatically converted to objects of the [AttributeValue](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html) type. Used in the [GetItem](../../../ydb/docapi/api-ref/actions/getItem.md), [UpdateItem](../../../ydb/docapi/api-ref/actions/updateItem.md), and [DeleteItem](../../../ydb/docapi/api-ref/actions/deleteItem.md) operations. |
| `update_expression` | `string` | No | Yes | Expression that specifies how and which attributes must be updated. Used in the [UpdateItem](../../../ydb/docapi/api-ref/actions/updateItem.md) operation. |
| `expression_attribute_values` | `string` | No | Yes | Alias that can be used in the `update_expression` expression instead of the attribute value. It must start with a colon `:`. Used in the [UpdateItem](../../../ydb/docapi/api-ref/actions/updateItem.md) operation. |
| `limit` | `string` | No | Yes | Maximum number of elements read. Used in the [Scan](../../../ydb/docapi/api-ref/actions/scan.md) operation. |
| `exclusive_start_key` | `string` | No | Yes | Primary key of the element which the search starts from. A set of attributes and their values in JSON format. Attribute values are automatically converted to objects of the [AttributeValue](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html) type. Used in the [Scan](../../../ydb/docapi/api-ref/actions/scan.md) operation. |

## Extension specification {#spec}

Example of the REST API service that enables you to create, obtain, update, and delete movie entities:

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