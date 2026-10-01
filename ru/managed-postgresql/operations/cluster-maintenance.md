---
title: Техническое обслуживание кластера {{ PG }}
description: Следуя данной инструкции, вы сможете просмотреть информацию о планируемых и проведенных технических обслуживаниях кластера {{ PG }}, а также выбрать время для проведения обслуживания.
---

# Техническое обслуживание кластера {{ PG }}

Вы можете управлять [техническим обслуживанием](../concepts/maintenance.md) кластера {{ mpg-full-name }}.

## Получить список обслуживаний {#list-maintenances}

Для сервиса {{ mpg-name }} можно получить список обслуживаний в:

* [облаке](#list-maintenance-cloud)
* [каталоге](#list-maintenance-folder)
* [кластере](#list-maintenance-cluster)

### Получить список обслуживаний в облаке {#list-maintenance-cloud}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Maintenance.List](../api-ref/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/?cloudId=<идентификатор_облака>'
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MaintenanceService.List](../api-ref/grpc/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cloud_id": "<идентификатор_облака>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.MaintenanceService.List
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}

### Получить список обслуживаний в каталоге {#list-maintenance-folder}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Maintenance.List](../api-ref/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/?folderId=<идентификатор_каталога>'
     ```

     
     Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MaintenanceService.List](../api-ref/grpc/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "folder_id": "<идентификатор_каталога>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.MaintenanceService.List
        ```

        
        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}

### Получить список обслуживаний в кластере {#list-maintenance-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

    Чтобы просмотреть обслуживания с определенным статусом, нажмите кнопку **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** над списком обслуживаний и в выпадающем меню выберите нужный статус. Вы также можете найти обслуживание по его идентификатору или имени задания – используйте поле над списком обслуживаний.

    Чтобы получить информацию о [влиянии обслуживания на доступность кластера](../concepts/maintenance.md#impact-on-cluster), нажмите на идентификатор нужного обслуживания. В блоке **{{ ui-key.yacloud.mdb.maintenance.title_task-details }}** отображается информация о влиянии обслуживания на пользователей.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Maintenance.List](../api-ref/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/?resourceId=<идентификатор_кластера>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MaintenanceService.List](../api-ref/grpc/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "resource_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.MaintenanceService.List
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}

## Получить информацию об обслуживании {#get-maintenance}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Maintenance.Get](../api-ref/Maintenance/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/<идентификатор_обслуживания>'
     ```

     Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenances).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MaintenanceService.Get](../api-ref/grpc/Maintenance/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "maintenance_id": "<идентификатор_обслуживания>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.MaintenanceService.Get
        ```

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenances).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance).

{% endlist %}

## Получить логи кластера, относящиеся к техническому обслуживанию {#maintenance-logs}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на идентификатор нужного обслуживания.
  1. Нажмите ссылку **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживания, имеющие статус **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}**, назначены на определенную дату и время, которые указаны в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**. При необходимости их можно перенести на новую дату и время.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы перенести обслуживание на новую дату и время:

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке обслуживания со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}**.
  1. В выпадающем меню выберите ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. В открывшемся окне:
      * Чтобы перенести обслуживание вперед на следующее окно обслуживания, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** и затем **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
      * Чтобы перенести обслуживание вперед или назад на определенную дату и время по UTC, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, затем выберите новую дату и интервал времени и нажмите **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы перенести обслуживание на новую дату и время:

  1. Посмотрите описание команды CLI для переноса обслуживания:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance --help
      ```

  1. Чтобы перенести обслуживание на ближайшее окно, выполните команду, указав тип переноса `next-available-window`. Чтобы перенести на определенную дату и время, укажите тип переноса `specific-time`:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
         --reschedule-type <тип_переноса> \
         --delayed-until <временная_метка>
      ```

      Временная метка должна иметь один из следующих форматов:
        * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt)
        * ЧЧ:ММ:СС
        * количество часов и минут, на которые нужно сдвинуть обслуживание.

      Например: `2006-01-02T15:04:05Z`, `15:04:05`, `2h` или `3h30m ago`. При выборе типа переноса `next-available-window` параметр `--delayed-until` указывать не нужно.

  Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  Перенести запланированное обслуживание можно с помощью одного из методов:

  * [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md)
  * [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md)
  
  Чтобы перенести запланированное обслуживание с помощью метода `Cluster.RescheduleMaintenance`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
      --request POST \
      --header "Authorization: Bearer $IAM_TOKEN" \
      --header "Content-Type: application/json" \
      --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
      --data '{
                  "rescheduleType": <тип_переноса>,
                  "delayedUntil": <временная_метка>
              }'
      ```

      Где `rescheduleType` — тип переноса, принимает одно из двух значений:

      * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее окно;
      * `SPECIFIC_TIME` — перенести обслуживание на определенную дату и время.

      Временная метка должна иметь формат [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), например: `2006-01-02T15:04:05Z`. При выборе типа переноса `NEXT_AVAILABLE_WINDOW` параметр `delayedUntil` указывать не нужно.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

  Чтобы перенести запланированное обслуживание с помощью метода `Maintenance.Reschedule`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
      --request POST \
      --header "Authorization: Bearer $IAM_TOKEN" \
      --header "Content-Type: application/json" \
      --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/<идентификатор_обслуживания>:reschedule' \
      --data '{
                  "rescheduleType": <тип_переноса>,
                  "scheduledAt": <временная_метка>
              }'
      ```

      Где `rescheduleType` — тип переноса, принимает одно из двух значений:

      * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее окно;
      * `SPECIFIC_TIME` — перенести обслуживание на определенную дату и время.

      Временная метка должна иметь формат [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), например: `2006-01-02T15:04:05Z`. При выборе типа переноса `NEXT_AVAILABLE_WINDOW` параметр `scheduledAt` указывать не нужно.

      Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenances).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  Перенести запланированное обслуживание можно с помощью одного из вызовов:
  
  * [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md)
  * [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md)

  Чтобы перенести запланированное обслуживание с помощью вызова `ClusterService.RescheduleMaintenance`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "reschedule_type": <тип_переноса>,
              "delayed_until": <временная_метка>
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.postgresql.v1.ClusterService.RescheduleMaintenance
      ```

      Где `reschedule_type` — тип переноса, принимает одно из двух значений:

      * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее окно;
      * `SPECIFIC_TIME` — перенести обслуживание на определенную дату и время.

      Временная метка должна иметь формат [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), например: `2006-01-02T15:04:05Z`. При выборе типа переноса `NEXT_AVAILABLE_WINDOW` параметр `delayed_until` указывать не нужно.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

  Чтобы перенести запланированное обслуживание с помощью вызова `MaintenanceService.Reschedule`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "maintenance_id": "<идентификатор_обслуживания>",
              "reschedule_type": <тип_переноса>,
              "scheduled_at": <временная_метка>
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.postgresql.v1.MaintenanceService.Reschedule
      ```

      Где `reschedule_type` — тип переноса, принимает одно из двух значений:

      * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее окно;
      * `SPECIFIC_TIME` — перенести обслуживание на определенную дату и время.

      Временная метка должна иметь формат [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), например: `2006-01-02T15:04:05Z`. При выборе типа переноса `NEXT_AVAILABLE_WINDOW` параметр `scheduled_at` указывать не нужно.

      Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenances).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

{% endlist %}

## Провести запланированное обслуживание немедленно {#exec-planned-maintenance}

Обслуживания со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** при необходимости можно провести немедленно, не дожидаясь момента, указанного в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы провести запланированное обслуживание кластера немедленно:

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке обслуживания.
  1. В выпадающем меню выберите ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы провести запланированное обслуживание кластера немедленно:

  1. Посмотрите описание команды CLI для переноса обслуживания:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance --help
      ```

  1. Выполните команду, указав тип переноса `immediate`:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
         --reschedule-type immediate
      ```

  Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  Провести запланированное обслуживание немедленно можно с помощью одного из методов:

  * [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md)
  * [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md)
  
  Чтобы провести запланированное обслуживание немедленно с помощью метода `Cluster.RescheduleMaintenance`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
     --request POST \
     --header "Authorization: Bearer $IAM_TOKEN" \
     --header "Content-Type: application/json" \
     --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
     --data '{
                 "rescheduleType": "IMMEDIATE"
             }'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

  Чтобы провести запланированное обслуживание немедленно с помощью метода `Maintenance.Reschedule`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
      --request POST \
      --header "Authorization: Bearer $IAM_TOKEN" \
      --header "Content-Type: application/json" \
      --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/<идентификатор_обслуживания>:reschedule' \
      --data '{
                  "rescheduleType": "IMMEDIATE"
              }'
      ```

      Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenances).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  Провести запланированное обслуживание немедленно можно с помощью одного из вызовов:
  
  * [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md)
  * [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md)

  Чтобы провести запланированное обслуживание немедленно с помощью вызова `ClusterService.RescheduleMaintenance`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "reschedule_type": "IMMEDIATE"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.RescheduleMaintenance
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

  Чтобы провести запланированное обслуживание немедленно с помощью вызова `MaintenanceService.Reschedule`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "maintenance_id": "<идентификатор_обслуживания>",
             "reschedule_type": "IMMEDIATE"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.MaintenanceService.Reschedule
     ```

     Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenances).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить окно обслуживания {#set-maintenance-window}

По умолчанию техническое обслуживание может быть запланировано на любое время. Вы можете выбрать определенный день недели и часовой интервал, на который будет планироваться начало технического обслуживания. Например, можно указать интервал, когда кластер наименее загружен.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. В открывшемся окне:
     * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию).
     * Чтобы разрешить проведение технического обслуживания раз в неделю в определенное время суток, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** и укажите день недели и интервал времени по UTC.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения окна обслуживания:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

  1. Выполните команду:

      ```bash
      {{ yc-mdb-pg }} cluster update <имя_или_идентификатор_кластера> \
         --maintenance-window type=<тип_технического_обслуживания>,`
                             `day=<день_недели>,`
                             `hour=<час>
      ```

      Где `type` — тип технического обслуживания:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

  Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} вы найдете в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
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

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в том числе для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:

       * `anytime` — техническое обслуживание может быть запланировано на любое время.
       * `weeklyMaintenanceWindow` — техническое обслуживание может быть запланировано только на выбранный день недели и порядковый номер часового интервала:

         * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
         * `hour` — порядковый номер часового интервала по UTC в формате `HH`: от `1` до `24`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
             "update_mask": {
               "paths": ["maintenance_window"]
             },
             "maintenance_window": {
               "weekly_maintenance_window": {
                 "day": "<день_недели>",
                 "hour": "<порядковый_номер_часового_интервала>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в том числе для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:

       * `anytime` — техническое обслуживание может быть запланировано на любое время.
       * `weekly_maintenance_window` — техническое обслуживание может быть запланировано только на выбранный день недели и час:

         * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
         * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}
