[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for MySQL®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Техническое обслуживание

# Техническое обслуживание кластера Yandex Managed Service for MySQL®

Вы можете управлять [техническим обслуживанием](../concepts/maintenance.md) кластера Managed Service for MySQL®.


## Получить список обслуживаний {#list-maintenance}

Для сервиса Managed Service for MySQL® можно получить список обслуживаний в:

* [облаке](#list-maintenance-cloud)
* [каталоге](#list-maintenance-folder)
* [кластере](#list-maintenance-cluster)


### Получить список обслуживаний в облаке {#list-maintenance-cloud}

{% list tabs group=instructions %}

- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Maintenance.List](../api-ref/Maintenance/list.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
  
      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/maintenances?cloudId=<идентификатор_облака>'
      ```
    
      
      О том, как получить идентификатор облака, в [соответствующей инструкции](../../resource-manager/operations/cloud/get-id.md).

  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

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

  1. Воспользуйтесь вызовом [MaintenanceService.List](../api-ref/grpc/Maintenance/list.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cloud_id": "<идентификатор_облака>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.List
      ```

      
      О том, как получить идентификатор облака, в [соответствующей инструкции](../../resource-manager/operations/cloud/get-id.md).

  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}


### Получить список обслуживаний в каталоге {#list-maintenance-folder}

{% list tabs group=instructions %}

- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Maintenance.List](../api-ref/Maintenance/list.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
  
      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/maintenances?folderId=<идентификатор_каталога>'
      ```
    
      
      Идентификатор каталога можно получить со [списком каталогов](../../resource-manager/operations/folder/get-id.md) в облаке.
      
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

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

  1. Воспользуйтесь вызовом [MaintenanceService.List](../api-ref/grpc/Maintenance/list.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "folder_id": "<идентификатор_каталога>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.List
      ```

      
      Идентификатор каталога можно получить со [списком каталогов](../../resource-manager/operations/folder/get-id.md) в облаке.
      
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}


### Получить список обслуживаний в кластере {#list-maintenance-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите](https://console.yandex.cloud/link/managed-mysql) в сервис **Managed Service for&nbsp;MySQL**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.

      Чтобы просмотреть обслуживания с определенным статусом, выберите статус в поле **Статус** над списком обслуживаний. Вы также можете найти обслуживание по его идентификатору или имени задания с помощью поля поиска над списком обслуживаний.

      Чтобы получить информацию о [влиянии обслуживания на доступность кластера](../concepts/maintenance.md#impact-on-cluster), нажмите на идентификатор нужного обслуживания. В блоке **Подробнее о задании** отображается информация о влиянии обслуживания на пользователей.

- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Maintenance.List](../api-ref/Maintenance/list.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
  
      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/maintenances?resourceId=<идентификатор_кластера>'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

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

  1. Воспользуйтесь вызовом [MaintenanceService.List](../api-ref/grpc/Maintenance/list.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.List
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}


## Получить информацию об обслуживании {#get-maintenance}

{% list tabs group=instructions %}

- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Maintenance.Get](../api-ref/Maintenance/get.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
  
      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/maintenances/<идентификатор_обслуживания>'
      ```
    
      Идентификатор обслуживания можно получить со [списком обслуживаний](#list-maintenance).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance).

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

  1. Воспользуйтесь вызовом [MaintenanceService.Get](../api-ref/grpc/Maintenance/get.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "maintenance_id": "<идентификатор_обслуживания>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.Get
      ```

      Идентификатор обслуживания можно получить со [списком обслуживаний](#list-maintenance).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance).

{% endlist %}


## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите](https://console.yandex.cloud/link/managed-mysql) в сервис **Managed Service for&nbsp;MySQL**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.
  1. Выберите обслуживание.
  1. Нажмите ссылку **Логи задания**.

{% endlist %}


## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживание в статусе **Запланировано** назначено на определенную дату и время, которые указаны в столбце **Дата начала**. При необходимости такое обслуживание можно перенести на новую дату и время, но не более чем на две недели от первоначально запланированной даты и времени.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы перенести запланированное обслуживание:

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите](https://console.yandex.cloud/link/managed-mysql) в сервис **Managed Service for&nbsp;MySQL**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.
  1. В строке обслуживания со статусом **Запланировано** нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **Перенести**.
  1. Выберите тип переноса:
    
      * **На следующее окно** — перенести обслуживание на ближайшее доступное окно.
      * **Выбрать дату (UTC)** — перенести обслуживание на новую дату и время.

        В этом случае выберите дату и интервал времени по UTC.

  1. Нажмите кнопку **Перенести**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы перенести запланированное обслуживание:

  1. Посмотрите описание команды CLI для переноса обслуживания:

      ```bash
      yc managed-mysql cluster reschedule-maintenance --help
      ```

  1. Перенесите обслуживание, выполнив команду:

      ```bash
      yc managed-mysql cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
         --reschedule-type <тип_переноса> \
         --delayed-until <временная_метка>
      ```
      Где:
      
      * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
      * `--reschedule-type` — тип переноса. Возможные значения:
        
        * `next-available-window` — перенести обслуживание на ближайшее доступное окно.
        * `specific-time` — перенести обслуживание на новую дату и время.
      
      * `--delayed-until` — временная метка для типа переноса `specific-time`.
        
        Временная метка может иметь один из следующих форматов:

        * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt);
        * ЧЧ:ММ:СС;
        * количество часов и минут, на которые нужно перенести обслуживание.

        > Примеры: `2006-01-02T15:04:05Z`, `15:04:05`, `2h`, `3h30m ago`.

- REST API {#api}

  Перенести запланированное обслуживание можно с помощью одного из методов:

  * [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md)
  * [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md)

  Чтобы перенести запланированное обслуживание с помощью метода `Cluster.RescheduleMaintenance`:
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
  

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
        --data '{
                  "rescheduleType": "<тип_переноса>",
                  "delayedUntil": "<временная_метка>"
                }'
      ```

      Где:

      * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
      * `rescheduleType` — тип переноса. Возможные значения:
        
        * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее доступное окно.
        * `SPECIFIC_TIME` — перенести обслуживание на новую дату и время.
      
      * `delayedUntil` — временная метка для типа переноса `SPECIFIC_TIME` в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt).
        
        > Пример: `2006-01-02T15:04:05Z`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

  Чтобы перенести запланированное обслуживание с помощью метода `Maintenance.Reschedule`:
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
      
  1. Воспользуйтесь методом [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
  

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/maintenances/<идентификатор_обслуживания>:reschedule' \
        --data '{
                  "rescheduleType": "<тип_переноса>",
                  "scheduledAt": "<временная_метка>"
                }'
      ```

      Где:

      * `<идентификатор_обслуживания>` — идентификатор обслуживания, который можно получить со [списком обслуживаний](#list-maintenance).
      * `rescheduleType` — тип переноса. Возможные значения:
        
        * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее доступное окно.
        * `SPECIFIC_TIME` — перенести обслуживание на новую дату и время.
      
      * `scheduledAt` — временная метка для типа переноса `SPECIFIC_TIME` в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt).
        
        > Пример: `2006-01-02T15:04:05Z`.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  Перенести запланированное обслуживание можно с помощью одного из вызовов:

  * [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md)
  * [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md)

  Чтобы перенести запланированное обслуживание с помощью вызова `ClusterService.RescheduleMaintenance`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "reschedule_type": "<тип_переноса>",
              "delayed_until": "<временная_метка>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mysql.v1.ClusterService.RescheduleMaintenance
      ```

      Где:

      * `cluster_id` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
      * `reschedule_type` — тип переноса. Возможные значения:
        
        * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее доступное окно.
        * `SPECIFIC_TIME` — перенести обслуживание на новую дату и время.
      
      * `delayed_until` — временная метка для типа переноса `SPECIFIC_TIME` в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt).
        
        > Пример: `2006-01-02T15:04:05Z`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

  Чтобы перенести запланированное обслуживание с помощью вызова `MaintenanceService.Reschedule`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Воспользуйтесь вызовом [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "maintenance_id": "<идентификатор_обслуживания>",
              "reschedule_type": "<тип_переноса>",
              "scheduled_at": "<временная_метка>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.Reschedule
      ```

      Где:

      * `maintenance_id` — идентификатор обслуживания, который можно получить со [списком обслуживаний](#list-maintenance).
      * `reschedule_type` — тип переноса. Возможные значения:
        
        * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее доступное окно.
        * `SPECIFIC_TIME` — перенести обслуживание на новую дату и время.
      
      * `scheduled_at` — временная метка для типа переноса `SPECIFIC_TIME` в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt).
        
        > Пример: `2006-01-02T15:04:05Z`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

{% endlist %}


## Провести запланированное обслуживание немедленно {#exec-planned-maintenance}

Обслуживание со статусом **Запланировано** при необходимости можно провести немедленно, не дожидаясь момента, указанного в столбце **Дата начала**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы провести запланированное обслуживание кластера немедленно:

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите](https://console.yandex.cloud/link/managed-mysql) в сервис **Managed Service for&nbsp;MySQL**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.
  1. В строке нужного обслуживания нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../_assets/console-icons/triangle-right.svg) **Провести сейчас**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы провести запланированное обслуживание кластера немедленно:

  1. Посмотрите описание команды CLI для проведения обслуживания:

      ```bash
      yc managed-mysql cluster reschedule-maintenance --help
      ```

  1. Проведите запланированное обслуживание, выполнив команду:

      ```bash
      yc managed-mysql cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
         --reschedule-type immediate
      ```

      Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
    
- REST API {#api}

  Провести запланированное обслуживание немедленно можно с помощью одного из методов:

  * [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md)
  * [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md)

  Чтобы провести запланированное обслуживание немедленно с помощью метода `Cluster.RescheduleMaintenance`:
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
        --data '{
                  "rescheduleType": "IMMEDIATE"
                }'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).
  
  Чтобы провести запланированное обслуживание немедленно с помощью метода `Maintenance.Reschedule`:
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
      
  1. Воспользуйтесь методом [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
  

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/maintenances/<идентификатор_обслуживания>:reschedule' \
        --data '{
                  "rescheduleType": "IMMEDIATE"
                }'
      ```

      Идентификатор обслуживания можно получить со [списком обслуживаний](#list-maintenance).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  Провести запланированное обслуживание немедленно можно с помощью одного из вызовов:

  * [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md)
  * [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md)

  Чтобы провести запланированное обслуживание немедленно с помощью вызова `ClusterService.RescheduleMaintenance`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "reschedule_type": "IMMEDIATE"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mysql.v1.ClusterService.RescheduleMaintenance
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

  Чтобы провести запланированное обслуживание немедленно с помощью вызова `MaintenanceService.Reschedule`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Воспользуйтесь вызовом [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "maintenance_id": "<идентификатор_обслуживания>",
              "reschedule_type": "IMMEDIATE"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.Reschedule
      ```

      Идентификатор обслуживания можно получить со [списком обслуживаний](#list-maintenance).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

{% endlist %}


## Настроить окно обслуживания {#set-maintenance-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите](https://console.yandex.cloud/link/managed-mysql) в сервис **Managed Service for&nbsp;MySQL**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.
  1. В правом верхнем углу страницы нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **Настроить окно обслуживания**.
  1. Настройте время [технического обслуживания](../concepts/maintenance.md) кластера:

      * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **В любое время** (по умолчанию).
      * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **По расписанию** и укажите день недели и интервал времени по UTC. Например, можно выбрать время, когда кластер наименее загружен.
      
      Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать обновление СУБД, применение патчей и т. д.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы настроить [окно обслуживания](../concepts/maintenance.md#maintenance-window):
    
  1. Посмотрите описание команды CLI для изменения настроек кластера:
    
      ```bash
      yc managed-mysql cluster update --help
      ```
  
  1. Настройте окно обслуживания, выполнив команду:
    
      ```bash
      yc managed-mysql cluster update <имя_или_идентификатор_кластера> \
         --maintenance-window type=<тип_технического_обслуживания>,`
                             `day=<день_недели>,`
                             `hour=<порядковый_номер_часового_интервала>
      ```
    
      Где:
      
      * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
      * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        * `anytime` (по умолчанию) — в любое время.
        * `weekly` — по расписанию. Для этого значения дополнительно укажите:
        
            * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
            * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
        
              > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.


- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, в разделе [Создание кластера MySQL®](cluster-create.md).

  1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
     
     ```hcl
     resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
       ...
       maintenance_window {
         type = "<тип_технического_обслуживания>"
         day  = "<день_недели>"
         hour = <порядковый_номер_часового_интервала>
       }
       ...
     }
     ```
     
     Где: 
     
     * `type` — тип технического обслуживания. Принимает значения:
     
         * `ANYTIME` (по умолчанию) — в любое время.
         * `WEEKLY` — по расписанию.
     
     * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
     * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
     
       > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.
      
      Подробнее о ресурсе `yandex_mdb_mysql_cluster` в [документации провайдера Terraform](../../terraform/resources/mdb_mysql_cluster.md).

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

      {% note warning "Ограничения по времени" %}
      
      Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for MySQL®:
      
      * создание кластера, в том числе путем восстановления из резервной копии, — 15 минут;
      * изменение кластера, в том числе обновление версии MySQL®, — 60 минут;
      * удаление кластера — 15 минут.
      
      Операции, длящиеся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию кластера блок `timeouts`, например:
      
      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        timeouts {
          create = "1h30m" # Полтора часа
          update = "2h"    # 2 часа
          delete = "30m"   # 30 минут
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}


- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
  
      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/<идентификатор_кластера>' \
        --data '{
                  "updateMask": "maintenanceWindow",
                  "maintenanceWindow": {
                    "weeklyMaintenanceWindow": {
                      "day": "<день_недели>",
                      "hour": "<порядковый_номер_часового_интервала>"
                    }
                  }
                }'
      ```
    
      Где:
      
      * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `updateMask` — перечень изменяемых параметров в строку через запятую.

        В этом примере передается только один параметр `maintenanceWindow`.

        {% note warning %}
        
        Все настройки изменяемого объекта в кластере, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

        {% endnote %}

      * `maintenanceWindow` — настройки окна [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из параметров:
      
        * `anytime` (по умолчанию) — техническое обслуживание проводится в любое время.
        * `weeklyMaintenanceWindow` — техническое обслуживание проводится по расписанию:
      
          * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
          * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
      
            > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "update_mask": {
                "paths": [
                  "maintenance_window"
                ]
              },
              "maintenance_window": {
                "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<порядковый_номер_часового_интервала>"
                }
              }
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```
    
      Где:

      * `cluster_id` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        {% cut "Формат перечисления настроек" %}

        ```yaml
        "update_mask": {
          "paths": [
            "<настройка_1>",
            "<настройка_2>",
            ...
            "<настройка_N>"
          ]
        }
        ```

        {% endcut %}

        В этом примере передается только один параметр `maintenance_window`.

        {% note warning %}

        Все настройки изменяемого объекта в кластере, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

        {% endnote %}

      * `maintenance_window` — настройки окна [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из параметров:
      
        * `anytime` (по умолчанию) — техническое обслуживание проводится в любое время.
        * `weekly_maintenance_window` — техническое обслуживание проводится по расписанию:
      
          * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
          * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
      
            > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}