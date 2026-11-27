---
title: Миграция хостов кластера {{ SD }} в другую зону доступности
description: Следуя данной инструкции, вы сможете перенести хосты кластера {{ SD }} в другую зону доступности.
alternate:
  - href: ru/storedoc/operations/host-migration.md
    type: text/markdown
    title: Markdown version
---

# Миграция хостов кластера {{ SD }} в другую зону доступности

Хосты кластера {{ mmg-name }} располагаются в [зонах доступности](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. Чтобы перенести хосты из одной зоны в другую:

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите хосты.

1. Добавьте хост в кластер:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог.
      1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
      1. Нажмите на имя нужного кластера {{ mmg-name }} и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
      1. Укажите параметры хоста:

         * Зону доступности, куда переносятся хосты.
         * Новую подсеть.
         * Тип хоста и название шарда, если в кластере {{ mmg-name }} включено шардирование.
         * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.
         * (Опционально) Отметьте хост скрытым, если он должен быть доступен для чтения только для прямых подключений. Например, чтобы делать с него резервные копии без дополнительной нагрузки на кластер. Используется только для хостов `MONGOD`.
         * (Опционально) Задайте отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций. Параметр можно указать только для скрытого хоста.

           {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-console.md) %}

           {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}

         * (Опционально) Укажите [приоритет назначения хоста мастером](../concepts/replication.md#master-failover). Используется только для хостов `MONGOD`. Настройка доступна, если хост не отмечен как скрытый.

      1. Нажмите **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду:

      
      ```bash
      {{ yc-mdb-mg }} host add \
        --cluster-name <имя_кластера> \
        --host type=<тип_хоста>,`
              `zone-id=<зона_доступности>,`
              `subnet-id=<ID_новой_подсети>,`
              `assign-public-ip=<разрешить_публичный_доступ_к_хосту>,`
              `hidden=<скрытие_хоста>,`
              `secondary-delay-secs=<отставание_реплики_в_секундах>,`
              `priority=<приоритет_хоста>
      ```


      Особенности команды:

      * Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * Возможные значения параметра `type`: `mongod`, `mongos`, `mongocfg`, `mongoinfra`. Тип хоста зависит от [типа шардирования](../concepts/sharding.md#shard-management).
      * В параметре `zone-id` укажите зону, куда вы переносите хосты.
      * (Опционально) В параметре `hidden` укажите, нужно ли скрывать хост: `true` или `false`. Используется только для хостов `MONGOD`.
      * (Опционально) В параметре `secondary-delay-secs` укажите время отставания вторичной реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций. Параметр можно указать только для скрытого хоста.

         {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-console.md) %}

         {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}

      * (Опционально) В параметре `priority` укажите [приоритет назначения хоста мастером](../concepts/replication.md#master-failover). Используется только для хостов `MONGOD`. Для скрытого хоста параметр не указывается.

   
   - {{ TF }} {#tf}

      1. В конфигурационный файл {{ TF }} с планом инфраструктуры добавьте манифест хоста:

         ```hcl
         resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
           ...
           host {
             role             = "<тип_реплики>"
             type             = "<тип_хоста>"
             zone_id          = "<зона_доступности>"
             subnet_id        = "<идентификатор_новой_подсети>"
             assign_public_ip = <разрешить_публичный_доступ_к_хосту>
             shard_name       = "<имя_шарда>"
             host_parameters {
               hidden               = <скрытие_хоста>
               secondary_delay_secs = <отставание_реплики_в_секундах>
               priority             = <приоритет_хоста>
             }
             ...
           }
         }
         ```

         Возможные значения параметра `role`: `PRIMARY` или `SECONDARY`.

         Возможные значения параметра `type`: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`. Тип хоста зависит от [типа шардирования](../concepts/sharding.md#shard-management).

         В параметре `zone` укажите зону, куда вы переносите хосты.

         Для хоста `MONGOD` в шардированном кластере в параметре `shard_name` укажите имя шарда.

         В блоке `host_parameters` укажите дополнительные параметры хоста:

         * `hidden` — скрытие хоста: `true` или `false`. Используется только для хостов `MONGOD`.
         * `secondary_delay_secs` — отставание вторичной реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций. Параметр можно указать только для скрытого хоста.

            {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-console.md) %}

            {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}

         * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover). Используется только для хостов `MONGOD`. Для скрытого хоста параметр не указывается.

      1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Подтвердите изменение ресурсов.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


   - REST API {#api}

      1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

            {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. Воспользуйтесь методом [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            
            ```bash
            curl \
               --request POST \
               --header "Authorization: Bearer $IAM_TOKEN" \
               --header "Content-Type: application/json" \
               --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
               --data '{
                        "hostSpecs": [
                          {
                            "zoneId": "<зона_доступности>",
                            "subnetId": "<идентификатор_подсети>",
                            "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
                            "type": "<тип_хоста>",
                            "shardName": "<имя_шарда>",
                            "hidden": <скрыть_хост>,
                            "secondaryDelaySecs": "<отставание_реплики_в_секундах>",
                            "priority": "<приоритет_назначения_хоста_мастером>",
                            "tags": "<метки_хоста>"
                          }
                        ]
                      }'
            ```


            Где `hostSpecs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста:

            * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).

            
            * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
            * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


            * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`. Если кластер нешардированный, укажите `MONGOD`.
            * `shardName` — имя шарда в шардированном кластере. Используется только для хостов `MONGOD`.
            * `hidden`— будет ли хост виден (`false`) или скрыт (`true`). Используется только для хостов `MONGOD`.
            * `secondaryDelaySecs` — время отставания хоста от мастера. Параметр можно указать только для скрытого хоста.

              {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-console.md) %}

              {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}

            * `priority` — приоритет назначения хоста [мастером](../concepts/replication.md#master-failover). Используется только для хостов `MONGOD`. Для скрытого хоста параметр не указывается.
            * `tags`— метки хоста. Используется только для хостов `MONGOD`.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation).

   - gRPC API {#grpc-api}

      1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

            {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
      1. Воспользуйтесь вызовом [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            
            ```bash
            grpcurl \
               -format json \
               -import-path ~/cloudapi/ \
               -import-path ~/cloudapi/third_party/googleapis/ \
               -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
               -rpc-header "Authorization: Bearer $IAM_TOKEN" \
               -d '{
                     "cluster_id": "<идентификатор_кластера>",
                     "host_specs": [
                       {
                         "zone_id": "<зона_доступности>",
                         "subnet_id": "<идентификатор_подсети>",
                         "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
                         "type": "<тип_хоста>",
                         "shard_name": "<имя_шарда>",
                         "hidden": <скрыть_хост>,
                         "secondary_delay_secs": "<отставание_реплики_в_секундах>",
                         "priority": "<приоритет_назначения_хоста_мастером>",
                         "tags": "<метки_хоста>"
                       }
                     ]
                  }' \
               {{ api-host-mdb }}:{{ port-https }} \
               yandex.cloud.mdb.mongodb.v1.ClusterService.AddHosts
            ```


            Где `host_specs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста:

            * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

            
            * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
            * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


            * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`. Если кластер нешардированный, укажите `MONGOD`.
            * `shard_name` — имя шарда в шардированном кластере. Используется только для хостов `MONGOD`.
            * `hidden`— будет ли хост виден (`false`) или скрыт (`true`). Используется только для хостов `MONGOD`.
            * `secondary_delay_secs` — время отставания хоста от мастера. Параметр можно указать только для скрытого хоста.

              {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-console.md) %}

              {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}

            * `priority` — приоритет назначения хоста [мастером](../concepts/replication.md#master-failover). Используется только для хостов `MONGOD`. Для скрытого хоста параметр не указывается.
            * `tags`— метки хоста. Используется только для хостов `MONGOD`.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Чтобы успешно выполнять подключение к базе данных после миграции, укажите FQDN нового хоста в вашем бэкенде или клиенте (например, в коде или графической IDE). Удалите FQDN прежнего хоста в первоначальной зоне.

   Чтобы узнать FQDN, получите список хостов в кластере:

   ```bash
   {{ yc-mdb-mg }} host list --cluster-name <имя_кластера>
   ```

   FQDN указан в выводе команды, в столбце `NAME`.

   Как получить FQDN хоста в [Консоли управления]({{ link-console-main }}), описано в [инструкции](connect/index.md#get-fqdn).

1. Удалите хосты в первоначальной зоне доступности:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог.
      1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
      1. Нажмите на имя нужного кластера {{ mmg-name }} и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
      1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста, выберите пункт **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

   - CLI {#cli}

      Выполните команду для каждого хоста:

      ```bash
      {{ yc-mdb-mg }} host delete <FQDN_хоста> --cluster-name <имя_кластера>
      ```

   
   - {{ TF }} {#tf}

      1. В конфигурационном файле {{ TF }} с планом инфраструктуры удалите из описания кластера блоки `host` с первоначальной зоной доступности.
      1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Введите слово `yes` и нажмите **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


   - REST API {#api}

      1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

            {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. Воспользуйтесь методом [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
               --request POST \
               --header "Authorization: Bearer $IAM_TOKEN" \
               --header "Content-Type: application/json" \
               --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
               --data '{
                         "hostNames": [
                           "<имя_хоста>"
                         ]
                       }'
            ```

            Где `hostNames` — массив с именами удаляемых хостов. Чтобы узнать имя нужного хоста, [получите список хостов в кластере](hosts.md#list-hosts).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

   - gRPC API {#grpc-api}

      1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

            {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
      1. Воспользуйтесь вызовом [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
               -format json \
               -import-path ~/cloudapi/ \
               -import-path ~/cloudapi/third_party/googleapis/ \
               -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
               -rpc-header "Authorization: Bearer $IAM_TOKEN" \
               -d '{
                     "cluster_id": "<идентификатор_кластера>",
                     "host_names": [
                       "<имя_хоста>"
                     ]
                   }' \
               {{ api-host-mdb }}:{{ port-https }} \
               yandex.cloud.mdb.mongodb.v1.ClusterService.DeleteHosts
            ```

            Где `host_names` — массив с именами удаляемых хостов. Чтобы узнать имя нужного хоста, [получите список хостов в кластере](hosts.md#list-hosts).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Дождитесь, когда кластер перейдет в состояние **Alive**. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен кластер. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**. Состояние кластера отображается в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}**.

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}
