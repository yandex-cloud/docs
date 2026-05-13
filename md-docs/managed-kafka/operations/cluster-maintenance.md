# Техническое обслуживание кластера Apache Kafka®

Вы можете управлять [техническим обслуживанием](../concepts/maintenance.md) кластера Yandex Managed Service for Apache Kafka®.

## Получить список обслуживаний {#list-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Обслуживание**.

    Чтобы просмотреть обслуживания с определенным статусом, нажмите кнопку **Статус** над списком обслуживаний и в выпадающем меню выберите нужный статус. Чтобы найти конкретное обслуживание, введите его идентификатор или имя задания в поле над списком обслуживаний.

{% endlist %}

## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Обслуживание**.
    1. Нажмите на идентификатор нужного обслуживания.
    1. Нажмите ссылку **Логи задания**.

{% endlist %}

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживания в статусе **Запланировано** назначены на дату и время, указанные в столбце **Дата начала**. При необходимости их можно перенести на другую дату и время.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы перенести обслуживание на другую дату и время:

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Обслуживание**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке обслуживания со статусом **Запланировано**.
    1. В выпадающем меню выберите ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **Перенести**.
    1. В открывшемся окне:
        * Чтобы перенести обслуживание вперед на следующее окно обслуживания, нажмите **На следующее окно** и затем **Перенести**.
        * Чтобы перенести обслуживание на конкретную дату и время по UTC, нажмите **Выбрать дату (UTC)**, затем выберите новую дату и время и нажмите **Перенести**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы перенести обслуживание на другую дату и время:

    1. Посмотрите описание команды CLI для переноса обслуживания:

        ```bash
        yc managed-kafka cluster reschedule-maintenance --help
        ```

    1. Выполните команду:

        ```bash
        yc managed-kafka cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
          --reschedule-type <тип_переноса> \
          --delayed-until <временная_метка>
        ```

        Где:

        * `reschedule-type` — тип переноса:

            * `next-available-window` — ближайшее доступное окно;
            * `specific-time` — конкретная дата и время.

        * `delayed-until` — временная метка (не используется с типом переноса `next-available-window`).

            Временная метка должна иметь один из следующих форматов:

            * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt);
            * ЧЧ:ММ:СС;
            * относительное время, на которое нужно перенести обслуживание.

            Примеры: `2006-01-02T15:04:05Z`, `15:04:05`, `2h` или `3h30m ago`.

        Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    Чтобы перенести обслуживание на другую дату и время:

    1. Получите [IAM-токен для аутентификации в API](../api-ref/authentication.md).
    1. Поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.rescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
          --data '{
            "rescheduleType": <тип_переноса>,
            "delayedUntil": <временная_метка>
          }'
        ```

        Где:

        * `rescheduleType` — тип переноса:

            * `NEXT_AVAILABLE_WINDOW` — ближайшее доступное окно.
            * `SPECIFIC_TIME` — конкретная дата и время.

        * `delayedUntil` — временная метка в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt). Например, `2006-01-02T15:04:05Z`.

            Параметр не используется с типом переноса `NEXT_AVAILABLE_WINDOW`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    Чтобы перенести обслуживание на новую дату и время:

    1. Получите [IAM-токен для аутентификации в API](../api-ref/authentication.md).

    1. Поместите токен в переменную среды окружения:

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
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
            "cluster_id": "<идентификатор_кластера>",
            "reschedule_type": <тип_переноса>,
            "delayed_until": <временная_метка>
          }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ClusterService.RescheduleMaintenance
        ```

        Где:

        * `reschedule_type` — тип переноса:

            * `NEXT_AVAILABLE_WINDOW` — ближайшее доступное окно;
            * `SPECIFIC_TIME` — конкретная дата и время.

        * `delayed_until` — временная метка в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt). Например, `2006-01-02T15:04:05Z`.

            Параметр не используется с типом переноса `NEXT_AVAILABLE_WINDOW`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.mdb.kafka.v1.Cluster).

{% endlist %}

## Провести запланированное обслуживание немедленно {#exec-planned-maintenance}

Обслуживания в статусе **Запланировано** можно провести немедленно, не дожидаясь времени, указанного в столбце **Дата начала**.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы провести запланированное обслуживание немедленно:

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Обслуживание**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке обслуживания.
    1. В выпадающем меню выберите ![image](../../_assets/console-icons/triangle-right.svg) **Провести сейчас**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы провести запланированное обслуживание немедленно:

    1. Посмотрите описание команды CLI для переноса обслуживания:

        ```bash
        yc managed-kafka cluster reschedule-maintenance --help
        ```

    1. Выполните команду, указав тип переноса `immediate`:

        ```bash
        yc managed-kafka cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
          --reschedule-type immediate
        ```

        Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    Чтобы провести запланированное обслуживание немедленно:

    1. Получите [IAM-токен для аутентификации в API](../api-ref/authentication.md).
    1. Поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.rescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
          --data '{
            "rescheduleType": "IMMEDIATE"
          }'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    Чтобы провести запланированное обслуживание немедленно:

    1. Получите [IAM-токен для аутентификации в API](../api-ref/authentication.md).
    1. Поместите токен в переменную среды окружения:

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
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
            "cluster_id": "<идентификатор_кластера>",
            "reschedule_type": "IMMEDIATE"
          }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ClusterService.RescheduleMaintenance
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.mdb.kafka.v1.Cluster).

{% endlist %}

## Настроить окно обслуживания {#set-maintenance-window}

По умолчанию техническое обслуживание может выполняться в произвольное время. Чтобы задать конкретное окно, укажите день недели и интервал времени, в которые обслуживание должно выполняться. Например, в период наименьшей нагрузки на кластер.

{% note warning %}

Если запланированное обслуживание не попадает в заданный интервал, оно будет автоматически отменено.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Обслуживание**.
    1. Нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **Настроить окно обслуживания**.
    1. В открывшемся окне:
        * Чтобы разрешить обслуживание в произвольное время, выберите пункт **произвольное** (по умолчанию).
        * Чтобы задать конкретное окно обслуживания, выберите пункт **по расписанию** и укажите день недели и интервал времени по UTC.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды CLI для изменения окна обслуживания:

        ```bash
        yc managed-kafka cluster update --help
        ```

    1. Выполните команду:

        ```bash
        yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
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

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Managed Service for Apache Kafka® в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_cluster.md).

    1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
       
       ```hcl
       resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
         ...
         maintenance_window {
           type = "<тип_технического_обслуживания>"
           day  = "<день_недели>"
           hour = <час_дня>
         }
         ...
       }
       ```
       
       Где:
       
       * `type` — тип технического обслуживания. Принимает значения:
           * `ANYTIME` — в любое время.
           * `WEEKLY` — по расписанию.
       * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
       * `hour` — час дня по UTC для типа `WEEKLY`: от `1` до `24`.

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
        
        Провайдер Terraform ограничивает время на выполнение всех операций с кластером Managed Service for Apache Kafka® 60 минутами.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
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

    1. Получите [IAM-токен для аутентификации в API](../api-ref/authentication.md).
    1. Поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
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

        * `updateMask` — перечень изменяемых параметров одной строкой через запятую.

            В данном случае передается только один параметр.

        * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md), в том числе для выключенных кластеров. Возможные значения:

            * `anytime` — техническое обслуживание проводится в произвольное время;
            * `weeklyMaintenanceWindow` — техническое обслуживание проводится раз в неделю, в указанный день и час:

                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
                * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. Получите [IAM-токен для аутентификации в API](../api-ref/authentication.md).
    1. Поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
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
        
        {% endnote %}

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
            "cluster_id": "<идентификатор_кластера>",
            "update_mask": {
              "paths": ["maintenance_window"]
            },
            "maintenance_window": {
              "weekly_maintenance_window": {
                "day": "<день_недели>",
                "hour": "<час>"
              }
            }
          }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`. 

            В данном случае передается только один параметр.

        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md), в том числе для выключенных кластеров. Возможные значения:

            * `anytime` — техническое обслуживание проводится в произвольное время;
            * `weekly_maintenance_window` — техническое обслуживание проводится раз в неделю, в указанный день и час:

                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
                * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.kafka.v1.Cluster).

{% endlist %}