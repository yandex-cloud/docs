**{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}** — выберите один из доступных форматов:
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}` — формат JSON. Для оптимизации пропускной способности поддерживается обработка сообщений JSON, записанных одной строкой — без символов перевода строки `\n`. Пример: `{"attr": "value"}`
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_audit_trails_v1.title }}` — формат логов сервиса [{{ at-name }}](../../../../../audit-trails/).
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_cloud_logging.title }}` — формат логов сервиса [{{ cloud-logging-short-name }}](../../../../../logging/).
       * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_debezium_cdc.title }}` — Debezium CDC. Позволяет указать настройки подключения к Schema Registry: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.title }}` для [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html), идентификатор [пространства имен](../../../../../metadata-hub/operations/list-name-space.md) для `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.yandex_sr.title }}`. 
        
          Для формата **JSON** укажите: 

           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** — задайте схему в виде списка полей или загрузите файл с описанием схемы в формате JSON.
            
           {% include notitle [json-schema-sample](../../common/ui/json-schema-sample.md) %}
    
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.GenericParser.null_keys_allowed.title }}** — выберите эту опцию, чтобы разрешить значение `null` в ключевых колонках.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.add_rest_column.title }}** — выберите эту опцию, чтобы поля, отсутствующие в схеме, попадали в колонку `_rest`.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.parsers.GenericParserCommon.unescape_string_values.title }}** — выберите эту опцию, чтобы убрать кавычки из строковых переменных (если этого не сделать, значения строковых полей останутся без изменений).
           
         Для **Debezium CDC** укажите: 
           * Для `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.title }}` — URL для Schema Registry, способ аутентификации (с указанием логина и пароля пользователя в случае использования аутентификации) и CA-сертификат.
           * Для `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.yandex_sr.title }}` — идентификатор [пространства имен](../../../../../metadata-hub/operations/list-name-space.md) реестра схем.