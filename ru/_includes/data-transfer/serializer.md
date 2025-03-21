* В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** выберите тип [сериализации](../../data-transfer/concepts/serializer.md):

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}** — автоматическая сериализация.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}** — сериализация по стандартам Debezium:

      * Выберите схему ключа сообщения (соответствует Debezium-параметру `key.converter`).
      * Выберите схему значения сообщения (соответствует Debezium-параметру `value.converter`).
      * При необходимости задайте [**{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**](../../data-transfer/concepts/serializer.md#debezium) в формате `Параметр`-`Значение`.

Если вы хотите использовать JSON-схемы в {{ schema-registry-full-name }}, сохраняя совместимость схем при добавлении и удалении опциональных полей, укажите следующие настройки:

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}**.
* Чтобы использовать {{ schema-registry-name }} для ключей, выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.key_converter_settings.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. Чтобы использовать {{ schema-registry-name }} для значений, выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.value_converter_settings.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}** — эндпоинт пространства имен {{ schema-registry-name }}. Вы можете скопировать эндпоинт из подсказки по подключению к пространству имен {{ schema-registry-name }} на вкладке **Debezium**, в параметре `value.converter.schema.registry.url`.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}** — `api-key`.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}** — значение [API-ключа](../../iam/concepts/authorization/api-key.md) с ограниченной областью действия для подключения к {{ schema-registry-name }}. Чтобы получить значение:
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

      1. Скопируйте полученное значение и вставьте его в поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}** в окне создания эндпоинта.

* В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**:
    * Чтобы генерировать закрытую схему для ключей, добавьте параметр `key.converter.dt.json.generate.closed.content.schema` со значением `true`.
    * Чтобы генерировать закрытую схему для значений, добавьте параметр `value.converter.dt.json.generate.closed.content.schema` со значением `true`.
