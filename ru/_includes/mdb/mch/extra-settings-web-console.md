* **{{ ui-key.yacloud.mdb.forms.backup-window-start }}** — время по UTC в 24-часовом формате, в которое начинается резервное копирование кластера. Если время не задано, резервное копирование начинается в 22:00 UTC.

* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../../managed-clickhouse/concepts/maintenance.md):

   {% include [Maintenance window](../console/maintenance-window-description.md) %}

* **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** — опция разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../../datalens/concepts/index.md).

* {% include [datatransfer access](../console/datatransfer-access.md) %}



* **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** — опция разрешает выполнять SQL-запросы к базам кластера из консоли управления {{ yandex-cloud }}.

* **{{ ui-key.yacloud.mdb.forms.additional-field-metrika }}** — опция разрешает [импортировать данные из AppMetrica](https://appmetrica.yandex.ru/docs/common/cloud/about.html) в кластер.

* **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../../functions/concepts/index.md). Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../../functions/operations/database-connection.md).

* **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ yq-full-name }}](../../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).



* {% include [Deletion protection](../console/deletion-protection.md) %}

   {% include [Ограничения защиты от удаления](../deletion-protection-limits-db.md) %}
