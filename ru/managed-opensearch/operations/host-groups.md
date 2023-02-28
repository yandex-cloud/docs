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

* [{#T}](#list-groups).
* [{#T}](#add-host-group).
* [{#T}](#update-host-group).
* [{#T}](#delete-host-group).

## Получить список групп хостов в кластере {#list-groups}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mos-name }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/mdb/host-groups.svg) **Группы хостов**.

- API

  Воспользуйтесь методом API [get](../api-ref/Cluster/get.md) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](#list-clusters).

{% endlist %}

## Добавить группу хостов в кластер {#add-host-group}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mos-name }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/mdb/host-groups.svg) **Группы хостов**.
    1. Нажмите кнопку ![image](../../_assets/plus-sign.svg) **Добавить группу хостов**.
    1. Укажите параметры группы:

        * [Тип группы](../concepts/host-groups.md): `{{ OS }}` и `Dashboards`.
        * Имя. Оно должно быть уникальным в кластере.
        * Для группы хостов `{{ OS }}` выберите [роль хостов](../concepts/host-roles.md).
        * Платформу, тип и класс хостов.

            Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты ноды {{ OS }}. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

        * [Тип диска](../concepts/storage.md) и объем хранилища, который будет использоваться для данных.

            {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

        * Расположение хостов по зонам доступности и подсетям.

        * Количество создаваемых хостов.

        
        * Включите опцию **Публичный доступ**, если вы хотите, чтобы к хостам можно было [подключаться](connect.md) через интернет.


    1. Нажмите кнопку **Создать группу хостов**.

    {% note warning %}

    После добавления группы хостов опцию **Публичный доступ** изменить нельзя. Остальные параметры можно [изменить](#update-host-group) только с помощью [API](../../glossary/rest-api.md), однако при необходимости вы сможете создать новую группу хостов с другой конфигурацией.

    {% endnote %}

- API

    Чтобы добавить группу хостов типа `{{ OS }}` или `Dashboards`, воспользуйтесь методом API [addOpenSearchNodeGroup](../api-ref/Cluster/addOpenSearchNodeGroup.md) или [addDashboardsNodeGroup](../api-ref/Cluster/addDashboardsNodeGroup.md), соответственно, и передайте в запросе конфигурацию группы в блоке `nodeGroupSpec`:

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

{% list tabs %}

- API

    Чтобы изменить конфигурацию группы хостов типа `{{ OS }}` или `Dashboards`, воспользуйтесь методом API [updateOpenSearchNodeGroup](../api-ref/Cluster/updateOpenSearchNodeGroup.md) или [updateDashboardsNodeGroup](../api-ref/Cluster/updateDashboardsNodeGroup.md), соответственно, и передайте в запросе новую конфигурацию в блоке `nodeGroupSpec`:

    * [Класс хостов](../concepts/instance-types.md) в параметре `resources.resourcePresetId`.
    * [Тип диска](../concepts/storage.md) в параметре `resources.diskTypeId`.
    * Объем хранилища, который используется для данных, в параметре `resources.diskSize`.
    * Количество хостов в группе в параметре `hostsCount`.
    * Список ролей хостов в параметре `roles` (только для группы хостов типа `{{ OS }}`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Удалить группу хостов {#delete-host-group}

При удалении группы хостов действует ограничение: нельзя удалить единственную группу хостов с ролью `DATA`.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mos-name }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/mdb/host-groups.svg) **Группы хостов**.
    1. Нажмите на значок ![image](../../_assets/options.svg) в строке нужной группы и выберите пункт **Удалить**.

- API

    Чтобы удалить группу хостов типа `{{ OS }}` или `Dashboards`, воспользуйтесь методом API [deleteOpenSearchNodeGroup](../api-ref/Cluster/deleteOpenSearchNodeGroup.md) или [deleteDashboardsNodeGroup](../api-ref/Cluster/deleteDashboardsNodeGroup.md), соответственно, и передайте в запросе:

    * Идентификатор кластера в параметре `clusterID`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя группы хостов, которую вы хотите удалить из кластера, в параметре `name`.

{% endlist %}
