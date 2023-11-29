---
title: "Изменение настроек кластера {{ OS }}"
description: "После создания кластера {{ OS }} вы можете изменить его сервисные настройки."
keywords:
  - настройки OpenSearch
  - настройки кластера OpenSearch
  - OpenSearch
---

# Изменение настроек кластера {{ OS }}

После создания кластера вы можете изменить его сервисные настройки. Также вы можете изменить [конфигурацию групп хостов](host-groups.md#update-host-group), [версию {{ OS }}](cluster-version-update.md) и [зону доступности для групп хостов](host-migration.md).

## Изменить сервисные настройки {#change-service-settings}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите кластер и нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

        1. Измените пароль пользователя `admin`.
        1. При необходимости измените дополнительные настройки кластера:

            {% include [Сервисные настройки](../../_includes/mdb/mos/extra-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- API

    Воспользуйтесь методом [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новый пароль пользователя `admin` в параметре `configSpec.adminPassword`.
    * Список плагинов в параметре `configSpec.opensearchSpec.plugins`. Плагины, не указанные в списке, будут выключены.
    * Настройки доступа из других сервисов в параметре `configSpec.access`.
    
    
    * Идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), используемого для работы с кластером, в параметре `serviceAccountId`.


    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
