---
title: Техническое обслуживание кластера {{ TR }}
description: Следуя данной инструкции, вы сможете просмотреть информацию о планируемых и проведенных технических обслуживаниях кластера {{ TR }}, а также выбрать время для проведения обслуживания.
---

# Техническое обслуживание кластера {{ TR }}

Вы можете управлять [техническим обслуживанием](../concepts/maintenance.md) кластера {{ mtr-full-name }}.

## Получить список обслуживаний {#list-maintenance}

{% list tabs group=instructions %}

- Консоль управления {#console}
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

  Чтобы просмотреть обслуживания с определенным статусом, нажмите кнопку **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** над списком обслуживаний и в выпадающем меню выберите нужный статус. Чтобы найти конкретное обслуживание, введите его идентификатор или имя задания в поле над списком обслуживаний.

{% endlist %}

## Получить логи технического обслуживания кластера {#maintenance-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите на идентификатор нужного обслуживания.
  1. Нажмите ссылку **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Перенести запланированное обслуживание {#postpone-planned-maintenance}

Обслуживание в статусе **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** назначено на определенную дату и время, которые указаны в столбце **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}**. При необходимости их можно перенести на новую дату и время.

Чтобы перенести обслуживание на новую дату и время:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
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

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
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

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Нажмите кнопку ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. В открывшемся окне:
     * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию).
     * Чтобы разрешить проведение технического обслуживания раз в неделю в определенное время суток, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** и укажите день недели и час по UTC.

{% endlist %}
