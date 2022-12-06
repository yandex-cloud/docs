---
title: "Управление группами хостов {{ OS }}"
description: "Вы можете получать список хостов в кластере {{ OS }}, а также добавлять, редактировать и удалять группы хостов кластера."
keywords:
  - управление группами хостов OpenSearch
  - группы хостов OpenSearch
  - OpenSearch
---

# Управление группами хостов {{ OS }}

В кластере {{ OS }} нет возможности добавлять, изменять и удалять индивидуальные хосты — вместо этого вы можете управлять [группами хостов](../concepts/host-groups.md):

* [{#T}](#list-hosts).
* [{#T}](#add-host-group).
* [{#T}](#update-host-group).
* [{#T}](#delete-host-group).

## Получить список хостов в кластере {#list-hosts}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mos-name }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.

- API

    Воспользуйтесь методом API [listHosts](../api-ref/Cluster/listHosts.md) и передайте в запросе идентификатор нужного кластера в параметре `clusterId`.

    Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Добавить группу хостов в кластер {#add-host-group}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mos-name }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **Группы хостов**.
    1. Нажмите кнопку **Добавить группу хостов**.
    1. Укажите параметры группы:

        * Имя.
        * [Тип](../concepts/host-groups.md) и одну или несколько [ролей](../concepts/hosts-roles.md), которые будут выполнять хосты в группе.
        * Платформу, тип и класс хостов.

            Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты ноды {{ OS }}. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

        * [Тип диска](../concepts/storage.md) и объем хранилища, который будет использоваться для данных.

            {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

        * Расположение хостов по зонам доступности и подсетям.

        * Количество создаваемых хостов.

        * Включите опцию **Публичный доступ**, если вы хотите, чтобы к хостам можно было [подключаться](connect.md) через интернет.

    1. Нажмите кнопку **Создать группу хостов**.

    {% note warning %}

    [Изменить конфигурацию](#update-host-group) группы хостов после создания можно только с помощью API, однако при необходимости вы сможете создать новую группу хостов с другой конфигурацией.

    {% endnote %}

- API

    Чтобы добавить группу хостов типа `OPENSEARCH` или `DASHBOARDS`, воспользуйтесь методом API [addOpenSearchNodeGroup](../api-ref/Cluster/addOpenSearchNodeGroup.md) или [addDashboardsNodeGroup](../api-ref/Cluster/addDashboardsNodeGroup.md), соответственно, и передайте в запросе конфигурацию группы в блоке `nodeGroupSpec`:

    * Имя группы хостов в параметре `name`.
    * [Класс хостов](../concepts/instance-types.md) в параметре `resources.resourcePresetId`.
    * [Тип диска](../concepts/storage.md) в параметре `resources.diskTypeId`.
    * Объем хранилища, который будет использоваться для данных, в параметре `resources.diskSize`.
    * Количество хостов в группе в параметре `hostsCount`.
    * Список зон доступности в параметре `zoneIds`.
    * Список подсетей в параметре `subnetIds`.
    * Настройки публичного доступа в параметре `assignPublicIp`.
    * Список ролей хостов в параметре `roles` (только для группы хостов типа `OPENSEARCH`).

{% endlist %}

## Изменить конфигурацию группы хостов {#update-host-group}

{% list tabs %}

- API

    Чтобы изменить конфигурацию группы хостов типа `OPENSEARCH` или `DASHBOARDS`, воспользуйтесь методом API [updateOpenSearchNodeGroup](../api-ref/Cluster/updateOpenSearchNodeGroup.md) или [updateDashboardsNodeGroup](../api-ref/Cluster/updateDashboardsNodeGroup.md), соответственно, и передайте в запросе новую конфигурацию в блоке `nodeGroupSpec`:

    * [Класс хостов](../concepts/instance-types.md) в параметре `resources.resourcePresetId`.
    * [Тип диска](../concepts/storage.md) в параметре `resources.diskTypeId`.
    * Объем хранилища, который используется для данных, в параметре `resources.diskSize`.
    * Количество хостов в группе в параметре `hostsCount`.
    * Список ролей хостов в параметре `roles` (только для группы хостов типа `OPENSEARCH`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Удалить группу хостов {#delete-host-group}

При удалении группы хостов действует ограничение: нельзя удалить единственную группу хостов с ролью `DATA`.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mos-name }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **Группы хостов**.
    1. Нажмите на значок ![image](../../_assets/options.svg) в строке нужной группы и выберите пункт **Удалить**.

- API

    Чтобы удалить группу хостов типа `OPENSEARCH` или `DASHBOARDS`, воспользуйтесь методом API [deleteOpenSearchNodeGroup](../api-ref/Cluster/deleteOpenSearchNodeGroup.md) или [deleteDashboardsNodeGroup](../api-ref/Cluster/deleteDashboardsNodeGroup.md), соответственно, и передайте в запросе:

    * Идентификатор кластера в параметре `clusterID`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя группы хостов, которую вы хотите удалить из кластера, в параметре `name`.

{% endlist %}
