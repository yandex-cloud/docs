# Техническое обслуживание кластера Yandex MPP Analytics for PostgreSQL

Вы можете управлять [техническим обслуживанием](../concepts/maintenance.md) кластера Yandex MPP Analytics for PostgreSQL.

## Получить список обслуживаний {#list-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.
  1. (Опционально) Выберите статус обслуживания над списком обслуживаний.

{% endlist %}

## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.
  1. Выберите нужное обслуживание. Откроется страница обслуживания.
  1. Нажмите ссылку **Логи задания**.

{% endlist %}

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.
  1. В строке обслуживания со статусом **Запланировано** нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **Перенести**.
  1. Выберите тип переноса запланированного обслуживания:
    
      * **На следующее окно** — перенос на следующее окно обслуживания.
      * **Выбрать дату (UTC)** — перенос на конкретную дату и интервал времени по UTC.

        Для этого переноса выберите дату и интервал времени по UTC.

        Обслуживание можно перенести не более чем на две недели от первоначально запланированной даты.
  
  1. Нажмите кнопку **Перенести**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы перенести запланированное обслуживание:
    
  1. Посмотрите описание команды CLI для изменения времени запланированного обслуживания:
    
      ```bash
      yc managed-greenplum cluster reschedule-maintenance --help
      ```
  
  1. Перенесите обслуживание:
    
      ```bash
      yc managed-greenplum cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
        --reschedule-type <тип_переноса>
      ```
    
      Где `--reschedule-type` — тип переноса:
    
      * `next-available-window` — ближайшее доступное окно обслуживания.
      * `specific-time` — конкретная дата и время по UTC.
        
        Для этого значения дополнительно передайте параметр `--delayed-until` — временная метка в одном из следующих форматов:
    
        * [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt);
        * ЧЧ:ММ:СС;
        * относительное время, на которое нужно перенести обслуживание.
    
        > Примеры: `2006-01-02T15:04:05Z`, `15:04:05`, `2h`, `3h30m ago`.

        Обслуживание можно перенести не более чем на две недели от первоначально запланированной даты.
    
      Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}
  
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
        --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
        --data '{
                 "rescheduleType": "<тип_переноса>"
               }'
      ```

      Где `rescheduleType` — тип переноса:
    
      * `NEXT_AVAILABLE_WINDOW` — ближайшее доступное окно обслуживания.
      * `SPECIFIC_TIME` — конкретная дата и время по UTC.
        
        Для этого значения дополнительно передайте параметр `delayedUntil` — временная метка в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt), например:

        > `2006-01-02T15:04:05Z`
    
        Обслуживание можно перенести не более чем на две недели от первоначально запланированной даты.
    
      Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

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

  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
             "cluster_id": "<идентификатор_кластера>",
             "reschedule_type": "<тип_переноса>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.greenplum.v1.ClusterService.RescheduleMaintenance
      ```

      Где `reschedule_type` — тип переноса:
    
      * `NEXT_AVAILABLE_WINDOW` — ближайшее доступное окно обслуживания.
      * `SPECIFIC_TIME` — конкретная дата и время по UTC.
        
        Для этого значения дополнительно передайте параметр `delayed_until` — временная метка в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt), например:

        > `2006-01-02T15:04:05Z`

        Обслуживание можно перенести не более чем на две недели от первоначально запланированной даты.
    
      Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

{% endlist %}

## Провести запланированное обслуживание немедленно {#exec-planned-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.
  1. В строке нужного обслуживания нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../_assets/console-icons/triangle-right.svg) **Провести сейчас**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы провести запланированное обслуживание немедленно:
    
  1. Посмотрите описание команды CLI для изменения времени запланированного обслуживания:
    
      ```bash
      yc managed-greenplum cluster reschedule-maintenance --help
      ```
  
  1. Проведите запланированное обслуживание немедленно:
    
      ```bash
      yc managed-greenplum cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
        --reschedule-type immediate
      ```
    
      Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}
  
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
        --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
        --data '{
                 "rescheduleType": "IMMEDIATE"
               }'
      ```
    
      Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

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

  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
             "cluster_id": "<идентификатор_кластера>",
             "reschedule_type": "IMMEDIATE"
           }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.greenplum.v1.ClusterService.RescheduleMaintenance
      ```
    
      Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить окно обслуживания {#set-maintenance-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **Обслуживание**.
  1. В правом верхнем углу страницы нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **Настроить окно обслуживания**.
  1. Выберите окно обслуживания:
    
      * **произвольное** — обслуживание проводится в любое время.
      * **по расписанию** — обслуживание проводится по расписанию, в выбранный день недели и интервал времени по UTC.

        Для этого типа обслуживания выберите начало окна обслуживания: день недели и интервал времени по UTC.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы настроить окно технического обслуживания:
    
  1. Посмотрите описание команды CLI для изменения настроек кластера:
    
      ```bash
      yc managed-greenplum cluster update --help
      ```
  
  1. Настройте окно технического обслуживания:
    
      ```bash
      yc managed-greenplum cluster update <имя_или_идентификатор_кластера> \
        --maintenance-window type=<тип_технического_обслуживания>,`
                            `day=<день_недели>,`
                            `hour=<час_дня>
      ```
    
      Где `type` — тип технического обслуживания:

      * `anytime` (по умолчанию) — в любое время.
      * `weekly` — по расписанию. Для этого значения дополнительно укажите:
          * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
          * `hour` — час дня по UTC: от `1` до `24`.
    
      Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера Greenplum® см. в [документации провайдера Terraform](../../terraform/resources/mdb_greenplum_cluster.md).

  1. Чтобы настроить [окно технического обслуживания](../concepts/maintenance.md#maintenance-window), добавьте к описанию кластера блок `maintenance_window`:
  
      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<локальное_имя_кластера>" {
        ...
        maintenance_window {
          type = "<тип_технического_обслуживания>"
        }
        ...
      }
      ```

      Где `type` — тип технического обслуживания:

      * `ANYTIME` (по умолчанию) — в любое время.
      * `WEEKLY` — по расписанию. Для этого значения дополнительно укажите:
        
        * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
        * `hour` — час дня по UTC: от `1` до `24`.

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
      
      Провайдер Terraform ограничивает время на выполнение всех операций с кластером Yandex MPP Analytics for PostgreSQL 120 минутами.
      
      Операции, длящиеся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию кластера блок `timeouts`, например:
      
      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя кластера>" {
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
        --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
        --data '{
                 "updateMask": "maintenanceWindow",
                 "maintenanceWindow": {
                   "weeklyMaintenanceWindow": {
                     "day": "<день_недели>",
                     "hour": "<час_дня>"
                   }
                 }
               }'
      ```
    
      Где:

      * `updateMask` — перечень изменяемых параметров в строку через запятую.

        В этом примере передается только один параметр `maintenanceWindow`.

        {% note warning %}

        При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

        {% endnote %}

      * `maintenanceWindow` — настройки [окна технического обслуживания](../concepts/maintenance.md#maintenance-window). Передайте один из параметров:

        * `anytime` (по умолчанию) — разрешает проводить техническое обслуживание в любое время.
          
          Параметр передается как пустой объект: `"anytime": {}`.
        
        * `weeklyMaintenanceWindow` — техническое обслуживание проводится раз в неделю, в указанное время:

          * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
          * `hour` — час дня по UTC от `1` до `24`.

      Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
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
                 "hour": "<час_дня>"
               }
             }
           }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.greenplum.v1.ClusterService.Update
      ```
    
      Где:

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

        При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

        {% endnote %}

      * `maintenance_window` — настройки [окна технического обслуживания](../concepts/maintenance.md#maintenance-window). Передайте один из параметров:

        * `anytime` (по умолчанию) — разрешает проводить техническое обслуживание в любое время.
          
          Параметр передается как пустой объект: `"anytime": {}`.

        * `weekly_maintenance_window` — техническое обслуживание проводится раз в неделю, в указанное время:

          * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
          * `hour` — час дня по UTC от `1` до `24`.

      Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}