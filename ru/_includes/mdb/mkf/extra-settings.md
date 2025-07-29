* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../../managed-kafka/concepts/maintenance.md):

    {% include [Maintenance window](../console/maintenance-window-description.md) %}


* {% include [Deletion protection](../console/deletion-protection.md) %}

    Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

* Чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../../../managed-kafka/concepts/managed-schema-registry.md), включите настройку **{{ ui-key.yacloud.kafka.field_schema-registry }}**.

    {% include [mkf-schema-registry-alert](schema-registry-alert.md) %}

* Чтобы разрешить отправку запросов к API {{ KF }}, включите настройку **{{ ui-key.yacloud.kafka.field_rest-api-config }}**.

    В качестве реализации используется приложение с открытым исходным кодом [Karapace](https://github.com/Aiven-Open/karapace). API Karapace совместимо с [API Confluent REST Proxy](https://docs.confluent.io/platform/current/kafka-rest/api.html) за исключением небольших расхождений.

    {% note warning %}

    Настройку **{{ ui-key.yacloud.kafka.field_rest-api-config }}** невозможно отключить после ее включения.

    {% endnote %}

* Чтобы использовать [веб-интерфейс {{ KF }}](../../../managed-kafka/concepts/kafka-ui.md), включите настройку **{{ ui-key.yacloud.kafka.field_kafka-ui }}**.

