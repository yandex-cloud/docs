* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../../managed-kafka/concepts/maintenance.md):

    {% include [Maintenance window](../console/maintenance-window-description.md) %}


* {% include [Deletion protection](../console/deletion-protection.md) %}

    Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.


* **{{ ui-key.yacloud.mdb.forms.label_disk-encryption }}** — включите настройку, чтобы зашифровать диски [пользовательским ключом KMS](../../../kms/concepts/key.md).

   * Чтобы [создать](../../../kms/operations/key.md#create) новый ключ, нажмите кнопку **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

   * Чтобы использовать созданный ранее ключ, выберите его в поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}**.

   Подробнее о шифровании дисков см. в разделе [Хранилище](../../../managed-kafka/concepts/storage.md#disk-encryption).

   {% note warning %}
   
   Включить шифрование дисков можно только при создании кластера.
   
   {% endnote %}


* **{{ ui-key.yacloud.kafka.field_schema-registry }}** — включите настройку, чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../../../managed-kafka/concepts/managed-schema-registry.md).

    {% include [mkf-schema-registry-alert](schema-registry-alert.md) %}

* **{{ ui-key.yacloud.kafka.field_rest-api-config }}** — включите настройку, чтобы разрешить отправку запросов к API {{ KF }}.

    В качестве реализации используется приложение с открытым исходным кодом [Karapace](https://github.com/Aiven-Open/karapace). API Karapace совместимо с [API Confluent REST Proxy](https://docs.confluent.io/platform/current/kafka-rest/api.html) за исключением небольших расхождений.

    {% note warning %}

    Настройку **{{ ui-key.yacloud.kafka.field_rest-api-config }}** невозможно отключить после ее включения.

    {% endnote %}


* **{{ ui-key.yacloud.kafka.field_kafka-ui }}** — включите настройку, чтобы использовать [веб-интерфейс {{ KF }}](../../../managed-kafka/concepts/kafka-ui.md).

