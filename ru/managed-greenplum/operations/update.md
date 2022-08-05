# Изменение настроек кластера

После создания кластера вы можете:

* [{#T}](#change-name-and-description).

* [{#T}](#change-additional-settings).

* [Настроить серверы {{ GP }} согласно документации {{ GP }}](#change-gp-settings).

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
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `name`, `description`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mgp-name }}**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. Измените дополнительные настройки кластера:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **Окно обслуживания** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [DataTransfer access](../../_includes/mdb/console/datatransfer-access.md) %}
        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Нажмите кнопку **Сохранить**.

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Настройки публичного доступа в параметре `assignPublicIp`.
    * Настройки окна резервного копирования в параметре `config.backupWindowStart`.
    * Настройки доступа из [{{ datalens-full-name }}](../../datalens/concepts/index.md) в параметре `config.access.dataLens`.
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки {{ GP }} {#change-gp-settings}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mgp-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените [настройки {{ GP }}](../concepts/settings-list.md), нажав кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить изменения**.

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Новые значения в параметре `configSpec.greenplumConfig_<версия>`.
    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

        {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
