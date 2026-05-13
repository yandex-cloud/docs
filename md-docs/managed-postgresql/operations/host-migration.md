# Миграция хостов кластера PostgreSQL в другую зону доступности


Хосты кластера Managed Service for PostgreSQL располагаются в [зонах доступности](../../overview/concepts/geo-scope.md) Yandex Cloud. Чтобы перенести хосты из одной зоны в другую:

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите хосты.
1. Добавьте хост в кластер:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
      1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Создать хост**.
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
      yc managed-postgresql host add \
         --cluster-name <имя_кластера> \
         --host zone-id=<зона_доступности>,`
               `subnet-id=<ID_новой_подсети>,`
               `assign-public-ip=<разрешить_публичный_доступ_к_хосту>
      ```

      Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters). В параметре `zone-id` укажите зону, куда вы переносите хосты.

   - Terraform {#tf}

      1. В конфигурационный файл Terraform с планом инфраструктуры добавьте манифест хоста:

         ```hcl
         resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
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
            --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
            --data '{
                       "hostSpecs": [
                          {
                             "zoneId": "<зона_доступности>",
                             "subnetId": "<идентификатор_подсети>",
                             "assignPublicIp": <разрешить_публичный_доступ_к_хосту>
                          }
                       ]
                    }'
         ```

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
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<идентификатор_кластера>",
                   "host_specs": [
                      {
                         "zone_id": "<зона_доступности>",
                         "subnet_id": "<идентификатор_подсети>",
                         "assign_public_ip": <разрешить_публичный_доступ_к_хосту>
                      }
                   ]
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.postgresql.v1.ClusterService.AddHosts
         ```

         Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Чтобы успешно выполнять подключение к базе данных после миграции, укажите FQDN нового хоста в вашем бэкенде или клиенте (например, в коде или графической IDE). Удалите FQDN прежнего хоста в первоначальной зоне.

   Чтобы узнать FQDN, получите список хостов в кластере:

   ```bash
   yc managed-postgresql host list --cluster-name <имя_кластера>
   ```

   FQDN указан в выводе команды, в столбце `NAME`. Также вы можете использовать [особый FQDN](connect/fqdn.md#special-fqdns) для подключения.

1. Удалите хосты в первоначальной зоне доступности:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
      1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
      1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста, выберите пункт **Удалить** и подтвердите удаление.

   - CLI {#cli}

      Выполните команду для каждого хоста:

      ```bash
      yc managed-postgresql host delete <FQDN_хоста> --cluster-name <имя_кластера>
      ```

   - Terraform {#tf}

      1. В конфигурационном файле Terraform с планом инфраструктуры удалите из описания кластера блоки `host` с первоначальной зоной доступности.
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
            --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
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
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<идентификатор_кластера>",
                   "host_names": [
                      "<FQDN_хоста>"
                   ]
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.postgresql.v1.ClusterService.DeleteHosts
         ```

         Где `host_names` — массив с удаляемым хостом.

         В одном запросе можно передать только один FQDN хоста. Если нужно удалить несколько хостов, выполните запрос для каждого хоста.

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Дождитесь, когда кластер перейдет в состояние **Alive**. В консоли управления [перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**. Состояние кластера отображается в столбце **Доступность**.

{% note info %}

Для кластеров, хосты которых располагаются в [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`, недоступно:

- использование платформы Intel Broadwell;
- хранилище на локальных SSD-дисках при использовании платформы Intel Cascade Lake.

{% endnote %}

## Особенности миграции в сервисе Yandex Data Transfer {#data-transfer}

Если кластер выступает в роли [эндпоинта](../../data-transfer/concepts/index.md#endpoint) при передаче данных с помощью сервиса Data Transfer и используется [тип трансфера](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) **Репликация** или **Копирование и репликация**, перезапустите трансфер после миграции кластера. Так трансфер получит сведения о новой топологии кластера.

Трансферы типа **Копирование** перезапускать не нужно, так как во время их активации информация о новой топологии передается автоматически.

Чтобы перезапустить трансфер, выберите один из двух способов:

* [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус **Остановлен**. Затем [активируйте](../../data-transfer/operations/transfer.md#activate) трансфер и дождитесь его перехода в статус **Реплицируется**.
* Измените какую-либо [настройку трансфера](../../data-transfer/operations/transfer.md#update) или [эндпоинта](../../data-transfer/operations/endpoint/index.md#update).

Подробнее см. в разделе [Миграция эндпоинтов и трансфера Data Transfer в другую зону доступности](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).

{% note info %}

[Включите](extensions/cluster-extensions.md) расширение `pg_tm_aux` для кластера PostgreSQL. Это позволит продолжить репликацию при смене хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее см. в разделе [Решение проблем](../../data-transfer/troubleshooting/index.md#master-change).

{% endnote %}