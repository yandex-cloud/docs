---
title: "Управление группами хостов {{ OS }} в {{ mos-full-name }}"
description: "Вы можете получать список хостов в кластере {{ OS }}, а также добавлять, редактировать и удалять группы хостов кластера."
keywords:
  - управление группами хостов OpenSearch
  - группы хостов OpenSearch
  - OpenSearch
---

# Управление группами хостов {{ OS }}


В кластере {{ mos-name }} вы можете управлять [группами хостов](../concepts/host-roles.md):

* [{#T}](#list-groups).
* [{#T}](#add-host-group).
* [{#T}](#update-host-group), в том числе добавить в нее новые хосты или удалить их.
* [{#T}](#delete-host-group).

Также вы можете [получить список хостов в кластере](#list-hosts).

О миграции групп хостов в кластере {{ mos-name }} в другую [зону доступности](../../overview/concepts/geo-scope.md) читайте в [инструкции](host-migration.md).

## Получить список групп хостов в кластере {#list-groups}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список групп хостов в кластере, запросите информацию о кластере {{ OS }}:

    ```bash
    {{ yc-mdb-os }} cluster get <имя_или_идентификатор_кластера>
    ```

    Список групп хостов указан в параметрах `config.opensearch.node_groups` и `config.dashboards.node_groups`.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

  Чтобы получить список групп хостов в кластере, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Создать группу хостов {#add-host-group}

При создании групп хостов действуют ограничения:

* В кластере {{ mos-name }} может быть только одна группа хостов `Dashboards`.
* Если вы добавляете группу хостов `{{ OS }}` и назначаете хостам роль `MANAGER`, минимальное количество хостов с такой ролью — три.

Чтобы создать группу хостов:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_add-node-group }}**.
    1. Укажите параметры группы:

        * [Тип группы](../concepts/host-roles.md): `{{ OS }}` или `Dashboards`.
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

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать группу хостов, выполните команду:

    ```bash
    {{ yc-mdb-os }} node-group add --cluster-name <имя_кластера> \
       --opensearch-node-group name=<имя_группы_хостов_{{ OS }}>,`
                              `resource-preset-id=<класс_хостов>,`
                              `disk-size=<размер_диска_в_байтах>,`
                              `disk-type-id=<тип_диска>,`
                              `hosts-count=<количество_хостов_в_группе>,`
                              `zone-ids=<зоны_доступности>,`
                              `subnet-names=<имена_подсетей>,`
                              `assign-public-ip=<назначить_публичный_адрес:_true_или_false>,`
                              `roles=<роли_хостов> \
       --dashboards-node-group name=<имя_группы_хостов_Dashboards>,`
                              `resource-preset-id=<класс_хостов>,`
                              `disk-size=<размер_диска_в_байтах>,`
                              `disk-type-id=<тип_диска>,`
                              `hosts-count=<количество_хостов_в_группе>,`
                              `zone-ids=<зоны_доступности>,`
                              `subnet-names=<имена_подсетей>,`
                              `assign-public-ip=<назначить_публичный_адрес:_true_или_false>
    ```

    В команде укажите нужные параметры в зависимости от того, какую группу хостов вы хотите создать:

    {% include [cli-for-os-and-dashboards-groups](../../_includes/managed-opensearch/cli-for-os-and-dashboards-groups.md) %}

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

    1. Чтобы создать группу хостов `{{ OS }}`, добавьте блок `node_groups` в блок `opensearch`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
          ...
          config {
            opensearch {
              ...
              node_groups {
                name             = "<имя_группы_виртуальных_хостов>"
                assign_public_ip = <публичный_доступ>
                hosts_count      = <количество_хостов>
                zone_ids         = ["<список_зон_доступности>"]
                subnet_ids       = ["<список_идентификаторов подсетей>"]
                roles            = ["<список_ролей>"]
                resources {
                  resource_preset_id = "<класс_хоста>"
                  disk_size          = <размер_хранилища_в_байтах>
                  disk_type_id       = "<тип_диска>"
                }
              }
            }
            ...
          }
        }
        ```

        Где:

        * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.
        * `roles` — роли хостов: `DATA` и `MANAGER`.

    1. Чтобы создать группу хостов `Dashboards`, добавьте блок `dashboards` в блок `config`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
          ...
          config {
            ...
            dashboards {
              node_groups {
               name             = "<имя_группы_виртуальных_хостов>"
                assign_public_ip = <публичный_доступ>
                hosts_count      = <количество_хостов>
                zone_ids         = ["<список_зон_доступности>"]
                subnet_ids       = ["<список_идентификаторов подсетей>"]
                resources {
                  resource_preset_id = "<класс_хоста>"
                  disk_size          = <размер_хранилища_в_байтах>
                  disk_type_id       = "<тип_диска>"
                }
              }
            }
          }
        }
        ```

        Где `assign_public_ip` — публичный доступ к хосту: `true` или `false`.

        В кластере может быть только одна группа хостов `Dashboards`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- API {#api}

    Чтобы создать группу хостов `{{ OS }}`, воспользуйтесь методом REST API [addOpenSearchNodeGroup](../api-ref/Cluster/addOpenSearchNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddOpenSearchNodeGroup](../api-ref/grpc/cluster_service.md#AddOpenSearchNodeGroup).

    Чтобы создать группу хостов `Dashboards`, воспользуйтесь методом REST API [addDashboardsNodeGroup](../api-ref/Cluster/addDashboardsNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddDashboardsNodeGroup](../api-ref/grpc/cluster_service.md#AddDashboardsNodeGroup).

    Передайте в запросе конфигурацию группы в блоке `nodeGroupSpec`:

    * Имя группы хостов в параметре `name`.
    * [Класс хостов](../concepts/instance-types.md) в параметре `resources.resourcePresetId`.
    * [Тип диска](../concepts/storage.md) в параметре `resources.diskTypeId`.
    * Объем хранилища, который будет использоваться для данных, в параметре `resources.diskSize`.
    * Количество хостов в группе в параметре `hostsCount`.
    * Список зон доступности в параметре `zoneIds`.
    * Список подсетей в параметре `subnetIds`.

    
    * Настройки публичного доступа в параметре `assignPublicIp`.


    * Список ролей хостов в параметре `roles` (только для группы хостов с типом `{{ OS }}`).

{% endlist %}

## Изменить конфигурацию группы хостов {#update-host-group}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить конфигурацию группы хостов, выполните команду:

    ```bash
    {{ yc-mdb-os }} node-group update --cluster-name <имя_кластера> \
       --node-group-name <имя_группы_хостов> \
       --resource-preset-id <класс_хостов> \
       --disk-size <размер_диска_в_байтах> \
       --hosts-count <количество_хостов_в_группе> \
       --roles <роли_хостов>
    ```

    В команде укажите нужные параметры в зависимости от того, какая конфигурация группы хостов нужна:

    * `--node-group-name` — имя группы хостов, которую нужно изменить.
    * `--resource-preset-id` — новый класс хостов. Он определяет технические характеристики виртуальных машин, на которых будут развернуты узлы {{ OS }}. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).
    * `--disk-size` — новый размер диска в байтах. Минимальное и максимальное значения зависят от выбранного класса хостов.
    * `--hosts-count` — новое количество хостов в группе.
    * `--roles` — новые [роли хостов](../../managed-opensearch/concepts/host-roles.md). Возможные значения:

      * `data` — предоставляется только роль `DATA`;
      * `manager` — предоставляется только роль `MANAGER`;
      * `data+manager` или `manager+data` — предоставляются обе роли.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

    1. Чтобы изменить конфигурацию группы хостов `{{ OS }}`, измените параметры нужного блока `node_groups` в блоке `opensearch`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
          ...
          opensearch {
            ...
            node_groups {
              name             = "<имя_группы_виртуальных_хостов>"
              assign_public_ip = <публичный_доступ>
              hosts_count      = <количество_хостов>
              roles            = ["<список_ролей>"]
              resources {
                resource_preset_id = "<класс_хоста>"
                disk_size          = <размер_хранилища_в_байтах>
                disk_type_id       = "<тип_диска>"
              }
            }
            ...
          }
        }
        ```

        Где:

        * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.
        * `roles` — роли хостов: `DATA` и `MANAGER`.

    1. Чтобы изменить конфигурацию группы хостов `Dashboards`, измените параметры блока `dashboards`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
          ...
          dashboards {
            node_groups {
              name             = "<имя_группы_виртуальных_хостов>"
              assign_public_ip = <публичный_доступ>
              hosts_count      = <количество_хостов>
              resources {
                resource_preset_id = "<класс_хоста>"
                disk_size          = <размер_хранилища_в_байтах>
                disk_type_id       = "<тип_диска>"
              }
            }
          }
        }
        ```

        Где `assign_public_ip` — публичный доступ к хосту: `true` или `false`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

    Чтобы изменить конфигурацию группы хостов `{{ OS }}`, воспользуйтесь методом REST API [updateOpenSearchNodeGroup](../api-ref/Cluster/updateOpenSearchNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/UpdateOpenSearchNodeGroup](../api-ref/grpc/cluster_service.md#UpdateOpenSearchNodeGroup).

    Чтобы изменить конфигурацию группы хостов `Dashboards`, воспользуйтесь методом REST API [updateDashboardsNodeGroup](../api-ref/Cluster/updateDashboardsNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/UpdateDashboardsNodeGroup](../api-ref/grpc/cluster_service.md#UpdateDashboardsNodeGroup).

    Передайте в запросе новую конфигурацию в блоке `nodeGroupSpec`:

    * [Класс хостов](../concepts/instance-types.md) в параметре `resources.resourcePresetId`.
    * [Тип диска](../concepts/storage.md) в параметре `resources.diskTypeId`.
    * Объем хранилища, который используется для данных, в параметре `resources.diskSize`.
    * Количество хостов в группе в параметре `hostsCount`.
    * Список ролей хостов в параметре `roles` (только для группы хостов с типом `{{ OS }}`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Удалить группу хостов {#delete-host-group}

При удалении группы хостов действует ограничение: нельзя удалить единственную группу хостов с ролью `DATA`.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной группы и выберите пункт **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить группу хостов, выполните команду:

    ```bash
    {{ yc-mdb-os }} node-group delete --cluster-name <имя_кластера> \
       --node-group-name <имя_группы_хостов>
    ```

    В команде укажите группу хостов, которую нужно удалить.

- {{ TF }} {#tf}

    Чтобы удалить группу хостов из кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

    1. Чтобы удалить группу хостов `{{ OS }}`, удалите блок `node_groups`, который соответствует удаляемой группе хостов, из блока `opensearch`.

    1. Чтобы удалить группу хостов `Dashboards`, удалите блок `dashboards`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите удаление ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

    Чтобы удалить группу хостов `{{ OS }}`, воспользуйтесь методом REST API [deleteOpenSearchNodeGroup](../api-ref/Cluster/deleteOpenSearchNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteOpenSearchNodeGroup](../api-ref/grpc/cluster_service.md#DeleteOpenSearchNodeGroup).

    Чтобы удалить группу хостов `Dashboards`, воспользуйтесь методом REST API [deleteDashboardsNodeGroup](../api-ref/Cluster/deleteDashboardsNodeGroup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteDashboardsNodeGroup](../api-ref/grpc/cluster_service.md#DeleteDashboardsNodeGroup).

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
