---
title: "Как настроить правила"
description: "Следуя данной инструкции, вы сможете настроить правила."
---

# Настроить правила

{% note warning %}

По умолчанию настраивать очередь может [только ее владелец](queue-access.md).

{% endnote %}

## Создать правило {#create-rule}

Правило будет применено ко всем новым задачам в очереди. Таймер SLA не появится в задачах, созданных раньше, чем правило.

Чтобы создать новое правило SLA:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %} 

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**. 

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--sla }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.create-sla }}**.

1. Нажмите на значок ![](../../_assets/tracker/icon-edit.png) и введите название правила.

1. Выберите [график работы](schedule.md). График работы устанавливает время, когда правило активно. В нерабочие часы отсчет времени идти не будет.

1. С помощью фильтров можно выбрать задачи, к которым будет применено правило. По умолчанию включен фильтр <q>{{ ui-key.startrek-backend.defaults.sla.default.filter.name }}</q>.
   
   * Чтобы добавить фильтр, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_sla-editor.thresholds--new }}** и задайте критерии, по которым будут отбираться задачи.

   * Чтобы изменить существующий фильтр, нажмите на значок ![](../../_assets/tracker/icon-edit.png).
   
   * Чтобы удалить фильтр, нажмите на значок ![](../../_assets/tracker/icon-delete.png).

   Для одного правила можно задать несколько фильтров.

1. Для каждой группы задайте сроки выполнения задач в формате `00h 00m`:
   
    * **Время до предупреждения** (необязательный параметр) — по истечении этого срока {{ tracker-name }} отправит предупреждение, что время обработки задачи на исходе.

    * **{{ ui-key.startrek.blocks-desktop_sla-editor.thresholds--max }}** — предельное время на обработку задачи. По истечении этого времени {{ tracker-name }} отправит уведомление о срыве срока.

1. Задайте условия, при которых таймер будет запускаться, приостанавливаться или останавливаться:

    * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}** — таймер запустится, если выполнено любое из перечисленных условий. Если таймер стоял на паузе, отсчет времени будет возобновлен.

    * **Пауза** — таймер приостановится, если выполнено любое из перечисленных условий. Таймер запустится, когда будет выполнено условие из списка **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}**.

        {% note alert %}

        Если в качестве условия для паузы выбрано "{{ ui-key.startrek-backend.messages.sla.issue.on.status.timer.trigger.condition.type }}", таймер запустится, как только задача будет переведена в любой другой статус.

        {% endnote %}

    * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-end }}** — таймер остановится, если выполнено любое из перечисленных условий.

    Возможные условия:
    Условие | Режим таймера | Описание
    ----- | ----- | -----
    {{ ui-key.startrek-backend.messages.sla.assignee.deleted.timer.trigger.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}**, **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-end }}** | Условие считается выполненным, когда в задаче удаляют исполнителя.  
    {{ ui-key.startrek-backend.messages.sla.assignee.set.timer.trigger.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}**, **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-end }}** | Условие считается выполненным, когда задаче назначают нового исполнителя.
    {{ ui-key.startrek-backend.messages.sla.client.commented.timer.trigger.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}**, **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-end }}** | Условие считается выполненным, когда задачу прокомментировал пользователь, не входящий в [команду очереди](queue-team.md).
    {{ ui-key.startrek-backend.messages.sla.issue.created.timer.trigger.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}** | Таймер запустится сразу после создания задачи.
    {{ ui-key.startrek-backend.messages.sla.status.changed.timer.trigger.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}**, **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-end }}** | Условие считается выполненным, когда задачу переводят в один из указанных в нем статусов.
    {{ ui-key.startrek-backend.messages.sla.resolution.deleted.timer.trigger.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}** | Условие считается выполненным, когда из задачи удаляют проставленную ранее резолюцию.
    {{ ui-key.startrek-backend.messages.sla.issue.on.status.timer.trigger.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-pause }}** | Таймер будет приостановлен, пока задача находится в одном из указанных статусов. После изменения статуса таймер автоматически запустится.
    {{ ui-key.startrek-backend.messages.sla.resolution.set.timer.trigger.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-end }}** | Условие считается выполненным, когда в задаче проставляют одну из указанных в нем резолюций.
    {{ ui-key.startrek-backend.messages.sla.team.commented.timer.trigger.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-end }}** | Условие считается выполненным, когда задачу прокомментировал пользователь, входящий в [команду очереди](queue-team.md).
    {{ ui-key.startrek-backend.messages.sla.issue.has.assignee.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-pause }}** | Таймер будет приостановлен, пока в задаче указан исполнитель. После удаления исполнителя таймер автоматически запустится.
    {{ ui-key.startrek-backend.messages.sla.issue.has.no.assignee.condition.type }} | **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-pause }}** | Таймер будет приостановлен, пока в задаче не указан исполнитель. После назначения исполнителя таймер автоматически запустится.

1. Вы можете настроить обновление таймера при выполнении условий старта. Для этого в блоке **{{ ui-key.startrek.blocks-desktop_sla-editor.restart-header }}** включите опцию **{{ ui-key.startrek.blocks-desktop_sla-editor.restart-checkbox-text }}**. В этом случае после паузы он не продолжит отсчет, а запустится заново.

1. В блоке **{{ ui-key.startrek.blocks-desktop_sla-editor.excesses--title }}** укажите как и кого оповещать о нарушении сроков.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_sla-editor.actions--save }}**.

### Пример {#example}

Создадим правило для контроля времени реакции на новые задачи. Таймер правила запустится, как только задаче будет назначен исполнитель, и остановится, когда исполнитель возьмет задачу в работу. Если за 15 минут исполнитель не отреагирует на задачу, вы получите оповещение по почте.

Чтобы создать правило:

1. В блоке **{{ ui-key.startrek.blocks-desktop_sla-editor.thresholds--title }}** установите предельное время реакции на задачу:
   * Поле **Время до предупреждения** оставьте пустым.

   * В поле **{{ ui-key.startrek.blocks-desktop_sla-editor.thresholds--max }}** введите время реакции, например, `15m`.

1. Настройте таймер:
   * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}** — Назначен исполнитель.

   * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-end }}** — Задача переведена в статус <q>{{ ui-key.startrek.blocks-desktop_sla-editor.example--state-in-progress }}</q>.

   * Блок **{{ ui-key.startrek.blocks-desktop_sla-status-card.pause-condition-title }}** оставьте пустым.

1. Настройте оповещение о срыве срока:
   * **{{ ui-key.startrek.blocks-desktop_sla-editor.excesses--type }}** — Письмо.

   * **{{ ui-key.startrek.blocks-desktop_sla-editor.excesses--recipients }}** — ваш логин в Tracker.

## Просмотреть правила {#section_nbs_r2g_vdb}

Чтобы просмотреть список правил SLA, действующих в очереди:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**. 

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--sla }}**.

Чтобы просмотреть параметры правила, нажмите на его название:

* **{{ ui-key.startrek.blocks-desktop_sla-editor.calendar }}**

    График работы — это время, когда правило активно. В нерабочие часы отсчет времени идти не будет.

* **{{ ui-key.startrek.blocks-desktop_sla-editor.thresholds--title }}**

    Правило может применяться не только ко всем задачам очереди, но и к отдельным группам задач. Для каждой группы можно установить свои сроки выполнения:

    * **Время до предупреждения** (необязательный параметр) — по истечении этого срока {{ tracker-name }} отправит предупреждение, что время обработки задачи на исходе.

    * **{{ ui-key.startrek.blocks-desktop_sla-editor.thresholds--max }}** — предельное время на обработку задачи. По истечении этого времени {{ tracker-name }} отправит уведомление о срыве срока.

* **{{ ui-key.startrek.blocks-desktop_sla-editor.timers--title }}**

    События, при которых таймер будет запускаться, приостанавливаться или останавливаться:

    * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}** — таймер запустится, если выполнено любое из перечисленных условий. Если таймер стоял на паузе, отсчет времени будет возобновлен.

    * **{{ ui-key.startrek.blocks-desktop_sla-status-card.pause-condition-title }}** — таймер приостановится, если выполнено любое из перечисленных условий. Таймер запустится, когда будет выполнено условие из списка **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-start }}**.

        {% note info %}

        Если в качестве условия для паузы выбрано <q>{{ ui-key.startrek-backend.messages.sla.issue.on.status.timer.trigger.condition.type }}</q>, таймер запустится, как только задача будет переведена в любой другой статус.

        {% endnote %}

    * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.sla-condition-end }}** — таймер остановится, если выполнено любое из перечисленных условий.

* **{{ ui-key.startrek.blocks-desktop_sla-editor.excesses--title }}**

    Как и кому {{ tracker-name }} сообщает о нарушении сроков.

## Изменить правило {#edit-rule}

Чтобы изменить правило SLA:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**. 

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--sla }}**.

1. Выберите правило.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_sla.edit-sla }}**.

1. Внесите изменения и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_sla-editor.actions--save }}**.
