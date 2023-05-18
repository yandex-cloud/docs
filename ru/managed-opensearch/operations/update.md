---
title: "Изменение настроек кластера {{ OS }}"
description: "После создания кластера {{ OS }} вы можете изменить его сервисные настройки."
keywords:
  - настройки OpenSearch
  - настройки кластера OpenSearch
  - OpenSearch
---

# Изменение настроек кластера {{ OS }}

После создания кластера вы можете изменить его сервисные настройки. Чтобы изменить конфигурацию отдельных групп хостов, воспользуйтесь инструкцией в разделе [Управление группами хостов](host-groups.md#update-host-group).

## Изменить сервисные настройки {#change-service-settings}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mos-name }}**.
    1. Выберите кластер и нажмите кнопку ![pencil](../../_assets/pencil.svg) **Изменить кластер** на панели сверху.
    1. В блоке **Сервисные настройки**:

        1. Измените пароль пользователя `admin`.
        1. При необходимости измените дополнительные настройки кластера:

            {% include [Сервисные настройки](../../_includes/mdb/mos/extra-settings.md) %}

    1. Нажмите кнопку **Сохранить**.

- API

    Чтобы изменить сервисные настройки, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

    * Новый пароль пользователя `admin` в параметре `configSpec.adminPassword`.
    * Список плагинов в параметре `configSpec.opensearchSpec.plugins`. Плагины, не указанные в списке, будут выключены.
    * Настройки доступа из других сервисов в параметре `configSpec.access`.
    
    
    * Идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), используемого для работы с кластером, в параметре `serviceAccountId`.


    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
