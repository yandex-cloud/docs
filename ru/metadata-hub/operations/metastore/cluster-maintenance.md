---
title: Техническое обслуживание кластера {{ metastore-name }}
description: Следуя данной инструкции, вы сможете просмотреть информацию о техническом обслуживании кластера, перенести запланированное обслуживание и настроить окно обслуживания в {{ metastore-name }}.
---


# Техническое обслуживание кластера {{ metastore-full-name }}

Вы можете управлять [техническим обслуживанием](../../concepts/metastore-maintenance.md) кластера {{ metastore-name }}.


## Получить список обслуживаний {#list-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../../console/operations/select-service#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Нажмите на имя нужного кластера и выберите ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

      Чтобы просмотреть обслуживания с определенным статусом, выберите статус в поле **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** над списком обслуживаний. Чтобы найти обслуживание, введите его идентификатор или имя задания в поле над списком обслуживаний.

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

        Для этого переноса выберите дату и интервал времени по UTC.

        Обслуживание можно перенести не более чем на две недели от первоначально запланированной даты.

  1. Нажмите кнопку **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

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
