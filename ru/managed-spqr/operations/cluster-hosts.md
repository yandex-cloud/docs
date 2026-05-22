---
title: Управление хостами кластера {{ SPQR }}
description: Из статьи вы узнаете, как управлять хостами кластера {{ SPQR }}. Вы сможете добавлять и удалять хосты кластера, а также управлять настройками через консоль управления, CLI и API сервиса.
---

# Управление хостами кластера {{ SPQR }}

Вы можете управлять хостами кластера {{ mspqr-name }}, в том числе:

* [получить список хостов](#list);
* [создать хост](#add);
* [изменить настройки хоста](#update);
* [удалить хост](#remove).

## Получить список хостов в кластере {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список хостов в кластере, выполните команду:

  ```bash
  yc managed-sharded-postgresql hosts list \
    --cluster-name <имя_кластера>
  ```

  Результат:

  
  ```text
  +----------------------------+----------------------+---------+--------+--------------------+-----------+
  |            NAME            |      CLUSTER ID      |  ROLE   | HEALTH |      ZONE ID       | PUBLIC IP |
  +----------------------------+----------------------+---------+--------+--------------------+-----------+
  | rc1b***{{ dns-zone }} | c9qp71dk1dfg******** | PRIMARY | ALIVE  | {{ region-id }}-b      | true      |
  | rc1a***{{ dns-zone }} | c9qp71dk1dfg******** | PRIMARY | ALIVE  | {{ region-id }}-a      | false     |
  +----------------------------+----------------------+---------+--------+--------------------+-----------+
  ```


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/hosts'
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.spqr.v1.ListClusterHostsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.ListHosts
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.spqr.v1.ListClusterHostsResponse).

{% endlist %}

## Создать хост {#add}

Количество хостов `INFRA`, `ROUTER` и `COORDINATOR` в кластерах {{ mspqr-short-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать хост:
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.

  
  1. Укажите параметры хоста:
     * Зону доступности.
     * Подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md)).
     * [Тип хоста](../concepts/index.md#router) — `INFRA` (для кластера со стандартным шардированием), `ROUTER` или `COORDINATOR` (для кластера с расширенным шардированием).
     * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать хост:

  
  1. Запросите список подсетей кластера, чтобы выбрать подсеть для нового хоста:

     ```bash
     yc vpc subnet list
     ```

     Результат:

     ```text
     +----------------------+-----------+----------------------+---------------+-------------------+
     |          ID          |   NAME    |      NETWORK ID      |      ZONE     |      RANGE        |
     +----------------------+-----------+----------------------+---------------+-------------------+
     | b0cl69q1w2e3******** | default-d | enp6rq71w2e3******** | {{ region-id }}-d | [172.16.**.**/20] |
     | e2lkj9q1w2e3******** | default-b | enp6rq71w2e3******** | {{ region-id }}-b | [10.10.**.**/16]  |
     | e9b9v2q1w2e3******** | default-a | enp6rq71w2e3******** | {{ region-id }}-a | [172.16.**.**/20] |
     +----------------------+-----------+----------------------+---------------+-------------------+
     ```

     Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).


  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     yc managed-sharded-postgresql hosts add --help
     ```

  1. Выполните команду добавления хоста:

     
     ```bash
     yc managed-sharded-postgresql hosts add \
       --cluster-name <имя_кластера> \
       --host zone-id=<зона_доступности>,subnet-id=<идентификатор_подсети>,type=<тип_хоста>
     ```


     
     Идентификатор подсети необходимо указать, если в зоне доступности больше одной подсети, в противном случае {{ mspqr-short-name }} автоматически выберет единственную подсеть.


     Возможные значения для [типа хоста](../concepts/index.md#router) — `infra` (для кластера со стандартным шардированием), `router` или `coordinator` (для кластера с расширенным шардированием).

     Также вы можете указать дополнительную опцию `assign-public-ip` в параметре `--host` для управления публичным доступом к хосту:
       * `true` — публичный доступ включен.
       * `false` — публичный доступ выключен.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
       --data '{
                 "hostSpecs": [
                   {
                     "zoneId": "<зона_доступности>",
                     "subnetId": "<идентификатор_подсети>",
                     "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
                     "type": "<тип_хоста>"
                   },
                   { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
                   { ... },
                   { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
                 ]
               }'
     ```

     Где `hostSpecs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `zoneId` — зона доступности.
     * `subnetId` — идентификатор подсети.
     * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
     * `type` — [тип хоста](../concepts/index.md#router): `infra` (для кластера со стандартным шардированием), `router` или `coordinator` (для кластера с расширенным шардированием).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "host_specs": [
               {
                 "zone_id": "<зона_доступности>",
                 "subnet_id": "<идентификатор_подсети>",
                 "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
                 "type": "<тип_хоста>"
               },
               { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
               { ... },
               { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.AddHosts
     ```

     Где `host_specs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `zone_id` — зона доступности.
     * `subnet_id` — идентификатор подсети.
     * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
     * `type` — [тип хоста](../concepts/index.md#router): `infra` (для кластера со стандартным шардированием), `router` или `coordinator` (для кластера с расширенным шардированием).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить хост {#update}

Для каждого хоста в кластере {{ mspqr-short-name }} можно изменить настройки публичного доступа.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить параметры хоста в кластере, выполните команду:

  ```bash
  yc managed-sharded-postgresql hosts update <имя_хоста> \
    --cluster-name <имя_кластера> \
    --assign-public-ip=<публичный_доступ_к_хосту>
  ```

  Где:

  * `cluster-name` — имя кластера.
  * `assign-public-ip` — публичный доступ к хосту: `true` или `false`.

  Имя хоста можно запросить со [списком хостов в кластере](#list).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.UpdateHosts](../api-ref/Cluster/updateHosts.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/hosts:batchUpdate' \
       --data '{
                 "updateHostSpecs": [
                   {
                     "updateMask": "assignPublicIp",
                     "hostName": "<имя_хоста>",
                     "assignPublicIp": <разрешить_публичный_доступ_к_хосту>
                   },
                   { <аналогичный_набор_настроек_для_изменяемого_хоста_2> },
                   { ... },
                   { <аналогичный_набор_настроек_для_изменяемого_хоста_N> }
                 ]
               }'
     ```

     Где `updateHostSpecs` — массив изменяемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `hostName` — имя изменяемого хоста.
     * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

     Имя хоста можно запросить со [списком хостов в кластере](#list).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_host_specs": [
               {
                 "update_mask": {
                     "paths": [
                       "assign_public_ip"
                     ]
                 },
                 "host_name": "<имя_хоста>",
                 "assign_public_ip": <разрешить_публичный_доступ_к_хосту>
               },
               { <аналогичный_набор_настроек_для_изменяемого_хоста_2> },
               { ... },
               { <аналогичный_набор_настроек_для_изменяемого_хоста_N> }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.UpdateHosts
     ```

     Где `update_host_specs` — массив изменяемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `host_name` — имя изменяемого хоста.
     * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

     Имя хоста можно запросить со [списком хостов в кластере](#list).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

{% endlist %}


## Удалить хост {#remove}

Вы можете удалить хост типа `INFRA`, `ROUTER` или `COORDINATOR` из кластера {{ SPQR }}, если он не является единственным хостом соответствующего типа. Чтобы заменить единственный хост, сначала создайте новый хост, а затем удалите старый.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить хост из кластера:
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
  1. В строке хоста, который вы хотите удалить, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), выберите пункт **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  yc managed-sharded-postgresql hosts delete <имя_хоста> \
    --cluster-name <имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](#list).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
       --data '{
                 "hostNames": [
                   "<имя_хоста>"
                 ]
               }'
     ```

     Где `hostNames` — массив строк, состоящий из единственного элемента с именем удаляемого хоста. Имя хоста можно запросить со [списком хостов в кластере](#list).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "host_names": [
               "<имя_хоста>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.DeleteHosts
     ```

     Где `host_names` — массив строк, состоящий из единственного элемента с именем удаляемого хоста. Имя хоста можно запросить со [списком хостов в кластере](#list).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

{% endlist %}
