[Документация Yandex Cloud](../../../index.md) > [Yandex API Gateway](../../index.md) > [Концепции](../index.md) > [Расширения спецификации](index.md) > Преобразование тела ответа и запроса

# Расширение x-yc-schema-mapping

Расширение `x-yc-schema-mapping` позволяет преобразовывать JSON-тело запроса к интеграции или ответа от нее.

Расширение предназначено для объекта `Schema` из OpenAPI-спецификации.

 ## Поддерживаемые параметры {#parameters}

В таблице ниже перечислены параметры, специфичные для API-шлюза сервиса API Gateway. Описание остальных параметров читайте в [спецификации OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).

 Параметр | Тип | Описание
 --- | --- | ---
 `type` | `string` | Тип преобразования. Возможные значения: `static` — тело описано статичным ресурсом.
 `template` | `map[string]TemplateObject` | Полное описание тела в формате `<название_поля>: "<значение_поля>"`.

 ## Спецификация расширения {#spec}

 Пример спецификации:

 ```json
x-yc-schema-mapping:
  type:static
  template:
    property1: "value1"
    property2: "${.baseProperty1.baseProperty2}"
 ```

Пример преобразования тела ответа, где в ответ пользователю приходит сообщение из двух полей, если функция Cloud Functions возвращает код 200 и заголовок `Content-Type: application/json`:

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

## Примеры использования {#examples}

* [Использование Yandex API Gateway для настройки синтеза речи в Yandex SpeechKit](../../tutorials/speechkit-integrarion-via-agi-gw.md)