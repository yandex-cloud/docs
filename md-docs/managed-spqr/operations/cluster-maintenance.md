# Техническое обслуживание кластера {{ SPQR }}

Вы можете управлять техническим обслуживанием кластера {{ mspqr-name }}, в том числе:

* [получить список обслуживаний](#list-maintenance);
* [получить логи технического обслуживания кластера](#maintenance-logs);
* [перенести запланированное обслуживание](#postpone-planned-maintenance);
* [провести запланированное обслуживание немедленно](#exec-planned-maintenance);
* [настроить окно обслуживания](#set-maintenance-window).

## Получить список обслуживаний {#list-maintenance}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

Чтобы просмотреть обслуживания с определенным статусом, нажмите кнопку **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** над списком обслуживаний и в выпадающем меню выберите нужный статус. Вы также можете найти обслуживание по его идентификатору или имени задания – используйте поле над списком обслуживаний.

Чтобы получить информацию о влиянии обслуживания на доступность кластера, нажмите на идентификатор нужного обслуживания. В блоке **{{ ui-key.yacloud.mdb.maintenance.title_task-details }}** отображается информация о влиянии обслуживания на пользователей.

## Получить логи кластера, относящиеся к техническому обслуживанию {#maintenance-logs}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на идентификатор нужного обслуживания.
  1. Нажмите ссылку **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживания, имеющие статус **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}**, назначены на определенную дату и время, которые указаны в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**. При необходимости их можно перенести на новую дату и время.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы перенести обслуживание на новую дату и время:

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке обслуживания со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}**.
  1. В выпадающем меню выберите ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. В открывшемся окне:
      * Чтобы перенести обслуживание вперед на следующее окно обслуживания, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** и затем **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**. Такой вариант доступен, если в кластере [настроено окно обслуживания](#set-maintenance-window) по расписанию.
      * Чтобы перенести обслуживание вперед или назад на определенную дату и время по UTC, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, затем выберите новую дату и интервал времени и нажмите **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы перенести обслуживание на новую дату и время:

  1. Посмотрите описание команды CLI для переноса обслуживания:

      ```bash
      yc managed-sharded-postgresql cluster reschedule-maintenance --help
      ```

  1. Чтобы перенести обслуживание на ближайшее окно, выполните команду, указав тип переноса `next-available-window` (доступен только в кластере с [настроенным окном обслуживания](#set-maintenance-window) по расписанию). Чтобы перенести на определенную дату и время, укажите тип переноса `specific-time`:

      ```bash
      yc managed-sharded-postgresql cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
         --reschedule-type <тип_переноса> \
         --delayed-until <временная_метка>
      ```

      Временная метка должна иметь один из следующих форматов:
        * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt)
        * ЧЧ:ММ:СС
        * количество часов и минут, на которые нужно сдвинуть обслуживание.

      Например: `2006-01-02T15:04:05Z`, `15:04:05`, `2h` или `3h30m ago`. При выборе типа переноса `next-available-window` параметр `--delayed-until` указывать не нужно.

- REST API {#api}

  Чтобы перенести обслуживание на новую дату и время:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
        --data '{
                    "rescheduleType": <тип_переноса>,
                    "delayedUntil": <временная_метка>
                }'
        ```

        Где `rescheduleType` — тип переноса, принимает одно из двух значений:

          * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее окно (доступно только в кластере с [настроенным окном обслуживания](#set-maintenance-window) по расписанию);
          * `SPECIFIC_TIME` — перенести обслуживание на определенную дату и время.

        Временная метка должна иметь формат [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), например: `2006-01-02T15:04:05Z`. При выборе типа переноса `NEXT_AVAILABLE_WINDOW` параметр `delayedUntil` указывать не нужно.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "reschedule_type": <тип_переноса>,
             "delayed_until": <временная_метка>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.RescheduleMaintenance
     ```

     Где `reschedule_type` — тип переноса, принимает одно из двух значений:

       * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее окно (доступно только в кластере с [настроенным окном обслуживания](#set-maintenance-window) по расписанию);
       * `SPECIFIC_TIME` — перенести обслуживание на определенную дату и время.

     Временная метка должна иметь формат [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), например: `2006-01-02T15:04:05Z`. При выборе типа переноса `NEXT_AVAILABLE_WINDOW` параметр `delayed_until` указывать не нужно.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.mdb.spqr.v1.Cluster).

{% endlist %}

## Провести запланированное обслуживание немедленно {#exec-planned-maintenance}

Обслуживание со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** при необходимости можно провести немедленно, не дожидаясь момента, указанного в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы провести запланированное обслуживание кластера немедленно:

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке обслуживания.
  1. В выпадающем меню выберите ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы провести запланированное обслуживание кластера немедленно:

  1. Посмотрите описание команды CLI для переноса обслуживания:

      ```bash
      yc managed-sharded-postgresql cluster reschedule-maintenance --help
      ```

  1. Выполните команду, указав тип переноса `immediate`:

      ```bash
      yc managed-sharded-postgresql cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
         --reschedule-type immediate
      ```

- REST API {#api}

  Чтобы провести запланированное обслуживание кластера немедленно:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
        --data '{
                    "rescheduleType": "IMMEDIATE"
                }'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "reschedule_type": "IMMEDIATE"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.RescheduleMaintenance
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.mdb.spqr.v1.Cluster).

{% endlist %}

## Настроить окно обслуживания {#set-maintenance-window}

По умолчанию техническое обслуживание может быть запланировано на любое время. Вы можете выбрать определенный день недели и час, на который будет планироваться техническое обслуживание. Например, можно указать время, когда кластер наименее загружен.

{% note warning %}

При выборе нового интервала обслуживания будут автоматически отменены запланированные обслуживания, которые не совпадают с новым интервалом.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. В открывшемся окне:
     * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию).
     * Чтобы разрешить проведение технического обслуживания раз в неделю в определенное время суток, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** и укажите день недели и час по UTC.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения окна обслуживания:

      ```bash
      yc managed-sharded-postgresql cluster update --help
      ```

  1. Выполните команду:

      ```bash
      yc managed-sharded-postgresql cluster update <имя_или_идентификатор_кластера> \
         --maintenance-window type=<тип_технического_обслуживания>,`
                             `day=<день_недели>,`
                             `hour=<час_дня>
      ```

      Где `type` — тип технического обслуживания:

      * `anytime` (по умолчанию) — в любое время.
      * `weekly` — по расписанию. Для этого значения дополнительно укажите:
          * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
          * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
      
            > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mspqr-name }} см. в [документации провайдера {{ TF }}](../../terraform/resources/mdb_sharded_postgresql_cluster.md).

  1. Чтобы настроить время технического обслуживания (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
     
     ```hcl
     resource "yandex_mdb_sharded_postgresql_cluster" "<имя_кластера>" {
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
     * `hour` — порядковый номер часового интервала по UTC для типа `WEEKLY`: от `1` до `24`.
     
       > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "maintenanceWindow",
                 "maintenanceWindow": {
                   "weeklyMaintenanceWindow": {
                     "day": "<день_недели>",
                     "hour": "<час>"
                   }
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `maintenanceWindow` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:

       * `anytime` — техническое обслуживание может быть запланировано на любое время.
       * `weeklyMaintenanceWindow` — техническое обслуживание может быть запланировано только на выбранный день недели и час:

         * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
         * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

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
  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
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
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `maintenance_window` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:

       * `anytime` — техническое обслуживание может быть запланировано на любое время.
       * `weekly_maintenance_window` — техническое обслуживание может быть запланировано только на выбранный день недели и час:

         * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
         * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.spqr.v1.Cluster).

{% endlist %}