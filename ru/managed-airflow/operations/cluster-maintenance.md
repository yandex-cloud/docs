---
title: Техническое обслуживание кластера {{ maf-full-name }}
description: Следуя этой инструкции, вы сможете просмотреть информацию о планируемых и проведенных технических обслуживаниях кластера {{ maf-name }}, а также выбрать время для проведения обслуживания.
---

# Техническое обслуживание кластера {{ maf-full-name }}

Вы можете управлять [техническим обслуживанием](../concepts/maintenance.md) кластера {{ maf-name }}.

## Получить список обслуживаний {#list-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

  Чтобы просмотреть обслуживания с определенным статусом, нажмите кнопку **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** над списком обслуживаний и в выпадающем меню выберите нужный статус. Чтобы найти конкретное обслуживание, введите его идентификатор или имя задания в поле над списком обслуживаний.

{% endlist %}

## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на идентификатор нужного обслуживания.
  1. Нажмите ссылку **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживания в статусе **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** назначены на определенную дату и время, которые указаны в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**. При необходимости их можно перенести на новую дату и время.

Чтобы перенести обслуживание на новую дату и время:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке обслуживания со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}**.
  1. В выпадающем меню выберите ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. В открывшемся окне:

      * Чтобы перенести обслуживание вперед на следующее окно обслуживания, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** и затем **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
      * Чтобы перенести обслуживание вперед или назад на определенную дату и время по UTC, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, затем выберите новую дату и время и нажмите **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

{% endlist %}

## Провести запланированное обслуживание немедленно {#exec-planned-maintenance}

Обслуживание со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** при необходимости можно провести немедленно, не дожидаясь момента, указанного в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**.

Чтобы провести запланированное обслуживание кластера немедленно:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного обслуживания.
  1. В выпадающем меню выберите ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

{% endlist %}

## Настроить окно обслуживания {#set-maintenance-window}

По умолчанию техническое обслуживание может быть запланировано на любое время. Вы можете выбрать определенный день недели и час, на который будет планироваться техническое обслуживание. Например, можно указать время, когда кластер наименее загружен.

{% note warning %}

При выборе нового интервала обслуживания будет автоматически отменено запланированное обслуживание, если оно не попадает в новый интервал.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. В открывшемся окне:
  
     * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию).
     * Чтобы разрешить проведение технического обслуживания раз в неделю в определенное время суток, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** и укажите день недели и час по UTC.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения окна обслуживания:

      ```bash
      {{ yc-mdb-af }} cluster update --help
      ```

  1. Выполните команду:

      ```bash
      {{ yc-mdb-af }} cluster update <имя_или_идентификатор_кластера> \
          --maintenance-window type=<тип_технического_обслуживания>,`
                              `day=<день_недели>,`
                              `hour=<час_дня>
      ```

      Где `type` — тип технического обслуживания:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

      Имя и идентификатор кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Чтобы настроить время технического обслуживания, добавьте к описанию кластера блок `maintenance_window`:
  
      ```hcl
      resource "yandex_airflow_cluster" "<имя_кластера>" {
        ...
        maintenance_window = {
          type = "<тип_технического_обслуживания>"
          day  = "<день_недели>"
          hour = <час_дня>
        }
        ...
      }
      ```
  
      {% include [Maintenance window description](../../_includes/mdb/terraform/maintenance-window-description.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите его в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-airflow }}/managed-airflow/v1/clusters/<идентификатор_кластера>' \
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

     * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-rest.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите его в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
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
       {{ api-host-airflow }}:{{ port-https }} \
       yandex.cloud.airflow.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-grpc.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).


{% endlist %}

