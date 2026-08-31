[Документация Yandex Cloud](../../../index.md) > [Yandex API Gateway](../../index.md) > [Концепции](../index.md) > [Расширения спецификации](index.md) > Преобразование тела ответа и запроса

# Расширение x-yc-schema-mapping

Расширение `x-yc-schema-mapping` позволяет преобразовывать JSON-тело запроса к интеграции или ответа от нее.

Расширение предназначено для объекта `Schema` из OpenAPI-спецификации.

## Поддерживаемые параметры {#parameters}

В таблице ниже перечислены параметры, специфичные для API-шлюза сервиса API Gateway. Описание остальных параметров читайте в [спецификации OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).

#|
||
**Параметр**
|
**Тип**
|
**Описание**
||
||
`type`
|
`string`
|
Тип преобразования. Возможные значения: `static` — тело описано статичным ресурсом.
||
|| `template` {align="center"} | `map[string]TemplateObject` | Полное описание тела в виде словаря в формате `<имя_поля>: "<значение_поля>"`. ||
||
^
|
`string`
|
Строка с корректным [jq](https://github.com/jqlang/jq)-шаблоном, позволяющим выбрать нужные данные из тела. Например: `"${.numbers.firstNumber}"`.
|#

## Спецификация расширения {#spec}

Спецификация расширения зависит от типа значения параметра `template`.

Пример спецификации:

{% list tabs %}

- Объект (словарь)

  ```json
  x-yc-schema-mapping:
    type:static
    template:
      property1: "value1"
      property2: "${.baseProperty1.baseProperty2}"
  ```

  Пример преобразования тела ответа, где пользователю возвращается сообщение из двух полей, если функция Cloud Functions возвращает код 200 и заголовок `Content-Type: application/json`:

  ```json
  openapi: "3.0.0"
  info:
    version: 1.0.0
    title: Petstore API

  paths:
    /pets:
      get:
        responses:
          '200':
            description: Pet
            content:
              application/json:
                schema:
                  type: object
                  x-yc-schema-mapping:
                    type: static
                    template:
                      Name: "Dog"
                      Breed: "${.nestedProperty1.nestedProperty2}"
        x-yc-apigateway-integration:
          type: cloud_functions
          function_id: b095c95icn**********
  ```

- jq-шаблон

  ```json
  x-yc-schema-mapping:
    type: static
    template: "${.numbers.firstNumber}"
  ```

  Пример преобразования тела ответа, где пользователю возвращается значение одного из ключей входящего JSON-объекта (число `12`), которое получено в результате применения jq-шаблона, заданного в параметре `template`:

  ```json
  openapi: "3.0.0"
  info:
    version: 1.0.0
    title: Test API

  paths:
    /test:
      get:
        summary: Number
        operationId: Number
        responses:
          200:
            description: Another example
            content:
              application/json:
                schema:
                  type: object
                  x-yc-schema-mapping:
                    type: static
                    template: "${.numbers.firstNumber}"
            x-yc-status-mapping: 201
          x-yc-mapping-index:
            200: application/json
        x-yc-apigateway-integration:
          http_code: 200
          http_headers:
            Content-Type: application/json
            Content-Length: '10'
          type: dummy
          content:
            application/json: '{"numbers":{"firstNumber": 12, "secondNumber": 32}}'
  ```

{% endlist %}

## Примеры использования {#examples}

* [Использование Yandex API Gateway для настройки синтеза речи в Yandex SpeechKit](../../tutorials/speechkit-integrarion-via-agi-gw.md)