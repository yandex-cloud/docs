---
title: Управление хостами кластера {{ PG }}
description: Из статьи вы узнаете, как управлять хостами кластера {{ PG }}. Вы сможете добавлять и удалять хосты кластера, а также управлять настройками через консоль управления, CLI и API сервиса.
---

# Управление хостами кластера {{ PG }}

Вы можете добавлять и удалять хосты кластера, а также управлять их настройками. О том, как перенести хосты кластера в другую [зону доступности](../../overview/concepts/geo-scope.md), читайте в [инструкции](host-migration.md).

## Получить список хостов в кластере {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список хостов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-pg }} host list \
    --cluster-name <имя_кластера>
  ```

  Результат:


  ```text
  +----------------------------+----------------------+---------+--------+--------------------+
  |            NAME            |      CLUSTER ID      |  ROLE   | HEALTH |      ZONE ID       |
  +----------------------------+----------------------+---------+--------+--------------------+
  | rc1b***{{ dns-zone }} | c9qp71dk1dfg******** | MASTER  | ALIVE  | {{ region-id }}-b      |
  | rc1a***{{ dns-zone }} | c9qp71dk1dfg******** | REPLICA | ALIVE  | {{ region-id }}-a      |
  +----------------------------+----------------------+---------+--------+--------------------+
  ```


  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.listHosts](../api-ref/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService/ListHosts](../api-ref/grpc/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.ListHosts
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse).

{% endlist %}

## Создать хост {#add}

Количество хостов в кластерах {{ mpg-short-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать хост:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.


  1. Укажите параметры хоста:
     * Зону доступности.
     * Подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md)).
     * Источник репликации (если вы используете [каскадную репликацию](../concepts/replication.md#replication-manual)).
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
     | e9b0phq1w2e3******** | a-2       | enp6rq71w2e3******** | {{ region-id }}-a | [172.16.**.**/20] |
     | e9b9v2q1w2e3******** | default-a | enp6rq71w2e3******** | {{ region-id }}-a | [172.16.**.**/20] |
     +----------------------+-----------+----------------------+---------------+-------------------+
     ```

     Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).


  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     {{ yc-mdb-pg }} host add --help
     ```

  1. Выполните команду добавления хоста:


     ```bash
     {{ yc-mdb-pg }} host add
       --cluster-name <имя_кластера>
       --host zone-id=<зона_доступности>,subnet-id=<идентификатор_подсети>
     ```



     Идентификатор подсети необходимо указать, если в зоне доступности больше одной подсети, в противном случае {{ mpg-short-name }} автоматически выберет единственную подсеть. Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


     Также вы можете указать несколько дополнительных опций в параметре `--host` для управления публичным доступом к хосту и репликацией в кластере:
     * Источник репликации для хоста в опции `replication-source` для того, чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual).
     * Доступность хоста извне {{ yandex-cloud }} в опции `assign-public-ip`:
       * `true` — публичный доступ включен.
       * `false` — публичный доступ выключен.

  {{ mpg-short-name }} запустит операцию добавления хоста.

- {{ TF }} {#tf}

  Чтобы создать хост:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).
  1. Добавьте к описанию кластера {{ mpg-name }} блок `host`.

     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
       ...
       host {
         name                    = "<имя_хоста>"
         zone                    = "<зона_доступности>"
         subnet_id               = "<идентификатор_подсети>"
         replication_source_name = "<источник_репликации>"
         assign_public_ip        = <публичный_доступ_к_хосту>
       }
     }
     ```

     Где:

     * `name` — имя хоста.
     * `zone` — зона доступности.
     * `subnet_id` — идентификатор подсети.
     * `replication_source_name` — источник репликации: атрибут `name` соответствующего блока `host`.
     * `assign_public_ip` — [публичный доступ к хосту](../concepts/network.md#public-access-to-a-host): `true` или `false`.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.addHosts](../api-ref/Cluster/addHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
       --data '{
                 "hostSpecs": [
                   {
                     "zoneId": "<зона_доступности>",
                     "subnetId": "<идентификатор_подсети>",
                     "assignPublicIp": <публичный_адрес_хоста:_true_или_false>,
                     "replicationSource": "<FQDN_хоста>",
                     "priority": "<приоритет_хоста>",
                     "configSpec": {
                       "postgresqlConfig_<версия_{{ PG }}>": {
                         <настройки_{{ PG }}>
                       }
                     }
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
     * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу.
     * `replicationSource` — источник репликации для хоста для [ручного управления потоками репликации](../concepts/replication.md#replication-manual). В параметре укажите [FQDN хоста](connect.md#special-fqdns), который будет источником репликации.
     * `priority` — приоритет хоста среди всех хостов.
     * `configSpec.postgresqlConfig_<версия_{{ PG }}>` — набор настроек {{ PG }}. Укажите каждую настройку на отдельной строке через запятую.

       Список версий {{ PG }}, доступных для параметра, см. в [описании метода](../api-ref/Cluster/addHosts.md#yandex.cloud.mdb.postgresql.v1.AddClusterHostsRequest). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService/AddHosts](../api-ref/grpc/Cluster/addHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "host_specs": [
               {
                 "zone_id": "<зона_доступности>",
                 "subnet_id": "<идентификатор_подсети>",
                 "assign_public_ip": <публичный_адрес_хоста:_true_или_false>,
                 "replication_source": "<FQDN_хоста>",
                 "priority": "<приоритет_хоста>",
                 "config_spec": {
                   "postgresql_config_<версия_{{ PG }}>": {
                     <настройки_{{ PG }}>
                   }
                 }
               },
               { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
               { ... },
               { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.AddHosts
     ```

     Где `host_specs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `zone_id` — зона доступности.
     * `subnet_id` — идентификатор подсети.
     * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу.
     * `replication_source` — источник репликации для хоста для [ручного управления потоками репликации](../concepts/replication.md#replication-manual). В параметре укажите [FQDN хоста](connect.md#special-fqdns), который будет источником репликации.
     * `priority` — приоритет хоста среди всех хостов.
     * `config_spec.postgresql_config_<версия_{{ PG }}>` — набор настроек {{ PG }}. Укажите каждую настройку на отдельной строке через запятую.

       Список версий {{ PG }}, доступных для параметра, см. в [описании метода](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Изменить хост {#update}

Для каждого хоста в кластере {{ mpg-short-name }} можно указать источник [репликации](../concepts/replication.md) и управлять [публичным доступом](../concepts/network.md#public-access-to-a-host) к хосту.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить параметры хоста в кластере:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Задайте новые настройки для хоста:
     1. Выберите источник репликации для хоста для того, чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual).
     1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить параметры хоста в кластере, выполните команду:

  ```bash
  {{ yc-mdb-pg }} host update <имя_хоста>
    --cluster-name <имя_кластера>
    --replication-source <имя_хоста-источника>
    --assign-public-ip=<публичный_доступ_к_хосту>
  ```

  Где:

  * `cluster-name` — имя кластера.
  * `replication-source` — имя хоста-источника.
  * `assign-public-ip` — [публичный доступ к хосту](../concepts/network.md#public-access-to-a-host): `true` или `false`.

  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual) в кластере, измените источник репликации для хоста в параметре `--replication-source`.

- {{ TF }} {#tf}

  Чтобы изменить параметры хоста в кластере:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).
  1. Измените в описании кластера {{ mpg-name }} атрибуты блока `host`, соответствующего изменяемому хосту.

     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
       ...
       host {
         replication_source_name = "<источник_репликации>"
         assign_public_ip        = <публичный_доступ_к_хосту>
       }
     }
     ```

  Где:

  * `replication_source_name` — источник репликации: атрибут `name` соответствующего блока `host`.
  * `assign_public_ip` — [публичный доступ к хосту](../concepts/network.md#public-access-to-a-host): `true` или `false`.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts:batchUpdate' \
       --data '{
                 "updateHostSpecs": [
                   {
                     "updateMask": "assignPublicIp,replicationSource,priority,configSpec.postgresqlConfig_<версия_{{ PG }}>",
                     "hostName": "<FQDN_хоста>",
                     "assignPublicIp": <публичный_адрес_хоста:_true_или_false>,
                     "replicationSource": "<FQDN_хоста>",
                     "priority": "<приоритет_хоста>",
                     "configSpec": {
                       "postgresqlConfig_<версия_{{ PG }}>": {
                         <настройки_{{ PG }}>
                       }
                     }
                   },
                   { <аналогичный_набор_настроек_для_изменяемого_хоста_2> },
                   { ... },
                   { <аналогичный_набор_настроек_для_изменяемого_хоста_N> }
                 ]
               }'
     ```

     Где `updateHostSpecs` — массив изменяемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `hostName` — [FQDN изменяемого хоста](connect.md#fqdn).
     * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
     * `replicationSource` — источник репликации для хоста для [ручного управления потоками репликации](../concepts/replication.md#replication-manual). В параметре укажите FQDN хоста, который будет источником репликации.
     * `priority` — приоритет хоста среди всех хостов.
     * `configSpec.postgresqlConfig_<версия_{{ PG }}>` — набор настроек {{ PG }}. Укажите каждую настройку на отдельной строке через запятую.

       Список версий {{ PG }}, доступных для параметра, см. в [описании метода](../api-ref/Cluster/updateHosts.md#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsRequest). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_host_specs": [
               {
                 "update_mask": {
                     "paths": [
                       "assign_public_ip",
                       "replication_source",
                       "priority",
                       "config_spec.postgresql_config_16"
                     ]
                 },
                 "host_name": "<FQDN_хоста>",
                 "assign_public_ip": <публичный_адрес_хоста:_true_или_false>,
                 "replication_source": "<FQDN_хоста>",
                 "priority": "<приоритет_хоста>",
                 "config_spec": {
                   "postgresql_config_<версия_{{ PG }}>": {
                     <настройки_{{ PG }}>
                   }
                 }
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.UpdateHosts
     ```

     Где `update_host_specs` — массив изменяемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `host_name` — [FQDN изменяемого хоста](connect.md#fqdn).
     * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
     * `replication_source` — источник репликации для хоста для [ручного управления потоками репликации](../concepts/replication.md#replication-manual). В параметре укажите FQDN хоста, который будет источником репликации.
     * `priority` — приоритет хоста среди всех хостов.
     * `config_spec.postgresql_config_<версия_{{ PG }}>` — набор настроек {{ PG }}. Укажите каждую настройку на отдельной строке через запятую.

       Список версий {{ PG }}, доступных для параметра, см. в [описании метода](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если после изменения хоста к нему невозможно [подключиться](connect.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Удалить хост {#remove}

Вы можете удалить хост из кластера {{ PG }}, если он не является единственным хостом. Чтобы заменить единственный хост, сначала создайте новый хост, а затем удалите старый.

Если хост является мастером в момент удаления, {{ mpg-short-name }} автоматически назначит мастером следующую по приоритету реплику.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить хост из кластера:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста, выберите пункт **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  {{ yc-mdb-pg }} host delete <имя_хоста>
    --cluster-name <имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  Чтобы удалить хост из кластера:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).
  1. Удалите из описания кластера {{ mpg-name }} блок `host`, соответствующий удаляемому хосту.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.deleteHosts](../api-ref/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
       --data '{
                 "hostNames": [
                   "<FQDN_хоста>"
                 ]
               }'
     ```

     Где `hostNames` — массив строк, каждая из которых содержит [FQDN удаляемого хоста](connect.md#fqdn).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "host_names": [
               "<FQDN_хоста>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.DeleteHosts
     ```

     Где `host_names` — массив строк, каждая из которых содержит [FQDN удаляемого хоста](connect.md#fqdn).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}