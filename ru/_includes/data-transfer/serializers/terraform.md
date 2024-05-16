Укажите в блоке `serializer` выбранный тип [сериализации](../../../data-transfer/concepts/serializer.md):

* `serializer_auto`.
* `serializer_json`.
* `serializer_debezium`.

    Для этого типа можно указать параметры [сериализации Debezium](../../../data-transfer/concepts/serializer.md#debezium), задав их в блоке `serializer_debezium.serializer_parameters` в виде пар `key`/`value`.
