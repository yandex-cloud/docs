---
title: Техническое обслуживание кластера {{ KF }}
description: Следуя данной инструкции, вы сможете просмотреть информацию о планируемых и проведенных технических обслуживаниях кластера {{ KF }}, а также выбрать время для проведения обслуживания.
---

# Техническое обслуживание кластера {{ KF }}

Вы можете управлять [техническим обслуживанием](../concepts/maintenance.md) кластера {{ mkf-full-name }}.

## Получить список обслуживаний {#list-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

    Чтобы просмотреть обслуживания с определенным статусом, нажмите кнопку **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** над списком обслуживаний и в выпадающем меню выберите нужный статус. Чтобы найти конкретное обслуживание, введите его идентификатор или имя задания в поле над списком обслуживаний.

{% endlist %}

## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. Нажмите на идентификатор нужного обслуживания.
    1. Нажмите ссылку **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживания в статусе **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** назначены на дату и время, указанные в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**. При необходимости их можно перенести на другую дату и время.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы перенести обслуживание на другую дату и время:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке обслуживания со статусом **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}**.
    1. В выпадающем меню выберите ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
    1. В открывшемся окне:
        * Чтобы перенести обслуживание вперед на следующее окно обслуживания, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** и затем **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
        * Чтобы перенести обслуживание на конкретную дату и время по UTC, нажмите **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, затем выберите новую дату и время и нажмите **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы перенести обслуживание на другую дату и время:

    1. Посмотрите описание команды CLI для переноса обслуживания:

        ```bash
        {{ yc-mdb-kf }} cluster reschedule-maintenance --help
        ```

    1. Выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
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

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.rescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
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

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
    1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.kafka.v1.ClusterService.RescheduleMaintenance
        ```

        Где:

        * `reschedule_type` — тип переноса:

            * `NEXT_AVAILABLE_WINDOW` — ближайшее доступное окно;
            * `SPECIFIC_TIME` — конкретная дата и время.

        * `delayedUntil` — временная метка в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt). Например, `2006-01-02T15:04:05Z`.

            Параметр не используется с типом переноса `NEXT_AVAILABLE_WINDOW`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.mdb.kafka.v1.Cluster).

{% endlist %}

## Провести запланированное обслуживание немедленно {#exec-planned-maintenance}

Обслуживания в статусе **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** можно провести немедленно, не дожидаясь времени, указанного в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы провести запланированное обслуживание немедленно:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке обслуживания.
    1. В выпадающем меню выберите ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы провести запланированное обслуживание немедленно:

    1. Посмотрите описание команды CLI для переноса обслуживания:

        ```bash
        {{ yc-mdb-kf }} cluster reschedule-maintenance --help
        ```

    1. Выполните команду, указав тип переноса `immediate`:

        ```bash
        {{ yc-mdb-kf }} cluster reschedule-maintenance <имя_или_идентификатор_кластера> \
          --reschedule-type immediate
        ```

        Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    Чтобы провести запланированное обслуживание немедленно:

    1. Получите [IAM-токен для аутентификации в API](../api-ref/authentication.md).
    1. Поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.rescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>:rescheduleMaintenance' \
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

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
          {{ api-host-mdb }}:{{ port-https }} \
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

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. Нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
    1. В открывшемся окне:
        * Чтобы разрешить обслуживание в произвольное время, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию).
        * Чтобы задать конкретное окно обслуживания, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** и укажите день недели и интервал времени по UTC.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для изменения окна обслуживания:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
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

        Полный список доступных для изменения полей конфигурации кластера {{ mkf-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mkf }}).

    1. {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- REST API {#api}

    1. Получите [IAM-токен для аутентификации в API](../api-ref/authentication.md).
    1. Поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
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

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
          {{ api-host-mdb }}:{{ port-https }} \
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
