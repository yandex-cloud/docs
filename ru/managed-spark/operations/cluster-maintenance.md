---
title: Техническое обслуживание кластера {{ SPRK }}
description: Следуя данной инструкции, вы сможете просмотреть информацию о планируемых и проведенных технических обслуживаниях кластера {{ SPRK }}, а также выбрать время для проведения обслуживания.
---

# Техническое обслуживание кластера {{ SPRK }}

Вы можете управлять техническим обслуживанием кластера {{ SPRK }}, в том числе:

* [получить список обслуживаний](#list-maintenance);
* [получить информацию об обслуживании](#get-maintenance);
* [получить логи технического обслуживания кластера](#maintenance-logs);
* [перенести запланированное обслуживание](#postpone-planned-maintenance);
* [провести запланированное обслуживание немедленно](#exec-planned-maintenance);
* [настроить окно обслуживания](#set-maintenance-window).

## Получить список обслуживаний {#list-maintenance}

Для сервиса {{ msp-name }} можно получить список обслуживаний в [облаке](#list-cloud-maintenance), [каталоге](#list-folder-maintenance) или [кластере](#list-cluster-maintenance).

### Получить список обслуживаний в облаке {#list-cloud-maintenance}

{% list tabs group=instructions %}

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
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cloud_id": "<идентификатор_облака>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.List
        ```

        
        О том, как получить идентификатор облака, читайте в [инструкции](../../resource-manager/operations/cloud/get-id.md).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}

### Получить список обслуживаний в каталоге {#list-folder-maintenance}

{% list tabs group=instructions %}

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
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<идентификатор_каталога>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.List
        ```

        
        О том, как получить идентификатор каталога, читайте в [инструкции](../../resource-manager/operations/folder/get-id.md).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}

### Получить список обслуживаний в кластере {#list-cluster-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и перейдите в раздел **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

    Чтобы просмотреть обслуживания с определенным статусом, нажмите **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** над списком обслуживаний и в выпадающем меню выберите нужный статус. Чтобы найти конкретное обслуживание, введите его идентификатор или имя задания в поле над списком обслуживаний.

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
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "resource_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.List
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse).

{% endlist %}

## Получить информацию об обслуживании {#get-maintenance}

{% list tabs group=instructions %}

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
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<идентификатор_обслуживания>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.Get
        ```

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenance) в облаке, каталоге или кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance).

{% endlist %}

## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Нажмите на имя нужного кластера и перейдите в раздел **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на идентификатор нужного обслуживания.
  1. Нажмите ссылку **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживание в статусе **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** назначено на определенную дату и время, которые указаны в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**. При необходимости такое обслуживание можно перенести на новую дату и время.

Чтобы перенести обслуживание на новую дату и время:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и перейдите в раздел **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке обслуживания со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}**.
    1. В выпадающем меню выберите ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
    1. В открывшемся окне:
        * Чтобы перенести обслуживание вперед на следующее окно обслуживания, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** и затем **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
        * Чтобы перенести обслуживание вперед или назад на определенную дату и время по UTC, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, затем выберите новую дату и время и нажмите **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<идентификатор_обслуживания>",
                "reschedule_type": "<тип_переноса>",
                "scheduled_at": "<временная_метка>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.Reschedule
        ```

        Где:

        * `reschedule_type` — тип переноса, принимает одно из двух значений:

            * `NEXT_AVAILABLE_WINDOW` — перенести обслуживание на ближайшее окно;
            * `SPECIFIC_TIME` — перенести обслуживание на определенную дату и время.

        * `scheduled_at` — новые дата и время обслуживания. Значение должно иметь формат [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt), например: `2006-01-02T15:04:05Z`. При выборе типа переноса `NEXT_AVAILABLE_WINDOW` параметр `scheduled_at` указывать не нужно.

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenance) в облаке, каталоге или кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

{% endlist %}

## Провести запланированное обслуживание немедленно {#exec-planned-maintenance}

Обслуживание со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** при необходимости можно провести немедленно, не дожидаясь момента, указанного в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**.

Чтобы провести запланированное обслуживание кластера немедленно:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и перейдите в раздел **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного обслуживания.
    1. В выпадающем меню выберите ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<идентификатор_обслуживания>",
                "reschedule_type": "IMMEDIATE"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.Reschedule
        ```

        Идентификатор обслуживания можно запросить со [списком обслуживаний](#list-maintenance) в облаке, каталоге или кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить окно обслуживания {#set-maintenance-window}

По умолчанию [техническое обслуживание](../concepts/maintenance.md) может быть запланировано на любое время. Вы можете выбрать определенный день недели и часовой интервал, на который будет планироваться техническое обслуживание. Например, можно указать время, когда кластер наименее загружен.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Нажмите на имя нужного кластера и перейдите в раздел **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. В открывшемся окне:
     * Чтобы разрешить проведение технического обслуживания в любое время, выберите **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию).
     * Чтобы разрешить проведение технического обслуживания раз в неделю в определенное время суток, выберите **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** и укажите день недели и часовой интервал по UTC.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения окна обслуживания:

      ```bash
      {{ yc-mdb-sp }} cluster update --help
      ```

  1. Выполните команду:

      ```bash
      {{ yc-mdb-sp }} cluster update <имя_или_идентификатор_кластера> \
         --maintenance-window type=<тип_технического_обслуживания>,`
                             `day=<день_недели>,`
                             `hour=<порядковый_номер_часового_интервала>
      ```

      Где `type` — тип технического обслуживания:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

      Имя или идентификатор кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ SPRK }} описан в [документации провайдера {{ TF }}]({{ tf-provider-msp }}).

  1. {% include [Maintenance window](../../_includes/mdb/msp/terraform/maintenance-window.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- gRPC API {#grpc-api}

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:
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
       -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
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
       {{ api-host-spark }}:{{ port-https }} \
       yandex.cloud.spark.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:

       * `anytime` — техническое обслуживание проводится в произвольное время.
       * `weekly_maintenance_window` — техническое обслуживание проводится раз в неделю в указанное время:

         * `day` — день недели в формате: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
         * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.

           > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.spark.v1.Cluster).

{% endlist %}
