---
title: Управлять техническим обслуживанием ВМ с GPU в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете управлять техническим обслуживанием виртуальных машин с GPU в сервисе {{ compute-full-name }}.
---

# Управлять техническим обслуживанием виртуальных машин с GPU

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{{ compute-name }} периодически проводит [техническое обслуживание](../../concepts/gpus-maintenance.md) виртуальных машин с GPU с уведомлением пользователей о дате и времени проведения работ. Вы можете просматривать список [заданий](../../concepts/gpus-maintenance.md#tasks) на техническое обслуживание, запланированных для ваших ВМ, а также при необходимости переносить время выполнения заданий.

## Посмотреть задания на техническое обслуживание ВМ {#list-scheduled-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите посмотреть задания на техническое обслуживание ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![bars-play](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.compute.maintenance_js7p4 }}**.

      В открывшемся окне приведен список всех заданий на техническое обслуживание ВМ с GPU, который содержит:

      * `{{ ui-key.yacloud.common.id }}` — идентификатор задания.
      * `{{ ui-key.yacloud.compute.maintenance.task_pZ1gY }}` — действие, влияющее на доступность ВМ, которое будет выполняться в отношении ВМ в рамках технического обслуживания. Например: `Restart`.
      * `{{ ui-key.yacloud.compute.maintenance.status_pZ1gY }}` — [статус](../../concepts/gpus-maintenance.md#maintenance-status) задания.
      * `{{ ui-key.yacloud.compute.maintenance.resource_pZ1gY }}` — имя виртуальной машины, для которой назначено техническое обслуживание.
      * `Дата начала` — дата и время планируемого начала обслуживания ВМ, если задание еще не выполнено, в остальных случаях — дата и время фактического начала обслуживания.
      * `Выполнено` — дата и время завершения обслуживания.

      Чтобы открыть [подробную информацию](../../concepts/gpus-maintenance.md#tasks) о задании на техническое обслуживание, нажмите на соответствующую строку в списке заданий. Чтобы быстрее найти в списке нужное задание, воспользуйтесь фильтром вверху страницы.

      Даты и время, отображаемые в информации о заданиях, соответствуют часовому поясу, который задан в настройках [консоли управления]({{ link-console-main }}) пользователя.

  {% note tip %}

  Сведения о запланированном задании на техническое обслуживание виртуальной машины также отображаются в форме примечания ![bulb](../../../_assets/console-icons/bulb.svg) в поле **{{ ui-key.yacloud.common.name }}** в списке ВМ в разделе **{{ ui-key.yacloud.compute.instances.label_title }}**, а также на странице с информацией о соответствующей виртуальной машине.

  {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Чтобы посмотреть список заданий на техническое обслуживание ВМ, выполните команду:

      ```bash
      yc compute maintenance list \
        --cloud-id <идентификатор_облака> \
        --folder-id <идентификатор_каталога> \
        --resource-id <идентификатор_ВМ> \
        --filter <фильтр> \
        --order <порядок_сортировки>
      ```

      Где:
      * `--cloud-id` — [идентификатор](../../../resource-manager/operations/cloud/get-id.md) облака, в котором вы хотите посмотреть задания.
      * `--folder-id` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором вы хотите посмотреть задания.
      * `--resource-id` — идентификатор виртуальной машины, для которой вы хотите посмотреть задания.

          {% note info %}

          Параметры `--cloud-id`, `--folder-id` и `--resource-id` — взаимоисключающие. Вы можете указать только один из них.
          
          Если не задан ни один из этих параметров, команда выведет список заданий на техническое обслуживание в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию.

          {% endnote %}

      * `--filter` — фильтр, который вы хотите применить к полученному списку заданий. Необязательный параметр. По умолчанию команда выводит полный список заданий на техническое обслуживание.
      
          Вы можете отфильтровать список по статусу (`status`) задания или по идентификатору (`resource_id`) ВМ. Например: `--filter 'status = "SCHEDULED"'` или `--filter 'resource_id = "a7loutvf73vg********"'`.
      * `--order` — порядок сортировки списка заданий. Необязательный параметр. Доступные значения:
      
          * `created_at` — по времени, в которое задание было создано;
          * `start_scheduled_at` — по времени, на которое задание запланировано;
          * `started_at` — по времени, в которое задание было начато.

          По умолчанию задания сортируются по возрастанию. Чтобы сортировать задания по убыванию, используйте параметр `DESC`. Например: `--order 'created_at DESC'`.

      Результат:

      ```bash
      +----------------------+----------------------+----------------------+------------------+----------------------+-----------+---------------------+---------------------+---------------------+
      |          ID          |       CLOUD ID       |      FOLDER ID       |  RESOURCE TYPE   |     RESOURCE ID      |  STATUS   |     CREATED AT      | START SCHEDULED AT  |     STARTED AT      |
      +----------------------+----------------------+----------------------+------------------+----------------------+-----------+---------------------+---------------------+---------------------+
      | a7l0b4nkle3b******** | a7lia87mbaom******** | a7lt6g8ht345******** | compute.instance | a7loutvf73vg******** | SUCCEEDED | 2025-09-03 11:08:15 | 2025-09-03 11:15:39 | 2025-09-03 11:15:52 |
      | a7l742uljpl3******** | a7lia87mbaom******** | a7lt6g8ht345******** | compute.instance | a7l7f7n9dbfq******** | SCHEDULED | 2025-09-03 11:58:59 | 2025-09-08 07:00:00 |                     |
      +----------------------+----------------------+----------------------+------------------+----------------------+-----------+---------------------+---------------------+---------------------+
      ```

      В поле `ID` для каждого задания содержится его идентификатор.

  1. Чтобы посмотреть информацию об определенном задании, выполните команду, указав идентификатор этого задания:

      ```bash
      yc compute maintenance get <идентификатор_задания>
      ```

      Результат:

      ```bash
      id: a7l742uljpl3********
      resource_path:
        - id: a7l7f7n9dbfq********
          type: compute.instance
        - id: aoepotm5k3oa********
          type: resource-manager.folder
        - id: a7lia87mbaom********
          type: resource-manager.cloud
      status: SCHEDULED
      created_at: "2025-09-03T11:58:59Z"
      start_scheduled_at: "2025-09-08T07:00:00Z"
      completion_scheduled_at: "2025-09-08T15:00:00Z"
      max_start_scheduled_at: "2025-09-08T07:00:00Z"
      user_controllable: true
      ```

{% endlist %}

## Перенести запланированные задания на техническое обслуживание ВМ {#reschedule-maintenance}

Вы можете перенести запланированное задание на более поздний или ранний срок:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) с виртуальной машиной, для которой вы хотите перенести запланированное задание на техническое обслуживание.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![bars-play](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.compute.maintenance_js7p4 }}**.
  1. В открывшемся списке в строке с нужным заданием нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrow-uturn-cw-right](../../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.compute.maintenance.MaintenanceActions.reschedule_rDGt3 }}**. В открывшемся окне:

      1. Выберите новую дату и временной интервал для выполнения задания.

          Чтобы узнать, на какой максимальный срок вы можете перенести задание на техническое обслуживание, в списке заданий нажмите на строку с нужным заданием. В открывшемся окне крайний срок переноса обслуживания указан в поле **Можно отложить до**.
      1. Нажмите **{{ ui-key.yacloud.compute.components.MaintenanceRescheduleDialog.button_reschedule_3SHfY }}**.

  {% note tip %}

  Перенести запланированное задание на техническое обслуживание виртуальной машины вы также можете, нажав на примечание ![bulb](../../../_assets/console-icons/bulb.svg) в поле **{{ ui-key.yacloud.common.name }}** в списке ВМ в разделе **{{ ui-key.yacloud.compute.instances.label_title }}**, а также на странице с информацией о соответствующей виртуальной машине.

  {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Узнайте](#list-scheduled-maintenance) идентификатор нужного задания на техническое обслуживание.
  1. Чтобы перенести задание на обслуживание ВМ на другое время, выполните команду:

      ```bash
      yc compute maintenance reschedule <идентификатор_задания> \
        --time "<новое_время_выполнения>"
      ```

      Где:
      * `<идентификатор_задания>` — полученный на предыдущем шаге идентификатор задания, время выполнения которого вы хотите изменить.
      * `<новое_время_выполнения>` — новое время выполнения, на которое вы хотите перенести задание. Например: `2025-09-07T07:00:00Z`.

        Время указывается в формате [ISO 8601](https://{{ lang }}.wikipedia.org/wiki/ISO_8601) UTC с нулевым смещением времени. Если необходимо указать московское время, добавьте `+03:00` вместо `Z` в конец строки: `2025-09-07T07:00:00+03:00`.
        
      Результат:

      ```bash
      id: a7l742uljpl3********
      resource_path:
        - id: a7l7f7n9dbfq********
          type: compute.instance
        - id: aoepotm5k3oa********
          type: resource-manager.folder
        - id: a7lia87mbaom********
          type: resource-manager.cloud
      status: SCHEDULED
      created_at: "2025-09-03T11:58:59Z"
      start_scheduled_at: "2025-09-07T07:00:00Z"
      completion_scheduled_at: "2025-09-07T15:00:00Z"
      max_start_scheduled_at: "2025-09-08T07:00:00Z"
      user_controllable: true
      ```

{% endlist %}

## Выполнить запланированные задания немедленно {#execute-now}

Вы можете выполнить запланированное задание на техническое обслуживание ВМ немедленно:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) с виртуальной машиной, для которой вы хотите выполнить задание на техническое обслуживание.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![bars-play](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.compute.maintenance_js7p4 }}**.
  1. В открывшемся списке в строке с нужным заданием нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![play](../../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.compute.maintenance.MaintenanceActions.perform-now_m8iqx }}**.
  1. В открывшемся окне подтвердите немедленное выполнение задания.

  {% note tip %}

  Выполнить запланированное задание на техническое обслуживание ВМ немедленно вы также можете, нажав на примечание ![bulb](../../../_assets/console-icons/bulb.svg) в поле **{{ ui-key.yacloud.common.name }}** в списке ВМ в разделе **{{ ui-key.yacloud.compute.instances.label_title }}**, а также на странице с информацией о соответствующей виртуальной машине.

  {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Узнайте](#list-scheduled-maintenance) идентификатор нужного задания на техническое обслуживание.
  1. Чтобы начать выполнение задания немедленно, выполните команду, указав полученный на предыдущем шаге идентификатор этого задания:

      ```bash
      yc compute maintenance reschedule <идентификатор_задания> \
        --immediate
      ```

      Результат:

      ```bash
      id: a7l742uljpl3********
      resource_path:
        - id: a7l7f7n9dbfq********
          type: compute.instance
        - id: aoepotm5k3oa********
          type: resource-manager.folder
        - id: a7lia87mbaom********
          type: resource-manager.cloud
      status: RUNNING
      created_at: "2025-09-03T11:58:59Z"
      start_scheduled_at: "2025-09-03T13:07:13.136955876Z"
      completion_scheduled_at: "2025-09-04T21:07:13.136955876Z"
      max_start_scheduled_at: "2025-09-08T07:00:00Z"
      user_controllable: true
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/gpus-maintenance.md)