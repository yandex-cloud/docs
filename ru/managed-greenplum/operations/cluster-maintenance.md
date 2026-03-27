---
title: Техническое обслуживание кластера {{ mgp-full-name }}
description: Как посмотреть информацию о техническом обслуживании кластера, перенести запланированное обслуживание и настроить окно обслуживания в {{ mgp-full-name }}.
---

# Техническое обслуживание кластера {{ mgp-full-name }}

Вы можете управлять [техническим обслуживанием](../concepts/maintenance.md) кластера {{ mgp-full-name }}.

## Получить список обслуживаний {#list-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. (Опционально) Выберите статус обслуживания над списком обслуживаний.

{% endlist %}

## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Выберите нужное обслуживание. Откроется страница обслуживания.
  1. Нажмите ссылку **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. В строке обслуживания со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. Выберите тип переноса запланированного обслуживания:
    
      * **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** — перенос на следующее окно обслуживания.
      * **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}** — перенос на конкретную дату и интервал времени по UTC.

        Для этого переноса выберите дату и интервал времени по UTC.

        Обслуживание можно перенести не более чем на две недели от первоначально запланированной даты.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы перенести запланированное обслуживание:
    
  1. Посмотрите описание команды CLI для изменения времени запланированного обслуживания:
    
      ```bash
      {{ yc-mdb-gp }} cluster reschedule-maintenance --help
      ```
  
  1. Перенесите обслуживание:
    
      ```bash
      {{ yc-mdb-gp }} cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
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
      
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Воспользуйтесь методом [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  
      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
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

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:
  
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
        {{ api-host-mdb }}:{{ port-https }} \
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

  1. Перейдите [на страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. В строке нужного обслуживания нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы провести запланированное обслуживание немедленно:
    
  1. Посмотрите описание команды CLI для изменения времени запланированного обслуживания:
    
      ```bash
      {{ yc-mdb-gp }} cluster reschedule-maintenance --help
      ```
  
  1. Проведите запланированное обслуживание немедленно:
    
      ```bash
      {{ yc-mdb-gp }} cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
        --reschedule-type immediate
      ```
    
      Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
      
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Воспользуйтесь методом [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  
      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
        --data '{
                 "rescheduleType": "IMMEDIATE"
               }'
      ```
    
      Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:
  
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
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.greenplum.v1.ClusterService.RescheduleMaintenance
      ```
    
      Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить окно обслуживания {#set-maintenance-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. В правом верхнем углу страницы нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. Выберите окно обслуживания:
    
      * **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** — обслуживание проводится в любое время.
      * **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** — обслуживание проводится по расписанию, в выбранный день недели и интервал времени по UTC.

        Для этого типа обслуживания выберите начало окна обслуживания: день недели и интервал времени по UTC.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы настроить окно технического обслуживания:
    
  1. Посмотрите описание команды CLI для изменения настроек кластера:
    
      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```
  
  1. Настройте окно технического обслуживания:
    
      ```bash
      {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
        --maintenance-window type=<тип_технического_обслуживания>,`
                            `day=<день_недели>,`
                            `hour=<час_дня>
      ```
    
      Где `type` — тип технического обслуживания:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}
    
      Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ GP }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

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

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}


- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
      
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  
      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
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

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:
  
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
        {{ api-host-mdb }}:{{ port-https }} \
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