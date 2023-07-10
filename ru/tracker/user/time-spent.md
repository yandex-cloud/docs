# Указать затраченное время

{{ tracker-name }} позволяет вести учет времени, которое вы затратили на выполнение задачи.

Для формирования корректной статистики по задаче не вносите данные за другого сотрудника. Важно, чтобы каждый исполнитель самостоятельно регистрировал затраченное время.

Учет времени ведется в рабочих неделях (5 рабочих дней), рабочих днях (8 часов), часах, минутах и секундах.

## Учет времени {#spent-time}

В блоке **{{ ui-key.startrek.blocks-desktop_b-screen.worklog }}** отображается запланированное и затраченное на задачу время.

Перед тем как вы начнете работать над задачей, рекомендуем указать время, которое вы планируете затратить на ее решение. По окончании работы вы сможете сравнить предварительную оценку с затраченным временем.

* **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}** — время, которое планируется затратить на выполнение задачи.

* **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** — вы можете указать время, которое осталось потратить на решение задачи. Заполните его в начале или в процессе работы над задачей: 

    * Если в поле **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}** не указано время, то каждый раз, когда вы будете [фиксировать время](#add-time-spent), значение в поле **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** будет уменьшаться на соответствующую величину. 

    * Если в поле **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}** указано время, то значение в поле **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** будет уменьшаться на соответствующую величину после того, как вы потратите больше времени, чем первоначальная оценка.

* **{{ ui-key.startrek.blocks-desktop_i-ticket-subscription.worklogs }}** — время, которое в итоге было затрачено на решение задачи. Если было добавлено [несколько записей о затраченном времени](#add-time-spent), в этом поле отобразится итоговая сумма.

## Указать затраченное время {#add-time-spent}

Чтобы зарегистрировать затраченное время:

1. Откройте страницу задачи.

1. В правом верхнем углу выберите **{{ ui-key.startrek.ui_components_actions-panel_ActionsPanel.action-menu-title }}** → **{{ ui-key.startrek.ui_components_IssueMenu.add-worklog }}**.

1. Выберите дату создания записи.

1. Заполните поле **{{ ui-key.startrek.ui_components_AddWorklogDialog.duration-label }}**. 
   
   Например:
   * 1 неделя и 3 дня — `1н 3д`, `1w 3d`.
   * 3 часа 20 минут 30 секунд — `3ч 20м 30с`, `3h 20m 30s`.

1. При необходимости оставьте комментарий. Комментарий не будет виден в задаче, но сохранится в [Отчете по затратам времени](../manager/statistics.md#section_uxt_3ft_xz).

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_AddWorklogDialog.apply-button }}**.

{% note info  %}

Вы можете добавить несколько записей. Внесенное время будет суммироваться. 

Сохраненное значение можно изменить только с помощью [запроса к API](../concepts/issues/patch-worklog.md).

{% endnote %}

Регистрировать затраченное время может любой пользователь, а не только исполнитель задачи. В [отчете по затратам времени](../manager/statistics.md#section_uxt_3ft_xz) будут указаны затраты для всех пользователей, отметивших время в задаче.

## Просмотреть затраченное время {#show-time-spent}

Затраченное на задачу время отображается в блоке **{{ ui-key.startrek.blocks-desktop_b-screen.worklog }}** на странице просмотра задачи на панели справа или в [Отчете по затратам времени](../manager/statistics.md#section_uxt_3ft_xz).

Если в задаче не отображается блок **{{ ui-key.startrek.blocks-desktop_b-screen.worklog }}**, добавьте его:

1. Нажмите кнопку ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_IssueSidebar.add-sidebar-field }}** на панели справа.

1. В группе **{{ ui-key.startrek-backend.fields.issue.fields.timetracking }}** включите опции **{{ ui-key.startrek-backend.fields.issue.spent-key-value }}** и **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}**.
