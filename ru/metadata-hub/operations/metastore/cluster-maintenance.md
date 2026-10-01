---
title: Техническое обслуживание кластера {{ metastore-name }}
description: Следуя данной инструкции, вы сможете просмотреть информацию о техническом обслуживании кластера, перенести запланированное обслуживание и настроить окно обслуживания в {{ metastore-name }}.
---


# Техническое обслуживание кластера {{ metastore-full-name }}

Вы можете управлять [техническим обслуживанием](../../concepts/metastore-maintenance.md) кластера {{ metastore-name }}.

## Получить список обслуживаний {#list-maintenance}

Для сервиса {{ metastore-name }} можно получить список обслуживаний в [облаке](#list-cloud-maintenance), [каталоге](#list-folder-maintenance) или [кластере](#list-cluster-maintenance).

### Получить список обслуживаний в облаке {#list-cloud-maintenance}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Maintenance.List](../../api-ref/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances?cloudId=<идентификатор_облака>'
        ```

        
        О том, как получить идентификатор облака, читайте в [инструкции](../../../resource-manager/operations/cloud/get-id.md).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MaintenanceService.List](../../api-ref/grpc/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cloud_id": "<идентификатор_облака>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.List
        ```

        
        О том, как получить идентификатор облака, читайте в [инструкции](../../../resource-manager/operations/cloud/get-id.md).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}

### Получить список обслуживаний в каталоге {#list-folder-maintenance}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Maintenance.List](../../api-ref/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances?folderId=<идентификатор_каталога>'
        ```

        
        О том, как получить идентификатор каталога, читайте в [инструкции](../../../resource-manager/operations/folder/get-id.md).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MaintenanceService.List](../../api-ref/grpc/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<идентификатор_каталога>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.List
        ```

        
        О том, как получить идентификатор каталога, читайте в [инструкции](../../../resource-manager/operations/folder/get-id.md).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}

### Получить список обслуживаний в кластере {#list-cluster-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. [Перейдите](../../../console/operations/select-service#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Нажмите на имя нужного кластера и выберите ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

        Чтобы просмотреть обслуживания с определенным статусом, выберите статус в поле **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** над списком обслуживаний. Чтобы найти обслуживание, введите его идентификатор или имя задания в поле над списком обслуживаний.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Maintenance.List](../../api-ref/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances?resourceId=<идентификатор_кластера>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MaintenanceService.List](../../api-ref/grpc/Maintenance/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "resource_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.List
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}

## Получить информацию об обслуживании {#get-maintenance}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Maintenance.Get](../../api-ref/Maintenance/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances/<идентификатор_обслуживания>'
        ```

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenance) в облаке, каталоге или кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [MaintenanceService.Get](../../api-ref/grpc/Maintenance/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<идентификатор_обслуживания>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.Get
        ```

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenance) в облаке, каталоге или кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance).

{% endlist %}

## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../../console/operations/select-service#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Нажмите на имя нужного кластера и выберите ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Выберите обслуживание. Откроется страница обслуживания.
  1. Нажмите ссылку **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживание в статусе **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** назначено на определенную дату и время, которые указаны в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**. При необходимости его можно перенести на новую дату и время.

Чтобы перенести обслуживание на новую дату и время:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. [Перейдите](../../../console/operations/select-service#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Нажмите на имя нужного кластера и выберите ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. В строке обслуживания со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
    1. Выберите тип переноса запланированного обслуживания:

        * **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** — перенос на следующее окно обслуживания.
        * **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}** — перенос на конкретную дату и время.

            Для этого переноса выберите дату и интервал времени по UTC. Обслуживание можно перенести не более чем на две недели от первоначально запланированной даты.

    1. Нажмите кнопку **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- REST API {#api}

    Чтобы перенести обслуживание на новую дату и время:

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Maintenance.Reschedule](../../api-ref/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances/<идентификатор_обслуживания>:reschedule' \
        --data '{
                    "rescheduleType": "<тип_переноса>",
                    "scheduledAt": "<временная_метка>"
                }'
        ```

        Где `rescheduleType` — тип переноса, принимает одно из двух значений:

        * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее окно;
        * `SPECIFIC_TIME` — перенести обслуживание на определенную дату и время.

        Временная метка должна иметь формат [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), например: `2006-01-02T15:04:05Z`. При выборе типа переноса `NEXT_AVAILABLE_WINDOW` параметр `scheduledAt` указывать не нужно.

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenance) в облаке, каталоге или кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [MaintenanceService.Reschedule](../../api-ref/grpc/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<идентификатор_обслуживания>",
                "reschedule_type": "<тип_переноса>",
                "scheduled_at": "<временная_метка>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.Reschedule
        ```

        Где `reschedule_type` — тип переноса, принимает одно из двух значений:

        * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее окно;
        * `SPECIFIC_TIME` — перенести обслуживание на определенную дату и время.

        Временная метка должна иметь формат [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), например: `2006-01-02T15:04:05Z`. При выборе типа переноса `NEXT_AVAILABLE_WINDOW` параметр `scheduled_at` указывать не нужно.

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenance) в облаке, каталоге или кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

{% endlist %}

## Провести запланированное обслуживание немедленно {#exec-planned-maintenance}

Обслуживание со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** при необходимости можно провести немедленно, не дожидаясь момента, указанного в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**.

Чтобы провести запланированное обслуживание кластера немедленно:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. [Перейдите](../../../console/operations/select-service#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Нажмите на имя нужного кластера и выберите ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. В строке нужного обслуживания нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Maintenance.Reschedule](../../api-ref/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances/<идентификатор_обслуживания>:reschedule' \
        --data '{
                    "rescheduleType": "IMMEDIATE"
                }'
        ```

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenance) в облаке, каталоге или кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [MaintenanceService.Reschedule](../../api-ref/grpc/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<идентификатор_обслуживания>",
                "reschedule_type": "IMMEDIATE"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.Reschedule
        ```

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenance) в облаке, каталоге или кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить окно обслуживания {#set-maintenance-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../../console/operations/select-service#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Нажмите на имя нужного кластера и выберите ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. В правом верхнем углу страницы нажмите кнопку ![image](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. Выберите время [технического обслуживания](../../concepts/metastore-maintenance.md) кластера:

      {% include [Maintenance window](../../../_includes/metadata-hub/metastore-maintenance-window-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы настроить [окно обслуживания](../../concepts/metastore-maintenance.md#maintenance-window):

  1. Посмотрите описание команды CLI для изменения настроек кластера:

      ```bash
      {{ yc-metastore }} cluster update --help
      ```

  1. Настройте окно обслуживания:

      ```bash
      {{ yc-metastore }} cluster update <имя_или_идентификатор_кластера> \
        --maintenance-window type=<тип_технического_обслуживания>,`
                            `day=<день_недели>,`
                            `hour=<порядковый_номер_часового_интервала>
      ```

      Где:

      * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * `--maintenance-window` — настройки времени [технического обслуживания](../../concepts/metastore-maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../../_includes/mdb/cli/maintenance-window-description.md) %}


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл, читайте в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ metastore-name }} вы найдете в [документации провайдера {{ TF }}]({{ tf-provider-metastore }}).

  1. Чтобы настроить [окно обслуживания](../../concepts/metastore-maintenance.md#maintenance-window), добавьте к описанию кластера блок `maintenance_window`:

      ```hcl
      resource "yandex_metastore_cluster" "<локальное_имя_кластера>" {
        ...
        maintenance_window = {
          type = "<тип_технического_обслуживания>"
          day  = "<день_недели>"
          hour = <порядковый_номер_часового_интервала>
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

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.Update](../../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters/<идентификатор_кластера>' \
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

      * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      * `updateMask` — перечень изменяемых параметров в строку через запятую.

        В этом примере передается только один параметр `maintenanceWindow`.

        {% note warning %}

        Все настройки изменяемого объекта в кластере, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

        {% endnote %}

      * {% include [metastore-maintenance-window-rest](../../../_includes/metadata-hub/metastore-maintenance-window-rest.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.Update](../../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
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
        {{ api-host-metastore }}:{{ port-https }} \
        yandex.cloud.metastore.v1.ClusterService.Update \
      ```

      Где:

      * `cluster_id` — идентификатор кластера, который можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
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

      * {% include [metastore-maintenance-window-grpc](../../../_includes/metadata-hub/metastore-maintenance-window-grpc.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
