# Изменение настроек кластера

После создания кластера вы можете:

* [{#T}](#change-name-and-description).

* [{#T}](#change-additional-settings).

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Выберите кластер и нажмите кнопку **Редактировать** в верхней части страницы.
    1. В блоке **Базовые параметры** задайте новые имя и описание кластера.
    1. Нажмите кнопку **Сохранить**.

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новое имя в параметре `name`.
    * Новое описание в параметре `description`.
    * Список полей конфигурации кластера, подлежащих изменению (в данном случае — `name`, `description`) в параметре `updateMask`.

        {% include [note-api-updatemask](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [Дополнительные настройки кластера](../../_includes/mdb/mgp/extra-settings.md) %}

  1. Нажмите кнопку **Сохранить**.

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Настройки публичного доступа в параметре `assignPublicIp`.
    * Настройки окна резервного копирования в параметре `config.backupWindowStart`.
    * Настройки доступа из [{{ datalens-full-name }}](../../datalens/concepts/index.md) в параметре `config.access.dataLens`.
    * {% include [Maintenance window](../../_includes/mdb/api/maintenance-window.md) %}
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

        {% include [note-api-updatemask](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
