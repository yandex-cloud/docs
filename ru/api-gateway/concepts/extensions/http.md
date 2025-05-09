# Расширение x-yc-apigateway-integration:http

Расширение `x-yc-apigateway-integration:http` перенаправляет запрос в указанный URL.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`url`|`string`| URL, по которому необходимо перенаправить вызов. Должен быть доступен из интернета или [пользовательской сети](../networking.md#user-network), которая указана в настройках API-шлюза. <br>В `url` осуществляется подстановка параметров.
`method`|`enum`| Необязательный параметр. HTTP-метод, используемый для вызова. Если параметр не указан, используется метод запроса к {{ api-gw-short-name }}.
`headers`|`map[string](string \| string[])`| HTTP-заголовки, которые передаются. По умолчанию заголовки исходного запроса не передаются. <br>В `headers` осуществляется подстановка параметров.
`query`|`map[string](string \| string[])`| Query-параметры, которые передаются. По умолчанию query-параметры исходного запроса не передаются. <br>В `query` осуществляется подстановка параметров.
`timeouts`|`object`| `read` и `connect` таймауты для выполнения вызова. Значение задается в секундах и не должно превышать [установленный лимит](../limits.md#api-gw-limits). Необязательный параметр. Если значение не задано, HTTP-запросы будут прерываться по истечении таймаута, заданного для API-шлюза.
`omitEmptyHeaders`|`boolean`| Необязательный параметр. Если установлено значение `true`, пустые заголовки не передаются.
`omitEmptyQueryParameters`|`boolean`| Необязательный параметр. Если установлено значение `true`, пустые query-параметры не передаются.
`serviceAccountId` | `string` | Идентификатор сервисного аккаунта. Используется для авторизации при обращении к указанному URL. Значение [верхнеуровневого параметра](index.md#top-level) `serviceAccountId` игнорируется.

## Спецификация расширения {#spec}

Пример спецификации:

```yaml
x-yc-apigateway-integration:
  type: http
  url: https://example.com/backend1
  method: POST
  headers:
    Authorization: Basic ZjTqBB3f$IF9gdYAGlMrs2********
  query:
    my_param: myInfo
  timeouts:
    connect: 0.5
    read: 5
```

Особенности расширения:
* Если значение заголовка или query-параметра — массив, оно передается одной строкой через запятую.
* По умолчанию заголовки, кроме `User-Agent`, и query-параметры исходного запроса не передаются. Чтобы передавать все заголовки и query-параметры исходного запроса, которые не переопределены в спецификации, в блоках `query` и `headers` добавьте строку `'*': '*'`. Чтобы не передавать некоторые заголовки, установите для них пустое значение и значение поля `omitEmptyHeaders`, равным `true`. Аналогично можно не передавать некоторые query-параметры, используя поле `omitEmptyQueryParameters`.
* Заголовок `User-Agent` передается по умолчанию, если не переопределен в спецификации.
* Чтобы перенаправлять все запросы, используйте [жадные параметры](./greedy-parameters.md) и [обобщенный HTTP-метод](./any-method.md).

Пример проксирования всех запросов на `https://example.com`, где передаются заголовок `Content-Type` и query-параметр `param`:
```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0
paths:
  /{path+}:
    x-yc-apigateway-any-method:
      x-yc-apigateway-integration:
        type: http
        url: https://example.com/{path}
        headers:
          Content-Type: '{Content-Type}'
        query:
          param: '{param}'
        timeouts:
          connect: 0.5
          read: 5
      parameters:
      - name: Content-Type
        in: header
        required: false
        schema:
          type: string
      - name: path
        in: path
        required: false
        schema:
          type: string
      - name: param
        in: query
        required: false
        schema:
          type: string
```

Пример проксирования всех запросов на `https://example.com`, где:
* передаются все заголовки, кроме `Foo-Header`, и все query-параметры, кроме `foo_param`;
* добавляются заголовок `Bar-Header` и query-параметр `bar_param`, значения которых — массив.
```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0
paths:
  /{path+}:
    x-yc-apigateway-any-method:
      x-yc-apigateway-integration:
        type: http
        url: https://example.com/{path}
        query:
          '*': '*'
          foo_param: ""
          bar_param: [ "one", "two" ]
          single_param: three
        headers:
          Host: example.com
          '*': '*'
          Foo-Header: ""
          Bar-Header: [ "one", "two" ]
          Single-header: three
        omitEmptyHeaders: true
        omitEmptyQueryParameters: true
      parameters:
      - name: path
        in: path
        required: false
        schema:
          type: string
```

## Примеры использования {#examples}

* [{#T}](../../tutorials/jwt-authorizer-firebase.md)
