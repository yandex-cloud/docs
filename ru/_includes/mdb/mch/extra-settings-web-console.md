* **Начало резервного копирования (UTC)** — время по UTC в 24-часовом формате, в которое начинается резервное копирование кластера. Если время не задано, резервное копирование начинается в 22:00 UTC.

* **Окно обслуживания** — настройки времени [технического обслуживания](../../../managed-clickhouse/concepts/maintenance.md):

   {% include [Maintenance window](../console/maintenance-window-description.md) %}

* **Гибридное хранилище** — включите эту опцию, чтобы кластер использовал [гибридное хранилище](../../../managed-clickhouse/concepts/storage.md#hybrid-storage-features). Тип диска и его размер укажите в блоке **Размер хранилища**.

   {% note alert %}

   Эту опцию невозможно выключить.

   {% endnote %}

{% if product == "yandex-cloud" %}
* **Доступ из {{ datalens-name }}** — опция разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../../datalens/concepts/index.md).
{% endif %}

* **Доступ из консоли управления** — опция разрешает выполнять SQL-запросы к базам кластера из консоли управления {{ yandex-cloud }}.

* {% include [datatransfer access](../console/datatransfer-access.md) %}

* **Доступ из Метрики и AppMetrica** — опция разрешает [импортировать данные из AppMetrica](https://appmetrica.yandex.ru/docs/common/cloud/about.html) в кластер.

{% if product == "yandex-cloud" %}
{% if audience != "internal" %}

* **Доступ из Serverless** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../../functions/concepts/index.md). Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../../functions/operations/database-connection.md).

{% else %}

* **Доступ из Serverless** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса {{ sf-full-name }}.

{% endif %}
{% endif %}
* {% include [Deletion protection](../console/deletion-protection.md) %}

    {% include [Ограничения защиты от удаления](../deletion-protection-limits-db.md) %}
