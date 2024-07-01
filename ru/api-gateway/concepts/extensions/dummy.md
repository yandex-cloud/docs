# Расширение x-yc-apigateway-integration:dummy

Расширение `x-yc-apigateway-integration:dummy` возвращает фиксированное содержимое с указанным кодом ответа и необходимыми заголовками без участия стороннего сервиса.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`http_code` | `int` | Код HTTP-ответа.
`http_headers` | `map[string](string\|[]string)` | Список заголовков, которые будут отправлены в ответ. В `http_headers` осуществляется подстановка параметров.
`content` | `map[string]string` | Данные, которые будут отправлены в ответ. <br>Могут быть как фактическим содержимым, так и отображением из запрошенного `Content-Type` в данные. Это позволяет отдавать ошибки в запрошенном формате — JSON или XML. Для значения по умолчанию используется ключ `*`. В `content` осуществляется подстановка параметров.

## Спецификация расширения {#spec}

Пример спецификации: 

```yaml
x-yc-apigateway-integration:
  type: dummy
  http_code: 302
  http_headers:
    Location: "/some/location"
    Set-Cookie: ["a={number}", "b=2"]
  content:
    "application/json": "{ \"message\": \"You've been redirected.\" }"
```

Особенности расширения:
* Если в запросе есть заголовок `Accept:`
    * Сначала выбирается лучшее соответствие.
    * Если соответствия нет, то выбирается ключ `*`.
    * Если ключа нет, то возвращается ответ `415 Media not supported`. 
* Если заголовка `Accept` нет, то выбирается произвольный вариант ответа.
* Если вариант контента выбран по ключу `*`, то `Content-Type` ответа будет выбран из `http_headers`. Если он там не указан, возвращается фактический `Content-Type`.
