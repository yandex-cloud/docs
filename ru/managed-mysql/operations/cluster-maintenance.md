---
title: Техническое обслуживание кластера {{ mmy-name }}
description: Как просмотреть информацию о техническом обслуживании кластера, а также настроить время его проведения в {{ mmy-full-name }}.
---


# Техническое обслуживание кластера {{ mmy-full-name }}

Вы можете управлять [техническим обслуживанием](../concepts/maintenance.md) кластера {{ mmy-name }}.


## Получить список обслуживаний {#list-maintenance}

Для сервиса {{ mmy-name }} можно получить список обслуживаний в:

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
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances?cloudId=<идентификатор_облака>'
      ```
    
      
      О том, как получить идентификатор облака, в [соответствующей инструкции](../../resource-manager/operations/cloud/get-id.md).

  
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
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cloud_id": "<идентификатор_облака>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.List
      ```

      
      О том, как получить идентификатор облака, в [соответствующей инструкции](../../resource-manager/operations/cloud/get-id.md).

  
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
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances?folderId=<идентификатор_каталога>'
      ```
    
      
      Идентификатор каталога можно получить со [списком каталогов](../../resource-manager/operations/folder/get-id.md) в облаке.
      
  
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
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "folder_id": "<идентификатор_каталога>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.List
      ```

      
      Идентификатор каталога можно получить со [списком каталогов](../../resource-manager/operations/folder/get-id.md) в облаке.
      
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}


### Получить список обслуживаний в кластере {#list-maintenance-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

      Чтобы просмотреть обслуживания с определенным статусом, выберите статус в поле **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** над списком обслуживаний. Вы также можете найти обслуживание по его идентификатору или имени задания с помощью поля поиска над списком обслуживаний.

      Чтобы получить информацию о [влиянии обслуживания на доступность кластера](../concepts/maintenance.md#impact-on-cluster), нажмите на идентификатор нужного обслуживания. В блоке **{{ ui-key.yacloud.mdb.maintenance.title_task-details }}** отображается информация о влиянии обслуживания на пользователей.

- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Воспользуйтесь методом [Maintenance.List](../api-ref/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  
      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances?resourceId=<идентификатор_кластера>'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
  
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
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.List
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
  
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
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances/<идентификатор_обслуживания>'
      ```
    
      Идентификатор обслуживания можно получить со [списком обслуживаний](#list-maintenance).
  
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
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "maintenance_id": "<идентификатор_обслуживания>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.Get
      ```

      Идентификатор обслуживания можно получить со [списком обслуживаний](#list-maintenance).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance).

{% endlist %}


## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Выберите обслуживание.
  1. Нажмите ссылку **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}


## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживание в статусе **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** назначено на определенную дату и время, которые указаны в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**. При необходимости такое обслуживание можно перенести на новую дату и время, но не более чем на две недели от первоначально запланированной даты и времени.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы перенести запланированное обслуживание:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. В строке обслуживания со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. Выберите тип переноса:
    
      * **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** — перенести обслуживание на ближайшее доступное окно.
      * **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}** — перенести обслуживание на новую дату и время.

        В этом случае выберите дату и интервал времени по UTC.

  1. Нажмите кнопку **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы перенести запланированное обслуживание:

  1. Посмотрите описание команды CLI для переноса обслуживания:

      ```bash
      {{ yc-mdb-my }} cluster reschedule-maintenance --help
      ```

  1. Перенесите обслуживание, выполнив команду:

      ```bash
      {{ yc-mdb-my }} cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
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

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
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

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
      
  1. Воспользуйтесь методом [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances/<идентификатор_обслуживания>:reschedule' \
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

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
        {{ api-host-mdb }}:{{ port-https }} \
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

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
        {{ api-host-mdb }}:{{ port-https }} \
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

Обслуживание со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** при необходимости можно провести немедленно, не дожидаясь момента, указанного в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы провести запланированное обслуживание кластера немедленно:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. В строке нужного обслуживания нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы провести запланированное обслуживание кластера немедленно:

  1. Посмотрите описание команды CLI для проведения обслуживания:

      ```bash
      {{ yc-mdb-my }} cluster reschedule-maintenance --help
      ```

  1. Проведите запланированное обслуживание, выполнив команду:

      ```bash
      {{ yc-mdb-my }} cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
         --reschedule-type immediate
      ```

      Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
    
- REST API {#api}

  Провести запланированное обслуживание немедленно можно с помощью одного из методов:

  * [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md)
  * [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md)

  Чтобы провести запланированное обслуживание немедленно с помощью метода `Cluster.RescheduleMaintenance`:
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Воспользуйтесь методом [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
        --data '{
                  "rescheduleType": "IMMEDIATE"
                }'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).
  
  Чтобы провести запланированное обслуживание немедленно с помощью метода `Maintenance.Reschedule`:
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
      
  1. Воспользуйтесь методом [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances/<идентификатор_обслуживания>:reschedule' \
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

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.ClusterService.RescheduleMaintenance
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

  Чтобы провести запланированное обслуживание немедленно с помощью вызова `MaintenanceService.Reschedule`:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.Reschedule
      ```

      Идентификатор обслуживания можно получить со [списком обслуживаний](#list-maintenance).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

{% endlist %}


## Настроить окно обслуживания {#set-maintenance-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и перейдите на вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. В правом верхнем углу страницы нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. Настройте время [технического обслуживания](../concepts/maintenance.md) кластера:

      {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы настроить [окно обслуживания](../concepts/maintenance.md#maintenance-window):
    
  1. Посмотрите описание команды CLI для изменения настроек кластера:
    
      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```
  
  1. Настройте окно обслуживания, выполнив команду:
    
      ```bash
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
         --maintenance-window type=<тип_технического_обслуживания>,`
                             `day=<день_недели>,`
                             `hour=<порядковый_номер_часового_интервала>
      ```
    
      Где:
      
      * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
      * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, в разделе [{#T}](cluster-create.md).

  1. {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}
      
      Подробнее о ресурсе `yandex_mdb_mysql_cluster` в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}


- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  
      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
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

      {% include [maintenance-window-rest](../../_includes/mdb/mmy/maintenance-window-rest.md) %}
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:
  
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
        {{ api-host-mdb }}:{{ port-https }} \
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

      {% include [maintenance-window-rest](../../_includes/mdb/mmy/maintenance-window-grpc.md) %}
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}
