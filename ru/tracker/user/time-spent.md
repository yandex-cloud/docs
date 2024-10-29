# Указать затраченное время

{{ tracker-name }} позволяет вести учет времени, которое вы затратили на выполнение задачи.

Для формирования корректной статистики по задаче не вносите данные за другого сотрудника. Важно, чтобы каждый исполнитель самостоятельно регистрировал затраченное время.

Учет времени ведется в рабочих неделях (5 рабочих дней), рабочих днях (8 часов), часах, минутах и секундах.

Управлять учетом времени можно двумя способами:

* [Базовый способ](#limited-spent-time) — использовать действие **Указать затраченное время** в списке действий.
* [Расширенный способ](#extended-spent-time) — использовать раздел **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** на панели справа.

Рекомендуем использовать расширенный способ учета времени: он более гибкий в настройке и простой в использовании.


## Базовый учет времени {#limited-spent-time}

В полях задачи в категории **Учёт времени** отображается запланированное и затраченное на задачу время.

Перед тем как вы начнете работать над задачей, рекомендуем указать время, которое вы планируете затратить на ее решение. По окончании работы вы сможете сравнить предварительную оценку с затраченным временем.

* **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}** — время, которое планируется затратить на выполнение задачи.

* **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** — вы можете указать время, которое осталось потратить на решение задачи. Заполните его в начале или в процессе работы над задачей: 

    * Если в поле **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}** не указано время, то каждый раз, когда вы будете [фиксировать время](#add-limited-time-spent), значение в поле **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** будет уменьшаться на соответствующую величину. 

    * Если в поле **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}** указано время, то значение в поле **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** не будет уменьшаться сразу. Это будет происходить только после того, как вы затратите больше времени, чем указано в поле **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}**.

* **Затрачено времени** — время, которое в итоге было затрачено на решение задачи. Если было добавлено [несколько записей о затраченном времени](#add-limited-time-spent), в этом поле отобразится итоговая сумма.

### Указать затраченное время {#add-limited-time-spent}

Чтобы зарегистрировать затраченное время:

1. Откройте страницу задачи.

1. В правом верхнем углу выберите **{{ ui-key.startrek.ui_Common_smart-components_actions-panel_ActionsPanel.action-menu-title }}** → **{{ ui-key.startrek.ui_Issues_smart-components_issue-actions_IssueMenu.add-worklog }}**.

1. Заполните поле **{{ ui-key.startrek.ui_Issues_smart-components_issue-actions_worklog_AddWorklogDialog.duration-label }}**. 
   
   Например:
   * 1 неделя и 3 дня — `1н 3д`, `1w 3d`.
   * 3 часа 20 минут 30 секунд — `3ч 20м 30с`, `3h 20m 30s`.

1. Заполните поле **{{ ui-key.startrek.ui_Issues_smart-components_issue-actions_worklog_AddWorklogDialog.date-label }}**, указав дату и время в текущем часовом поясе.
   
   {% note info %}

   Дата и время сохраняются в формате [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время). 

   Сохраненное значение можно посмотреть только с помощью [запроса к API](../concepts/issues/issue-worklog.md).

   {% endnote %}

1. При необходимости оставьте комментарий. Комментарий не будет виден в задаче, но сохранится в [Отчете по затратам времени](../manager/statistics.md#section_uxt_3ft_xz) и в [Истории изменений задачи](#records-history).

1. Нажмите кнопку **{{ ui-key.startrek.ui_Issues_smart-components_issue-actions_worklog_AddWorklogDialog.apply-button }}**.

{% note info %}

Вы можете добавить несколько записей. Внесенное время будет суммироваться. 

Сохраненное значение можно изменить только с помощью [запроса к API](../concepts/issues/patch-worklog.md).

{% endnote %}

Регистрировать затраченное время может любой пользователь, а не только исполнитель задачи. В [отчете по затратам времени](../manager/statistics.md#section_uxt_3ft_xz) будут указаны затраты для всех пользователей, отметивших время в задаче.

### Просмотреть затраченное время {#show-time-spent}

Затраченное на задачу время отображается в блоке **Учёт времени** на странице просмотра задачи на панели справа или в [Отчете по затратам времени](../manager/statistics.md#section_uxt_3ft_xz).

Если в задаче не отображается блок **Учёт времени**, добавьте его:

1. Нажмите кнопку ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_Common_smart-components_entity-page_sidebar_SidebarFieldsSelect.add-sidebar-field }}** на панели справа.

1. В группе **{{ ui-key.startrek-backend.fields.issue.fields.timetracking }}** включите опции **{{ ui-key.startrek-backend.fields.issue.spent-key-value }}** и **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}**.

## Расширенный учет времени {#extended-spent-time}

Расширенный учет времени позволяет:

* [Указывать затраченное время прямо на панели в правой части задачи](#add-extended-time-spent).
* [Редактировать и удалять записи о затраченном времени без использования API](#records-history).
* [Автоматически рассчитывать время, затраченное на задачу](../manager/queue-spent-time.md#calculate-time).
* [Отслеживать, сколько времени осталось на выполнение задачи](../manager/queue-spent-time.md#overall-time).
* [Использовать удобную форму отображения времени](../manager/queue-spent-time.md#displayed-time).
* [Вводить время числом без букв](../manager/queue-spent-time.md#number-without-letters).

Чтобы включить расширенный учет времени для задач очереди:

1. Откройте [страницу очереди](queue.md).
1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}**.
1. Перейдите на вкладку **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}**.
1. Включите опцию **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}**.
1. В поле **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-working-calendar }}** выберите один из доступных вариантов.
1. Нажмите **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.save }}**.

После этого в задачах очереди появится новый раздел **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}**. В него будут перенесены все данные полей задачи из категории **Учёт времени**.

Чтобы перейти обратно на базовый учет времени, в настройках очереди отключите опцию **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}**. Данные из раздела **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** будут перенесены в поля категории **Учёт времени**.

### Указать затраченное время {#add-extended-time-spent}

Чтобы зарегистрировать затраченное время:

1. Убедитесь, что в настройках очереди включена опция **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}**.
1. Откройте страницу задачи.
1. На панели справа нажмите **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}**.
1. Заполните поле **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.save }}**.
    
    Например:
    
    * 1 неделя и 3 дня — `1н 3д`, `1w 3d`.
    * 3 часа 20 минут 30 секунд — `3ч 20м 30с`, `3h 20m 30s`.
    * Четыре [предпочтительных единицы времени](../manager/queue-spent-time.md#displayed-time) — `4`.

1. В поле **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-datetime-title }}** укажите дату и время, которые будут отображаться в записи по учету времени.
1. При желании в поле **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-comment-title }}** добавьте комментарий к записи.
1. Нажмите **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.save }}**.

Вы также можете указывать затраченное время [способом из базового учета времени](#add-limited-time-spent).

### Смотреть и редактировать историю записей {#records-history}

Чтобы открыть историю всех записей об учтенном для задачи времени, на панели справа в правой части поля **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** нажмите ![](../../_assets/tracker/svg/history.svg). Откроется окно **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-comment-title }}**.

{% note alert %}

Редактировать историю записей можно, только если в [настройках учета времени](../manager/queue-spent-time.md) включена опция **{{ ui-key.startrek.ui_Common_smart-components_timetracking-history-dialog_TimeTrackingHistoryDialog.title }}**.

{% endnote %}

Автор записи может изменить у записей поля **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-can-assignee-update-time }}** и **{{ ui-key.startrek.ui_Common_smart-components_timetracking-history-dialog_TimeTrackingDialogBody.column-date }}**. Чтобы сделать это, справа от значения нужного поля нажмите ![](../../_assets/tracker/svg/icon-edit2.svg) и введите новое значение. Поле **{{ ui-key.startrek.ui_Common_smart-components_timetracking-history-dialog_TimeTrackingDialogBody.column-spent }}** изменить нельзя.

Если запись была отредактирована, то справа от значения поля **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-can-assignee-update-time }}** появится значок ![](../../_assets/tracker/svg/history.svg). Если навести на него указатель, появится всплывающее окно с историей изменений записи.

Также автор записи может удалить ее. Чтобы сделать это, в правой части записи нажмите ![](../../_assets/tracker/svg/actions.svg) → **{{ ui-key.startrek.ui_Common_smart-components_timetracking-history-dialog_TimeTrackingDialogBody.column-comment }}**.