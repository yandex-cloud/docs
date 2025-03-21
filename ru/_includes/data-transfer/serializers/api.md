Укажите в блоке `serializer` выбранный тип [сериализации](../../../data-transfer/concepts/serializer.md):

* `serializerAuto`.
* `serializerJson`.
* `serializerDebezium`.

    Для этого типа можно указать параметры [сериализации Debezium](../../../data-transfer/concepts/serializer.md#debezium), задав их в поле `serializerDebezium.serializerParameters` в виде пар `key`/`value`.

Если вы хотите использовать JSON-схемы в {{ schema-registry-full-name }}, сохраняя совместимость схем при добавлении и удалении опциональных полей, добавьте в тело запроса объект `serializer` с описанием настроек сериализации. Чтобы генерировать закрытую схему для ключей, добавьте в объект `serializer` переменную `key.converter.dt.json.generate.closed.content.schema` со значением `true`. Чтобы генерировать закрытую схему для значений, добавьте в объект `serializer` переменную `value.converter.dt.json.generate.closed.content.schema` со значением `true`.

```json
"serializer": {
  "serializerDebezium": {
    "serializerParameters": [
      {
        "key": "converter.dt.json.generate.closed.content.schema",
        "value": "true"
      },
      {
        "key": "value.converter",
        "value": "io.confluent.connect.json.JsonSchemaConverter"
      },
      {
        "key": "value.converter.schemas.enable",
        "value": "true"
      },
      {
        "key": "value.converter.schema.registry.url",
        "value": "<URL_пространства_имен_Schema_Registry>"
      },
      {
        "key": "value.converter.basic.auth.user.info",
        "value": "api-key:<значение_API-ключа>"
      }
    ]
  }
}
```

Где:

* `URL_пространства_имен_Schema_Registry` — эндпоинт пространства имен {{ schema-registry-name }}. Вы можете скопировать эндпоинт из подсказки по подключению к пространству имен {{ schema-registry-name }} на вкладке **Debezium**, в параметре `value.converter.schema.registry.url`.
* `значение_API-ключа` — значение [API-ключа](../../../iam/concepts/authorization/api-key.md) с ограниченной областью действия для подключения к {{ schema-registry-name }}. Чтобы получить значение:
    1. Создайте API-ключ с ограниченной областью действия и поместите его в локальную переменную `SECRET`:

        ```bash
        yc iam api-key create --folder-id <идентификатор_каталога> \
          --service-account-name <имя_сервисного_аккаунта_для_работы_со_Schema_Registry> \
          --scope yc.schema-registry.schemas.manage \
          --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
        SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
        ```

    1. Выведите в терминал значение переменной `SECRET`:

        ```bash
        echo $SECRET
        ```

    1. Скопируйте полученное значение и вставьте его в параметр `value` в конфигурационном файле.
