---
title: "Управление группами хостов {{ OS }} в {{ mos-full-name }}"
description: "Вы можете получать список хостов в кластере {{ OS }}, а также добавлять, редактировать и удалять группы хостов кластера."
keywords:
  - управление группами хостов OpenSearch
  - группы хостов OpenSearch
  - OpenSearch
---

# Управление группами хостов {{ OS }}

В кластере {{ mos-name }} нет возможности добавлять, изменять и удалять индивидуальные хосты — вместо этого вы можете управлять [группами хостов](../concepts/host-groups.md):

* [{#T}](#list-groups).
* [{#T}](#add-host-group).
* [{#T}](#update-host-group).
* [{#T}](#delete-host-group).

Также вы можете [получить список хостов в кластере](#list-hosts).

О миграции групп хостов в кластере {{ mos-name }} в другую зону доступности читайте в [инструкции](host-migration.md).

## Получить список групп хостов в кластере {#list-groups}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.

- API {#api}

  Чтобы получить список групп хостов в кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Добавить группу хостов в кластер {#add-host-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_add-node-group }}**.
    1. Укажите параметры группы:

        * [Тип группы](../concepts/host-groups.md): `{{ OS }}` или `Dashboards`.
        * Имя. Оно должно быть уникальным в кластере.
        * Для группы хостов `{{ OS }}` выберите [роль хостов](../concepts/host-roles.md).
        * Платформу, тип и класс хостов.

            Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты ноды {{ OS }}. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

        * [Тип диска](../concepts/storage.md) и объем хранилища, который будет использоваться для данных.

            {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

        * Расположение хостов по зонам доступности и подсетям.

        * Количество создаваемых хостов.

        
        * Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если вы хотите, чтобы к хостам можно было [подключаться](connect.md) через интернет.


    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_create-node-group }}**.

    {% note warning %}

    После добавления группы хостов опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** изменить нельзя. Остальные параметры можно [изменить](#update-host-group) только с помощью [API](../../glossary/rest-api.md), однако при необходимости вы сможете создать новую группу хостов с другой конфигурацией.

    {% endnote %}

- API {#api}

    Чтобы добавить группу хостов типа `{{ OS }}`, воспользуйтесь методом REST API [addOpenSearchNodeGroup](../api-ref/Cluster/addOpenSearchNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddOpenSearchNodeGroup](../api-ref/grpc/cluster_service.md#AddOpenSearchNodeGroup).

    Чтобы добавить группу хостов типа `Dashboards`, воспользуйтесь методом REST API [addDashboardsNodeGroup](../api-ref/Cluster/addDashboardsNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddDashboardsNodeGroup](../api-ref/grpc/cluster_service.md#AddDashboardsNodeGroup).

    Передайте в запросе конфигурацию группы в блоке `nodeGroupSpec`:

    * Имя группы хостов в параметре `name`.
    * [Класс хостов](../concepts/instance-types.md) в параметре `resources.resourcePresetId`.
    * [Тип диска](../concepts/storage.md) в параметре `resources.diskTypeId`.
    * Объем хранилища, который будет использоваться для данных, в параметре `resources.diskSize`.
    * Количество хостов в группе в параметре `hostsCount`.
    * Список зон доступности в параметре `zoneIds`.
    * Список подсетей в параметре `subnetIds`.

    
    * Настройки публичного доступа в параметре `assignPublicIp`.


    * Список ролей хостов в параметре `roles` (только для группы хостов типа `{{ OS }}`).

{% endlist %}

## Изменить конфигурацию группы хостов {#update-host-group}

{% list tabs group=instructions %}

- API {#api}

    Чтобы изменить конфигурацию группы хостов типа `{{ OS }}`, воспользуйтесь методом REST API [updateOpenSearchNodeGroup](../api-ref/Cluster/updateOpenSearchNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/UpdateOpenSearchNodeGroup](../api-ref/grpc/cluster_service.md#UpdateOpenSearchNodeGroup).

    Чтобы изменить конфигурацию группы хостов типа `Dashboards`, воспользуйтесь методом REST API [updateDashboardsNodeGroup](../api-ref/Cluster/updateDashboardsNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/UpdateDashboardsNodeGroup](../api-ref/grpc/cluster_service.md#UpdateDashboardsNodeGroup).

    Передайте в запросе новую конфигурацию в блоке `nodeGroupSpec`:

    * [Класс хостов](../concepts/instance-types.md) в параметре `resources.resourcePresetId`.
    * [Тип диска](../concepts/storage.md) в параметре `resources.diskTypeId`.
    * Объем хранилища, который используется для данных, в параметре `resources.diskSize`.
    * Количество хостов в группе в параметре `hostsCount`.
    * Список ролей хостов в параметре `roles` (только для группы хостов типа `{{ OS }}`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Удалить группу хостов {#delete-host-group}

При удалении группы хостов действует ограничение: нельзя удалить единственную группу хостов с ролью `DATA`.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной группы и выберите пункт **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_delete }}**.

- API {#api}

    Чтобы удалить группу хостов типа `{{ OS }}`, воспользуйтесь методом REST API [deleteOpenSearchNodeGroup](../api-ref/Cluster/deleteOpenSearchNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteOpenSearchNodeGroup](../api-ref/grpc/cluster_service.md#DeleteOpenSearchNodeGroup).

    Чтобы удалить группу хостов типа `Dashboards`, воспользуйтесь методом REST API [deleteDashboardsNodeGroup](../api-ref/Cluster/deleteDashboardsNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteDashboardsNodeGroup](../api-ref/grpc/cluster_service.md#DeleteDashboardsNodeGroup).

    Передайте в запросе:

    * Идентификатор кластера в параметре `clusterID`.

      {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

    * Имя группы хостов, которую вы хотите удалить из кластера, в параметре `name`.

{% endlist %}

## Получить список хостов в кластере {#list-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку ![hosts](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.

- API {#api}

  Чтобы получить список хостов в кластере, воспользуйтесь методом REST API [listHosts](../api-ref/Cluster/listHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md).

{% endlist %}
