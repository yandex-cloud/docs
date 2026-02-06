* В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** выберите тип [сериализации](../../data-transfer/concepts/serializer.md):

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}** — автоматическая сериализация.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}** — сериализация по стандартам Debezium:
  
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_yandex_schema_registry_debezium.title }}**:

      * Выберите схему сообщения (формат данных).
      * Выберите из списка [пространство имен](../../metadata-hub/operations/list-name-space.md) реестра схем {{ schema-registry-full-name }}.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_on_premise_debezium.title }}**:

      * Выберите схему ключа сообщения (соответствует Debezium-параметру `key.converter`). Значение по умолчанию соответствует Debezium-параметрам `key.converter.schemas.enable=true` и  `key.converter=org.apache.kafka.connect.json.JsonConverter`. При выборе значения **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.disabled.title }}** Debezium-параметр `key.converter.schemas.enable` принимает значение `false`.
      * Выберите схему значения сообщения (соответствует Debezium-параметру `value.converter`). Значение по умолчанию соответствует Debezium-параметрам `value.converter.schemas.enable=true` и  `value.converter=org.apache.kafka.connect.json.JsonConverter`. При выборе значения **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.disabled.title }}** Debezium-параметр `value.converter.schemas.enable` принимает значение `false`.
      * При выборе значений **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.avro.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.protobuf.title }}** для схем ключа и значения сообщения укажите параметры доступа к внешнему сервису Confluent Schema Registry:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}** — URL сервиса.
        * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}**.
        * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}**.
        * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.ca_cert.title }}** — загрузите SSL-сертификат для подключения. Чтобы пропустить проверку сертификата, не задавайте его.

    * При необходимости задайте [**{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**](../../data-transfer/concepts/serializer.md#debezium) в формате `Параметр`-`Значение`.

Если вы хотите использовать JSON-схемы в {{ schema-registry-full-name }}, сохраняя [совместимость схем при добавлении и удалении опциональных полей](../../metadata-hub/concepts/schema-registry-content-model.md#optional-parameters-compatibility-solution), укажите следующие настройки:

**{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_on_premise_debezium.title }}**

* Чтобы использовать {{ schema-registry-name }} для ключей, выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.key_converter_settings.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. Чтобы использовать {{ schema-registry-name }} для значений, выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.value_converter_settings.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. Укажите параметры доступа к Schema Registry:
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}** — `https://<идентификатор_пространства_имен>.{{ schema-registry-endpoint }}`.

      {% note warning %}

      В пространстве имен должна быть [выставлена](../../metadata-hub/operations/update-name-space.md) **Политика проверок совместимости для JSON** — `optional friendly`.

      {% endnote %}

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}** — `api-key`.

  
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}** — значение [API-ключа](../../iam/concepts/authorization/api-key.md) с ограниченной областью действия для подключения к {{ schema-registry-name }}. Чтобы получить значение:
      1. Создайте API-ключ с ограниченной областью действия и поместите его в локальную переменную `SECRET`:

          ```bash
          yc iam api-key create --folder-id <идентификатор_каталога> \
            --service-account-name <имя_сервисного_аккаунта_для_работы_со_Schema_Registry> \
            --scopes yc.schema-registry.schemas.manage \
            --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
          SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
          ```

      1. Выведите в терминал значение переменной `SECRET`:

          ```bash
          echo $SECRET
          ```


* В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**:
    * Чтобы генерировать закрытую схему для ключей, добавьте параметр `key.converter.dt.json.generate.closed.content.schema` со значением `true`.
    * Чтобы генерировать закрытую схему для значений, добавьте параметр `value.converter.dt.json.generate.closed.content.schema` со значением `true`.
