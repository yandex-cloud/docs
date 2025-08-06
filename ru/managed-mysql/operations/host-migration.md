---
title: Миграция хостов кластера {{ MY }} в другую зону доступности
description: Следуя данной инструкции, вы сможете переместить хосты кластера {{ MY }} в другую зону доступности.
---

# Миграция хостов кластера {{ MY }} в другую зону доступности


Хосты кластера {{ mmy-name }} располагаются в [зонах доступности](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}.  Чтобы перенести хосты из одной зоны в другую:

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите хосты.
1. Добавьте хост в кластер:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
      1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
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
      {{ yc-mdb-my }} host add \
         --cluster-name <имя_кластера> \
         --host zone-id=<зона_доступности>,`
               `subnet-id=<ID_новой_подсети>,`
               `assign-public-ip=<разрешить_публичный_доступ_к_хосту>
      ```

      Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters). В параметре `zone-id` укажите зону, куда вы переносите хосты.

   - {{ TF }} {#tf}

      1. В конфигурационный файл {{ TF }} с планом инфраструктуры добавьте манифест хоста:

         ```hcl
         resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
           ...
           host {
             zone             = "<зона_доступности>"
             subnet_id        = "<идентификатор_новой_подсети>"
             assign_public_ip = <разрешить_публичный_доступ_к_хосту>
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

      1. Воспользуйтесь методом [Cluster.addHosts](../api-ref/Cluster/addHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

         ```bash
         curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
            --data '{
                      "hostSpecs": [
                        {
                          "zoneId": "<зона_доступности>",
                          "subnetId": "<идентификатор_новой_подсети>",
                          "assignPublicIp": <разрешить_публичный_доступ_к_хосту>
                        }
                      ]
                    }'
         ```

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
            -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "host_specs": [
                    {
                      "zone_id": "<зона_доступности>",
                      "subnet_id": "<идентификатор_новой_подсети>",
                      "assign_public_ip": <разрешить_публичный_доступ_к_хосту>
                    }
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mysql.v1.ClusterService.AddHosts
         ```

         Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Чтобы успешно выполнять подключение к базе данных после миграции, укажите FQDN нового хоста в вашем бэкенде или клиенте (например, в коде или графической IDE). Удалите FQDN прежнего хоста в первоначальной зоне.

   Чтобы узнать FQDN, получите список хостов в кластере:

   ```bash
   {{ yc-mdb-my }} host list --cluster-name <имя_кластера>
   ```

   FQDN указан в выводе команды, в столбце `NAME`. Также вы можете использовать [особый FQDN](connect.md#fqdn-master) для подключения.

1. Удалите хосты в первоначальной зоне доступности:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
      1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
      1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста, выберите пункт **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

   - CLI {#cli}

      Выполните команду для каждого хоста:

      ```bash
      {{ yc-mdb-my }} host delete <FQDN_хоста> --cluster-name <имя_кластера>
      ```

   - {{ TF }} {#tf}

      1. В конфигурационном файле {{ TF }} с планом инфраструктуры удалите из описания кластера блоки `host` с первоначальной зоной доступности.
      1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Введите слово `yes` и нажмите **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

      1. Воспользуйтесь методом [Cluster.deleteHosts](../api-ref/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

         ```bash
         curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
            --data '{
                      "hostNames": [
                        "<FQDN_хоста>"
                      ]
                    }'
         ```

         Где `hostNames` — массив с удаляемым хостом.

         В одном запросе можно передать только один FQDN хоста. Если нужно удалить несколько хостов, выполните запрос для каждого хоста.

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

   - gRPC API {#grpc-api}

      1. Воспользуйтесь вызовом [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

         ```bash
         grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "host_names": [
                    "<FQDN_хоста>"
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mysql.v1.ClusterService.DeleteHosts
         ```

         Где `host_names` — массив с удаляемым хостом.

         В одном запросе можно передать только один FQDN хоста. Если нужно удалить несколько хостов, выполните запрос для каждого хоста.

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Дождитесь, когда кластер перейдет в состояние **Alive**. В консоли управления перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**. Состояние кластера отображается в столбце **{{ ui-key.yacloud.mdb.clusters.column_availability }}**.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}

{% include [migration-in-data-transfer-mysql-note](../../_includes/data-transfer/notes/mysql-migration.md) %}
