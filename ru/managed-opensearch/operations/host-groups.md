---
title: Управление группами хостов {{ OS }} в {{ mos-full-name }}
description: Вы можете получать список хостов в кластере {{ OS }}, а также добавлять, редактировать и удалять группы хостов кластера.
keywords:
  - управление группами хостов OpenSearch
  - группы хостов OpenSearch
  - OpenSearch
---

# Управление группами хостов {{ OS }}


В кластере {{ mos-name }} вы можете управлять [группами хостов](../concepts/host-roles.md):

* [Получить список групп хостов в кластере](#list-groups).
* [Создать группу хостов](#add-host-group).
* [Изменить конфигурацию группы хостов](#update-host-group), в том числе добавить в нее новые хосты или удалить их.
* [Удалить группу хостов](#delete-host-group).

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Get](../api-ref/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster).

        Доступные группы хостов указаны в параметрах `nodeGroups`.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.Get](../api-ref/grpc/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.Get
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster).

        Доступные группы хостов указаны в параметрах `nodeGroups`.

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

        * (Опционально) В блоке **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** настройте автоматическое увеличение размера диска:

            {% include [console-autoscaling](../../_includes/mdb/mos/console_autoscaling.md) %}

        * Расположение хостов по зонам доступности и подсетям.

        * Количество создаваемых хостов.

        
        * Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если вы хотите, чтобы к хостам можно было [подключаться](connect.md) через интернет.


    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_create-node-group }}**.

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        
        ```json
        {
            "nodeGroupSpec": {
                "name": "<название_группы_хостов>",
                "resources": {
                    "resourcePresetId": "<класс_хостов>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"
                },
                "roles": ["<роль_1>","<роль_2>"],
                "hostsCount": "<число_хостов>",
                "zoneIds": [
                    "<зона_доступности_1>",
                    "<зона_доступности_2>",
                    "<зона_доступности_3>"
                ],
                "subnetIds": [
                    "<идентификатор_подсети_1>",
                    "<идентификатор_подсети_2>",
                    "<идентификатор_подсети_3>"
                ],
                "assignPublicIp": <публичный_адрес_хоста:_true_или_false>,
                "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<процент_для_планового_увеличения>",
                    "emergencyUsageThreshold": "<процент_для_незамедлительного_увеличения>",
                    "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                }
            }
        }
        ```


        Где `nodeGroups` — настройки хостов:

        * `name` — имя группы хостов.
        * `resources` — ресурсы кластера:

            * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
            * `diskSize` — размер диска в байтах;
            * `diskTypeId` — [тип диска](../concepts/storage.md).

        * `roles` (только для хостов `{{ OS }}`) — список [ролей хостов](../concepts/host-roles.md): `DATA` или `MANAGER`. На одну группу можно назначить одну или обе роли.
        * `hostsCount` — количество хостов в группе. Миниальное число хостов `DATA` и `Dashboards` — один, хостов `MANAGER` — три.
        * `zoneIds` — список зон доступности, где размещаются хосты кластера.
        * `subnetIds` — список идентификаторов подсетей.

        
        * `assignPublicIp` — разрешение на [подключение](connect.md) к хосту из интернета.


        * `diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища:

            * `plannedUsageThreshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее окно обслуживания.

                Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

                Если вы задали этот параметр, [настройте расписание окна технического обслуживания](update.md#change-additional-settings) перед созданием группы хостов.

            * `emergencyUsageThreshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.

                Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `plannedUsageThreshold`.

            * `diskSizeLimit` — максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

    1. Чтобы создать группу хостов `{{ OS }}`:

        1. Воспользуйтесь методом [Cluster.AddOpenSearchNodeGroup](../api-ref/Cluster/addOpenSearchNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/opensearch/node_groups' \
                --data "@body.json"
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addOpenSearchNodeGroup.md#yandex.cloud.operation.Operation).

    1. Чтобы создать группу хостов `Dashboards`:

        1. Воспользуйтесь методом [Cluster.AddDashboardsNodeGroup](../api-ref/Cluster/addDashboardsNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/dashboards/node_groups' \
                --data "@body.json"
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addDashboardsNodeGroup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        
        ```json
        {
            "node_group_spec": {
                "name": "<название_группы_хостов>",
                "resources": {
                    "resource_preset_id": "<класс_хостов>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                },
                "roles": ["<роль_1>","<роль_2>"],
                "hosts_count": "<число_хостов>",
                "zone_ids": [
                    "<зона_доступности_1>",
                    "<зона_доступности_2>",
                    "<зона_доступности_3>"
                ],
                "subnet_ids": [
                    "<идентификатор_подсети_1>",
                    "<идентификатор_подсети_2>",
                    "<идентификатор_подсети_3>"
                ],
                "assign_public_ip": <публичный_адрес_хоста:_true_или_false>,
                "disk_size_autoscaling": {
                    "planned_usage_threshold": "<процент_для_планового_увеличения>",
                    "emergency_usage_threshold": "<процент_для_незамедлительного_увеличения>",
                    "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                }
            }
        }
        ```


        Где `node_groups` — настройки хостов:

        * `name` — имя группы хостов.
        * `resources` — ресурсы кластера:

            * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
            * `disk_size` — размер диска в байтах;
            * `disk_type_id` — [тип диска](../concepts/storage.md).

        * `roles` (только для хостов `{{ OS }}`) — список [ролей хостов](../concepts/host-roles.md): `DATA` или `MANAGER`. На одну группу можно назначить одну или обе роли.
        * `hosts_count` — количество хостов в группе. Миниальное число хостов `DATA` и `Dashboards` — один, хостов `MANAGER` — три.
        * `zone_ids` — список зон доступности, где размещаются хосты кластера.
        * `subnet_ids` — список идентификаторов подсетей.

        
        * `assign_public_ip` — разрешение на [подключение](connect.md) к хосту из интернета.


        * `disk_size_autoscaling` — настройки автоматического увеличения размера хранилища:

            * `planned_usage_threshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее окно обслуживания.

                Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

                Если вы задали этот параметр, [настройте расписание окна технического обслуживания](update.md#change-additional-settings) перед созданием группы хостов.

            * `emergency_usage_threshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.

                Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `planned_usage_threshold`.

            * `disk_size_limit` — максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

    1. Чтобы создать группу хостов `{{ OS }}`:

        1. Воспользуйтесь вызовом [ClusterService.AddOpenSearchNodeGroup](../api-ref/grpc/Cluster/addOpenSearchNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.AddOpenSearchNodeGroup \
                < body.json
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addDashboardsNodeGroup.md#yandex.cloud.operation.Operation).

    1. Чтобы создать группу хостов `Dashboards`:

        1. Воспользуйтесь вызовом [ClusterService.AddDashboardsNodeGroup](../api-ref/grpc/Cluster/addDashboardsNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.AddDashboardsNodeGroup \
                < body.json
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addDashboardsNodeGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить конфигурацию группы хостов {#update-host-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной группы и выберите пункт **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
    1. Измените настройки группы хостов:

        * [Роль хостов](../concepts/host-roles.md) (только для группы хостов `{{ OS }}`).
        * Платформу, тип и класс хостов.

            Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты ноды {{ OS }}. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

        * Размер диска.

            Шаг, с которым можно изменить размер диска, зависит от типа диска:

            * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.

            * Локальные SSD-диски:
                * для платформы **Intel Cascade Lake** — с шагом 100 ГБ;
                * для платформы **Intel Ice Lake** — с шагом {{ local-ssd-v3-step }}.
            * Нереплицируемые SSD-диски — с шагом 93 ГБ.

        * (Опционально) В блоке **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** настройте автоматическое увеличение размера диска:

            {% include [console-autoscaling](../../_includes/mdb/mos/console_autoscaling.md) %}

        * Расположение хостов по зонам доступности и подсетям.

        * Количество хостов.

        * Публичный доступ к хостам.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        
        ```json
        {
            "updateMask": "resources,hostsCount,zoneIds,subnetIds,assignPublicIp,diskSizeAutoscaling",
            "nodeGroupSpec": {
                "resources": {
                    "resourcePresetId": "<класс_хостов>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"
                },
                "hostsCount": "<число_хостов>",
                "zoneIds": [
                    "<зона_доступности_1>",
                    "<зона_доступности_2>",
                    "<зона_доступности_3>"
                ],
                "subnetIds": [
                    "<идентификатор_подсети_1>",
                    "<идентификатор_подсети_2>",
                    "<идентификатор_подсети_3>"
                ],
                "assignPublicIp": <публичный_адрес_хоста:_true_или_false>,
                "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<процент_для_планового_увеличения>",
                    "emergencyUsageThreshold": "<процент_для_незамедлительного_увеличения>",
                    "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                }
            }
        }
        ```


        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
        * `nodeGroups` — настройки хостов:

            * `resources` — ресурсы кластера:

                * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
                * `diskSize` — размер диска в байтах;
                * `diskTypeId` — [тип диска](../concepts/storage.md).

            * `hostsCount` — количество хостов в группе. Миниальное число хостов `DATA` и `Dashboards` — один, хостов `MANAGER` — три.
            * `zoneIds` — список зон доступности, где размещаются хосты кластера.
            * `subnetIds` — список идентификаторов подсетей.

            
            * `assignPublicIp` — разрешение на [подключение](connect.md) к хосту из интернета.


            * `diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища:

                * `plannedUsageThreshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее окно обслуживания.

                    Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

                    Если вы задали этот параметр, [настройте расписание окна технического обслуживания](update.md#change-additional-settings) перед созданием группы хостов.

                * `emergencyUsageThreshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.

                    Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `plannedUsageThreshold`.

                * `diskSizeLimit` — максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

    1. Чтобы изменить конфигурацию группы хостов `{{ OS }}`:

        1. Воспользуйтесь методом [Cluster.UpdateOpenSearchNodeGroup](../api-ref/Cluster/updateOpenSearchNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/opensearch/node_groups/<название_группы_хостов>' \
                --data "@body.json"
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Название группы хостов можно запросить с [детальной информацией о кластере](cluster-list.md#get-cluster).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateOpenSearchNodeGroup.md#yandex.cloud.operation.Operation).

    1. Чтобы изменить конфигурацию группы хостов `Dashboards`:

        1. Воспользуйтесь методом [Cluster.UpdateDashboardsNodeGroup](../api-ref/Cluster/updateDashboardsNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/dashboards/node_groups/<название_группы_хостов>' \
                --data "@body.json"
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Название группы хостов можно запросить с [детальной информацией о кластере](cluster-list.md#get-cluster).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateDashboardsNodeGroup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        
        ```json
        {
            "cluster_id": "<идентификатор_кластера>",
            "name": "<название_группы_хостов>",
            "update_mask": {
                "paths": [
                    "resources",
                    "hosts_count",
                    "zone_ids",
                    "subnet_ids",
                    "assign_public_ip"
                ]
            },
            "node_group_spec": {
                "resources": {
                    "resource_preset_id": "<класс_хостов>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                },
                "hosts_count": "<число_хостов>",
                "zone_ids": [
                    "<зона_доступности_1>",
                    "<зона_доступности_2>",
                    "<зона_доступности_3>"
                ],
                "subnet_ids": [
                    "<идентификатор_подсети_1>",
                    "<идентификатор_подсети_2>",
                    "<идентификатор_подсети_3>"
                ],
                "assign_public_ip": <публичный_адрес_хоста:_true_или_false>,
                "disk_size_autoscaling": {
                    "planned_usage_threshold": "<процент_для_планового_увеличения>",
                    "emergency_usage_threshold": "<процент_для_незамедлительного_увеличения>",
                    "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                }
            }
        }
        ```


        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
        * `node_groups` — настройки хостов:

            * `resources` — ресурсы кластера:

                * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
                * `disk_size` — размер диска в байтах;
                * `disk_type_id` — [тип диска](../concepts/storage.md).

            * `hosts_count` — количество хостов в группе. Миниальное число хостов `DATA` и `Dashboards` — один, хостов `MANAGER` — три.
            * `zone_ids` — список зон доступности, где размещаются хосты кластера.
            * `subnet_ids` — список идентификаторов подсетей.

            
            * `assign_public_ip` — разрешение на [подключение](connect.md) к хосту из интернета.


            * `disk_size_autoscaling` — настройки автоматического увеличения размера хранилища:

                * `planned_usage_threshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее окно обслуживания.

                    Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

                    Если вы задали этот параметр, [настройте расписание окна технического обслуживания](update.md#change-additional-settings) перед созданием группы хостов.

                * `emergency_usage_threshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.

                    Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `planned_usage_threshold`.

                * `disk_size_limit` — максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

    1. Чтобы изменить конфигурацию группы хостов `{{ OS }}`:

        1. Воспользуйтесь вызовом [ClusterService.UpdateOpenSearchNodeGroup](../api-ref/grpc/Cluster/updateOpenSearchNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.UpdateOpenSearchNodeGroup \
                < body.json
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Название группы хостов можно запросить с [детальной информацией о кластере](cluster-list.md#get-cluster).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateOpenSearchNodeGroup.md#yandex.cloud.operation.Operation).

    1. Чтобы изменить конфигурацию группы хостов `Dashboards`:

        1. Воспользуйтесь вызовом [ClusterService.UpdateDashboardsNodeGroup](../api-ref/grpc/Cluster/updateDashboardsNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.UpdateDashboardsNodeGroup \
                < body.json
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Название группы хостов можно запросить с [детальной информацией о кластере](cluster-list.md#get-cluster).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateDashboardsNodeGroup.md#yandex.cloud.operation.Operation).

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Чтобы удалить группу хостов `{{ OS }}`:

        1. Воспользуйтесь методом [Cluster.DeleteOpenSearchNodeGroup](../api-ref/Cluster/deleteOpenSearchNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request DELETE \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/opensearch/node_groups/<название_группы_хостов>'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Название группы хостов можно запросить с [детальной информацией о кластере](cluster-list.md#get-cluster).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteOpenSearchNodeGroup.md#yandex.cloud.operation.Operation).

    1. Чтобы удалить группу хостов `Dashboards`:

        1. Воспользуйтесь методом [Cluster.DeleteDashboardsNodeGroup](../api-ref/Cluster/deleteDashboardsNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request DELETE \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/dashboards/node_groups/<название_группы_хостов>'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Название группы хостов можно запросить с [детальной информацией о кластере](cluster-list.md#get-cluster).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteDashboardsNodeGroup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Чтобы удалить группу хостов `{{ OS }}`:

        1. Воспользуйтесь вызовом [ClusterService.DeleteOpenSearchNodeGroup](../api-ref/grpc/Cluster/deleteOpenSearchNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                        "cluster_id": "<идентификатор_кластера>",
                        "name": "<название_группы_хостов>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.DeleteOpenSearchNodeGroup
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Название группы хостов можно запросить с [детальной информацией о кластере](cluster-list.md#get-cluster).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteOpenSearchNodeGroup.md#yandex.cloud.operation.Operation).

    1. Чтобы удалить группу хостов `Dashboards`:

        1. Воспользуйтесь вызовом [ClusterService.DeleteDashboardsNodeGroup](../api-ref/grpc/Cluster/deleteDashboardsNodeGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                        "cluster_id": "<идентификатор_кластера>",
                        "name": "<название_группы_хостов>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.DeleteDashboardsNodeGroup
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Название группы хостов можно запросить с [детальной информацией о кластере](cluster-list.md#get-cluster).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteDashboardsNodeGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить список хостов в кластере {#list-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![hosts](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/hosts'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.ListHosts
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse).

{% endlist %}
