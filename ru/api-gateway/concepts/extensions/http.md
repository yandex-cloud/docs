# Расширение x-yc-apigateway-integration:http

Расширение `x-yc-apigateway-integration:http` перенаправляет запрос в указанный URL.

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`url`|`string`| URL, по которому необходимо перенаправить вызов (должен быть доступен из интернета). <br>В `url` осуществляется подстановка параметров.
`method`|`enum`| Необязательный параметр. HTTP-метод, используемый для вызова. Если параметр не указан, используется метод запроса к {{ api-gw-short-name }}.
`headers`|`map[string]string`| HTTP-заголовки, которые будут переданы. Заголовки исходного запроса не передаются. <br>В `headers` осуществляется подстановка параметров.
`timeouts`|`object`| Необязательный параметр. `read` и `connect` таймауты для выполнения вызова, в секундах.

## Спецификация расширения {#spec}

Пример спецификации:

```yaml
x-yc-apigateway-integration:
  type: http
  url: https://example.com/backend1
  method: POST
  headers:
    Authorization: Basic ZjTqBB3f$IF9gdYAGlMrs2fuINjHsz
  timeouts:
    connect: 0.5
    read: 5
```
Особенности расширения:
* По умолчанию заголовки, кроме `User-Agent`, и параметры исходного запроса не передаются. Их необходимо указать в спецификации. Заголовок `User-Agent` передается, если не переопределен в спецификации.
* По умолчанию query-параметры исходного запроса не передаются. Их необходимо объявить в разделе `parameters` и явно указать в поле `url`.
* Для перенаправления всех запросов можно использовать специальный метод `x-yc-apigateway-any-method`.

Более сложный пример, перенаправляющий все запросы на домен `example.com`:
```yaml
paths:
  /{path+}:
    x-yc-apigateway-any-method:
      x-yc-apigateway-integration:
        type: http
        url: https://example.com/{path}?param={param}
        headers:
          Content-Type: '{Content-Type}'
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
