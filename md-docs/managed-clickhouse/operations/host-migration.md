[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Управление хостами > Миграция хостов в другую зону доступности

# Миграция хостов кластера ClickHouse® в другую зону доступности


Хосты ClickHouse® и ZooKeeper кластера Managed Service for ClickHouse® располагаются в [зонах доступности](../../overview/concepts/geo-scope.md) Yandex Cloud. Хосты ClickHouse® и ZooKeeper можно перенести из одной зоны в другую с помощью этой инструкции, а хосты со встроенным ClickHouse® Keeper — с помощью обращения в [службу поддержки](https://center.yandex.cloud/support).

{% note info %}

Для кластеров, хосты которых располагаются в [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`, недоступно:

- использование платформы Intel Broadwell;
- хранилище на локальных SSD-дисках при использовании платформы Intel Cascade Lake.

{% endnote %}

## Перенести хосты ClickHouse® {#clickhouse-hosts}

1. Убедитесь, что в результате миграции будут перенесены только [реплицируемые таблицы](../concepts/replication.md#replicated-tables) на движке семейства `ReplicatedMergeTree`.

   Нереплицируемые таблицы будут потеряны во время миграции.

1. Если в кластере нет сервиса координации, [включите](update.md#enable-coordination) его. Без сервиса координации вы не сможете добавить новые хосты в [шарды](../concepts/sharding.md) и выполнить миграцию.
1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите хосты.
1. Добавьте хост в кластер:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
      1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
      1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**.
      1. Нажмите кнопку **Создать хост**.
      1. Укажите параметры хоста:

         * Зону доступности, куда переносятся хосты.
         * Новую подсеть.
         * Выберите опцию **Публичный доступ**, если хост должен быть доступен извне Yandex Cloud.

      1. Нажмите **Сохранить**.

   - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc managed-clickhouse host add \
         --cluster-name <имя_кластера> \
         --host type=clickhouse,`
               `zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_новой_подсети>,`
               `assign-public-ip=<разрешить_публичный_доступ_к_хосту>
      ```

      Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters). В параметре `zone-id` укажите зону, куда вы переносите хосты.

   
   - Terraform {#tf}

      1. В конфигурационном файле Terraform с планом инфраструктуры в блок `hosts` добавьте новый хост ClickHouse®:

         ```hcl
         resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
           ...
           hosts = {
             ...
             <имя_хоста> = {
               type             = "CLICKHOUSE"
               zone             = "<зона_доступности>"
               subnet_id        = "<идентификатор_новой_подсети>"
               assign_public_ip = <разрешить_публичный_доступ_к_хосту>
               shard_name       = "<имя_шарда>"
             }
           }
         }
         ```

         В параметре `zone` укажите зону, куда вы переносите хосты.

      1. Проверьте корректность настроек.

         1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
         1. Выполните команду:
         
            ```bash
            terraform validate
            ```
         
            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Подтвердите изменение ресурсов.

         1. Выполните команду для просмотра планируемых изменений:
         
            ```bash
            terraform plan
            ```
         
            Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
         
         1. Если вас устраивают планируемые изменения, внесите их:
            1. Выполните команду:
         
               ```bash
               terraform apply
               ```
         
            1. Подтвердите изменение ресурсов.
            1. Дождитесь завершения операции.


   - REST API {#api}

      1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

         ```bash
         export IAM_TOKEN="<IAM-токен>"
         ```

      1. Воспользуйтесь методом [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

         ```bash
         curl \
             --request POST \
             --header "Authorization: Bearer $IAM_TOKEN" \
             --header "Content-Type: application/json" \
             --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
             --data '{
                       "hostSpecs": [
                         {
                           "type": "CLICKHOUSE",
                           "zoneId": "<зона_доступности>",
                           "subnetId": "<идентификатор_подсети>",
                           "assignPublicIp": <разрешить_публичный_доступ_к_хосту>
                         }
                       ]
                     }'
         ```

         Где `hostSpecs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

         * `type` — тип хоста, всегда `CLICKHOUSE` для хостов ClickHouse®;
         * `zoneId` — зона доступности;
         * `subnetId` — идентификатор подсети;
         * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

         Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation).

   - gRPC API {#grpc-api}

      1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

         ```bash
         export IAM_TOKEN="<IAM-токен>"
         ```

      1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
         
         ```bash
         cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
         ```
         
         Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
      1. Воспользуйтесь вызовом [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                             "assign_public_ip": <разрешить_публичный_доступ_к_хосту>
                         }
                     ]
                 }' \
             mdb.api.cloud.yandex.net:443 \
             yandex.cloud.mdb.clickhouse.v1.ClusterService.AddHosts
         ```

         Где `host_specs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

         * `type` — тип хоста, всегда `CLICKHOUSE` для хостов ClickHouse®;
         * `zone_id` — зона доступности;
         * `subnet_id` — идентификатор подсети;
         * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

         Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Чтобы успешно выполнять подключение к базе данных после миграции, укажите FQDN нового хоста в вашем бэкенде или клиенте (например, в коде или графической IDE). Удалите FQDN прежнего хоста в первоначальной зоне.

   Чтобы узнать FQDN, получите список хостов в кластере:

   ```bash
   yc managed-clickhouse host list --cluster-name <имя_кластера>
   ```

   FQDN указан в выводе команды, в столбце `NAME`. Также вы можете использовать [особый FQDN](connect/fqdn.md#auto) для подключения.

1. Удалите хосты в первоначальной зоне доступности:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
      1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
      1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
      1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста, выберите пункт **Удалить** и подтвердите удаление.

   - CLI {#cli}

      Выполните команду для каждого хоста:

      ```bash
      yc managed-clickhouse host delete <FQDN_хоста> --cluster-name <имя_кластера>
      ```

      
   - Terraform {#tf}

      1. В конфигурационном файле Terraform с планом инфраструктуры удалите из блока `hosts` хост ClickHouse® с первоначальной зоной доступности.
      1. Проверьте корректность настроек.

         1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
         1. Выполните команду:
         
            ```bash
            terraform validate
            ```
         
            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Введите слово `yes` и нажмите **Enter**.

         1. Выполните команду для просмотра планируемых изменений:
         
            ```bash
            terraform plan
            ```
         
            Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
         
         1. Если вас устраивают планируемые изменения, внесите их:
            1. Выполните команду:
         
               ```bash
               terraform apply
               ```
         
            1. Подтвердите изменение ресурсов.
            1. Дождитесь завершения операции.


   - REST API {#api}

      1. Воспользуйтесь методом [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):
      
          ```bash
          curl \
             --request POST \
             --header "Authorization: Bearer $IAM_TOKEN" \
             --header "Content-Type: application/json" \
             --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
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

      1. Воспользуйтесь вызовом [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
      
          ```bash
          grpcurl \
             -format json \
             -import-path ~/cloudapi/ \
             -import-path ~/cloudapi/third_party/googleapis/ \
             -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
             -rpc-header "Authorization: Bearer $IAM_TOKEN" \
             -d '{
                   "cluster_id": "<идентификатор_кластера>",
                   "host_names": [
                     "<FQDN_хоста>"
                   ]
                 }' \
             mdb.api.cloud.yandex.net:443 \
             yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteHosts
          ```
      
          Где `host_names` — массив с удаляемым хостом.
      
          В одном запросе можно передать только один FQDN хоста. Если нужно удалить несколько хостов, выполните запрос для каждого хоста.
      
      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Дождитесь, когда кластер перейдет в состояние **Alive**. В консоли управления Перейдите в сервис **Managed Service for&nbsp;ClickHouse**. Состояние кластера отображается в столбце **Доступность**.

## Перенести хосты ZooKeeper {#zookeeper-hosts}

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите хосты.
1. Добавьте хост в кластер:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
      1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
      1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**.
      1. Нажмите кнопку **Создать хост ZooKeeper**.
      1. Укажите новую подсеть и зону доступности, куда переносятся хосты.
      1. Нажмите **Сохранить**.

   - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc managed-clickhouse host add \
         --cluster-name <имя_кластера> \
         --host type=zookeeper,`
               `zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_новой_подсети>,`
               `assign-public-ip=<разрешить_публичный_доступ_к_хосту>
      ```

      Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters). В параметре `zone-id` укажите зону, куда вы переносите хосты.

   
   - Terraform {#tf}

      1. В конфигурационном файле Terraform с планом инфраструктуры в блок `hosts` добавьте новый хост ZooKeeper:

         ```hcl
         resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
           ...
           hosts = {
             ...
             <имя_хоста> = {
               type      = "ZOOKEEPER"
               zone      = "<зона_доступности>"
               subnet_id = "<идентификатор_новой_подсети>"
             }
           }
         }
         ```

         В параметре `zone` укажите зону, куда вы переносите хосты.

      1. Проверьте корректность настроек.

         1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
         1. Выполните команду:
         
            ```bash
            terraform validate
            ```
         
            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Подтвердите изменение ресурсов.

         1. Выполните команду для просмотра планируемых изменений:
         
            ```bash
            terraform plan
            ```
         
            Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
         
         1. Если вас устраивают планируемые изменения, внесите их:
            1. Выполните команду:
         
               ```bash
               terraform apply
               ```
         
            1. Подтвердите изменение ресурсов.
            1. Дождитесь завершения операции.


   - REST API {#api}

      1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

         ```bash
         export IAM_TOKEN="<IAM-токен>"
         ```

      1. Воспользуйтесь методом [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

         ```bash
         curl \
             --request POST \
             --header "Authorization: Bearer $IAM_TOKEN" \
             --header "Content-Type: application/json" \
             --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
             --data '{
                       "hostSpecs": [
                         {
                           "type": "ZOOKEEPER",
                           "zoneId": "<зона_доступности>",
                           "subnetId": "<идентификатор_подсети>",
                           "assignPublicIp": <разрешить_публичный_доступ_к_хосту>
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

         ```bash
         export IAM_TOKEN="<IAM-токен>"
         ```

      1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
         
         ```bash
         cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
         ```
         
         Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
      1. Воспользуйтесь вызовом [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                             "assign_public_ip": <разрешить_публичный_доступ_к_хосту>
                         }
                 }' \
             mdb.api.cloud.yandex.net:443 \
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

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
      1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
      1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
      1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста, выберите пункт **Удалить** и подтвердите удаление.

   - CLI {#cli}

      Выполните команду для каждого хоста:

      ```bash
      yc managed-clickhouse host delete <FQDN_хоста> --cluster-name <имя_кластера>
      ```

   
   - Terraform {#tf}

      1. В конфигурационном файле Terraform с планом инфраструктуры удалите из блока `hosts` хост ZooKeeper с первоначальной зоной доступности.
      1. Проверьте корректность настроек.

         1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
         1. Выполните команду:
         
            ```bash
            terraform validate
            ```
         
            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Введите слово `yes` и нажмите **Enter**.

         1. Выполните команду для просмотра планируемых изменений:
         
            ```bash
            terraform plan
            ```
         
            Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
         
         1. Если вас устраивают планируемые изменения, внесите их:
            1. Выполните команду:
         
               ```bash
               terraform apply
               ```
         
            1. Подтвердите изменение ресурсов.
            1. Дождитесь завершения операции.

   
   - REST API {#api}

      1. Воспользуйтесь методом [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):
      
          ```bash
          curl \
             --request POST \
             --header "Authorization: Bearer $IAM_TOKEN" \
             --header "Content-Type: application/json" \
             --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
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

      1. Воспользуйтесь вызовом [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
      
          ```bash
          grpcurl \
             -format json \
             -import-path ~/cloudapi/ \
             -import-path ~/cloudapi/third_party/googleapis/ \
             -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
             -rpc-header "Authorization: Bearer $IAM_TOKEN" \
             -d '{
                   "cluster_id": "<идентификатор_кластера>",
                   "host_names": [
                     "<FQDN_хоста>"
                   ]
                 }' \
             mdb.api.cloud.yandex.net:443 \
             yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteHosts
          ```
      
          Где `host_names` — массив с удаляемым хостом.
      
          В одном запросе можно передать только один FQDN хоста. Если нужно удалить несколько хостов, выполните запрос для каждого хоста.
      
      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Дождитесь, когда кластер перейдет в состояние **Alive**. В консоли управления Перейдите в сервис **Managed Service for&nbsp;ClickHouse**. Состояние кластера отображается в столбце **Доступность**.

## Особенности миграции в сервисе Yandex Data Transfer {#data-transfer}

Если кластер выступает в роли [эндпоинта](../../data-transfer/concepts/index.md#endpoint) при передаче данных с помощью сервиса Data Transfer и используется [тип трансфера](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) **Репликация** или **Копирование и репликация**, перезапустите трансфер после миграции кластера. Так трансфер получит сведения о новой топологии кластера.

Трансферы типа **Копирование** перезапускать не нужно, так как во время их активации информация о новой топологии передается автоматически.

Чтобы перезапустить трансфер, выберите один из двух способов:

* [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус **Остановлен**. Затем [активируйте](../../data-transfer/operations/transfer.md#activate) трансфер и дождитесь его перехода в статус **Реплицируется**.
* Измените какую-либо [настройку трансфера](../../data-transfer/operations/transfer.md#update) или [эндпоинта](../../data-transfer/operations/endpoint/index.md#update).

Подробнее читайте в разделе [Миграция эндпоинтов и трансфера Data Transfer в другую зону доступности](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._