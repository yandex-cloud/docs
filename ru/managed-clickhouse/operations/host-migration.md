---
title: Миграция хостов кластера {{ CH }} в другую зону доступности
description: Следуя данной инструкции, вы сможете переместить хосты кластера {{ CH }} в другую зону доступности.
---

# Миграция хостов кластера {{ CH }} в другую зону доступности


Хосты {{ CH }} и {{ ZK }} кластера {{ mch-name }} располагаются в [зонах доступности](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. Хосты {{ CH }} и {{ ZK }} можно перенести из одной зоны в другую с помощью этой инструкции, а хосты c {{ CK }} — с помощью обращения в [службу поддержки]({{ link-console-support }}).

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

## Перенести хосты {{ CH }} {#clickhouse-hosts}

1. Убедитесь, что в результате миграции будут перенесены только [реплицируемые таблицы](../concepts/replication.md#replicated-tables) на движке семейства `ReplicatedMergeTree`.

   Нереплицируемые таблицы будут потеряны во время миграции.

1. Если вы создали кластер без поддержки [{{ CK }}](../concepts/replication.md#ck), [включите отказоустойчивость](zk-hosts.md#add-zk) с использованием хостов {{ ZK }}. Иначе вы не сможете добавить новые хосты в [шарды](../concepts/sharding.md) и выполнить миграцию.
1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите хосты.
1. Добавьте хост в кластер:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
      1. Укажите параметры хоста:

         * Зону доступности, куда переносятся хосты.
         * Новую подсеть.
         * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.

      1. Нажмите **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду:

      ```bash
      {{ yc-mdb-ch }} host add \
         --cluster-name <имя_кластера> \
         --host type=clickhouse,`
               `zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_новой_подсети>,`
               `assign-public-ip=<публичный_доступ_к_хосту:_true_или_false>
      ```

      Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters). В параметре `zone-id` укажите зону, куда вы переносите хосты.

   - {{ TF }} {#tf}

      1. В конфигурационный файл {{ TF }} с планом инфраструктуры добавьте манифест хоста:

         ```hcl
         resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
           ...
           host {
             type             = "CLICKHOUSE"
             zone             = "<зона_доступности>"
             subnet_id        = "<идентификатор_новой_подсети>"
             assign_public_ip = <публичный_доступ_к_хосту:_true_или_false>
           }
         }
         ```

         В параметре `zone` укажите зону, куда вы переносите хосты.

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
             --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
             --data '{
                       "hostSpecs": [
                         {
                           "type": "CLICKHOUSE",
                           "zoneId": "<зона_доступности>",
                           "subnetId": "<идентификатор_подсети>",
                           "assignPublicIp": <публичный_доступ_к_хосту>
                         }
                       ]
                     }'
         ```

         Где `hostSpecs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

         * `type` — тип хоста, всегда `CLICKHOUSE` для хостов {{ CH }};
         * `zoneId` — зона доступности;
         * `subnetId` — идентификатор подсети;
         * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

         Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

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
             -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
             -rpc-header "Authorization: Bearer $IAM_TOKEN" \
             -d '{
                     "cluster_id": "<идентификатор_кластера>",
                     "host_specs": [
                         {
                             "type": "CLICKHOUSE",
                             "zone_id": "<зона_доступности>",
                             "subnet_id": "<идентификатор_подсети>",
                             "assign_public_ip": <публичный_доступ_к_хосту>
                         }
                     ]
                 }' \
             {{ api-host-mdb }}:{{ port-https }} \
             yandex.cloud.mdb.clickhouse.v1.ClusterService.AddHosts
         ```

         Где `host_specs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

         * `type` — тип хоста, всегда `CLICKHOUSE` для хостов {{ CH }};
         * `zone_id` — зона доступности;
         * `subnet_id` — идентификатор подсети;
         * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

         Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Чтобы успешно выполнять подключение к базе данных после миграции, укажите FQDN нового хоста в вашем бэкенде или клиенте (например, в коде или графической IDE). Удалите FQDN прежнего хоста в первоначальной зоне.

   Чтобы узнать FQDN, получите список хостов в кластере:

   ```bash
   {{ yc-mdb-ch }} host list --cluster-name <имя_кластера>
   ```

   FQDN указан в выводе команды, в столбце `NAME`. Также вы можете использовать [особый FQDN](connect/fqdn.md#auto) для подключения.

1. Удалите хосты в первоначальной зоне доступности:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
      1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста, выберите пункт **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

   - CLI {#cli}

      Выполните команду для каждого хоста:

      ```bash
      {{ yc-mdb-ch }} host delete <FQDN_хоста> --cluster-name <имя_кластера>
      ```

   - {{ TF }} {#tf}

      1. В конфигурационном файле {{ TF }} с планом инфраструктуры удалите из описания кластера блоки `host` с первоначальной зоной доступности.
      1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Введите слово `yes` и нажмите **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

      {% include [delete-hosts-for-migration](../../_includes/mdb/mch/api/delete-hosts-for-migration-rest.md) %}

   - gRPC API {#grpc-api}

      {% include [delete-hosts-for-migration](../../_includes/mdb/mch/api/delete-hosts-for-migration-grpc.md) %}

   {% endlist %}

1. Дождитесь, когда кластер перейдет в состояние **Alive**. В консоли управления перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**. Состояние кластера отображается в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}**.

## Перенести хосты {{ ZK }} {#zookeeper-hosts}

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите хосты.
1. Добавьте хост в кластер:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-zookeeper }}**.
      1. Укажите новую подсеть и зону доступности, куда переносятся хосты.
      1. Нажмите **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду:

      ```bash
      {{ yc-mdb-ch }} host add \
         --cluster-name <имя_кластера> \
         --host type=zookeeper,`
               `zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_новой_подсети>,`
               `assign-public-ip=<публичный_доступ_к_хосту:_true_или_false>
      ```

      Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters). В параметре `zone-id` укажите зону, куда вы переносите хосты.

   - {{ TF }} {#tf}

      1. В конфигурационный файл {{ TF }} с планом инфраструктуры добавьте манифест хоста:

         ```hcl
         resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
           ...
           host {
             type             = "ZOOKEEPER"
             zone             = "<зона_доступности>"
             subnet_id        = "<идентификатор_новой_подсети>"
             assign_public_ip = <публичный_доступ_к_хосту:_true_или_false>
           }
         }
         ```

         В параметре `zone` укажите зону, куда вы переносите хосты.

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
             --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
             --data '{
                       "hostSpecs": [
                         {
                           "type": "ZOOKEEPER",
                           "zoneId": "<зона_доступности>",
                           "subnetId": "<идентификатор_подсети>",
                           "assignPublicIp": <публичный_доступ_к_хосту>
                         }
                       ]
                     }'
         ```

         Где `hostSpecs` — массив, содержащий настройки создаваемого хоста. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

         * `type` — тип хоста `ZOOKEEPER`;
         * `zoneId` — зона доступности;
         * `subnetId` — идентификатор подсети;
         * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

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
             -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
             -rpc-header "Authorization: Bearer $IAM_TOKEN" \
             -d '{
                     "cluster_id": "<идентификатор_кластера>",
                     "host_specs": [
                         {
                             "type": "ZOOKEEPER",
                             "zone_id": "<зона_доступности>",
                             "subnet_id": "<идентификатор_подсети>",
                             "assign_public_ip": <публичный_доступ_к_хосту>
                         }
                 }' \
             {{ api-host-mdb }}:{{ port-https }} \
             yandex.cloud.mdb.clickhouse.v1.ClusterService.AddHosts
         ```

         Где `host_specs` — массив, содержащий настройки создаваемых хостов. Один элемент массива `host_specs` содержит настройки для одного хоста и имеет следующую структуру:

         * `type` — тип хоста `ZOOKEEPER`;
         * `zone_id` — зона доступности;
         * `subnet_id` — идентификатор подсети;
         * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

         Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Удалите хосты в первоначальной зоне доступности:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
      1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста, выберите пункт **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

   - CLI {#cli}

      Выполните команду для каждого хоста:

      ```bash
      {{ yc-mdb-ch }} host delete <FQDN_хоста> --cluster-name <имя_кластера>
      ```

   - {{ TF }} {#tf}

      1. В конфигурационном файле {{ TF }} с планом инфраструктуры удалите из описания кластера блоки `host` с первоначальной зоной доступности.
      1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Введите слово `yes` и нажмите **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

      {% include [delete-hosts-for-migration](../../_includes/mdb/mch/api/delete-hosts-for-migration-rest.md) %}

   - gRPC API {#grpc-api}

      {% include [delete-hosts-for-migration](../../_includes/mdb/mch/api/delete-hosts-for-migration-grpc.md) %}

   {% endlist %}

1. Дождитесь, когда кластер перейдет в состояние **Alive**. В консоли управления перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**. Состояние кластера отображается в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}**.

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
