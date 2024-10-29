# Настроить учет времени

Для более удобной работы с [учетом времени](../user/time-spent.md) вы можете включить [расширенный учет времени](../user/time-spent.md#extended-spent-time) и настроить его параметры.

Чтобы сделать это:

1. В настройках очереди перейдите на вкладку **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}**.
1. Включите опцию **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}**.
1. В поле **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-working-calendar }}** выберите один из доступных вариантов.
1. Нажмите **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.save }}**.

После этого в задачах очереди появится новый раздел **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}**. В него будут перенесены все данные полей задачи из категории **Учёт времени**.

Если вы отключите опцию **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}**, данные из раздела **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** будут перенесены обратно в поля категории **Учёт времени**.

## Разрешить исполнителю редактировать время {#assignee-edit}

По умолчанию редактировать [историю записей по учету времени](../user/time-spent.md#records-history) можно только через [запрос к API](../concepts/issues/patch-worklog.md).

Чтобы автор записи мог отредактировать или удалить ее прямо в окне истории записей, включите опцию **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-can-assignee-update-time }}**.

## Автоматически рассчитывать затраченное время при закрытии задачи {#calculate-time}

Вы можете сделать так, чтобы затраченное на задачу время рассчитывалось автоматически. При закрытии задачи, если в ней не учтено никакое время, на [экране перехода](workflow-action-edit.md) появится поле **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-spent-title }}** с уже заполненным значением.

Чтобы сделать это, включите опцию **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-show-time-field-on-close }}** и [настройте экран перехода](workflow-action-edit.md) в финальный статус задачи.

{% cut "Как рассчитывается время" %}

При включении этой опции время, затраченное на задачу, рассчитывается следующим образом:

* За точку отсчета берется момент, в который задача была переведена из начального статуса в статус с типом ![](../../_assets/tracker/changelogs/status-2-in-progress.svg).
* За конечную точку берется момент, в который задача была переведена в статус с типом ![](../../_assets/tracker/changelogs/status-4-solved.svg).
* Между этими двумя точками учитывается только рабочее время, установленное в [графике работы](#work-schedule).

Например, в пятницу 1 июня в 9:00 задача была переведена из статуса **Открыт** в статус **В работе**. А в понедельник 4 июня в 14:00 была переведена в статус **Закрыт**. При этом для очереди настроен следующий график: «Будни, 8:00–17:00».

{{ tracker-name }} учтет два отрезка времени: 1 июня с 9:00 до 17:00 и 4 июня с 8:00 до 14:00. 2 и 3 июня учтены не будут, потому что суббота и воскресенье — выходные. Итого будет считаться, что на задачу потрачено 14 часов.

{% endcut %}

## Учитывать оставшееся и общее время выполнения задачи {#overall-time}

Вы можете добавить в раздел **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** дополнительные поля:

* В поле **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-remain-title }}** можно указывать, сколько еще времени вы рассчитываете работать над этой задачей. Чтобы добавить его, включите опцию **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-show-time-field-on-close }}**.
* В поле **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-estimation-title }}** можно указывать, сколько всего времени вы рассчитываете работать над этой задачей. Чтобы добавить его, включите опцию **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-use-remaining-time }}**.

Если используется хотя бы одно из этих полей, то на странице задачи в поле **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** появится полоса прогресса задачи.

{% note info %}

Поля **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-remain-title }}** и **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-estimation-title }}** связаны друг с другом следующим образом:

**{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-spent-title }}** + **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-remain-title }}** = **{{ ui-key.startrek.ui_Common_smart-components_FormField_TimeTrackingBlock.field-estimation-title }}**

Если используются оба поля, то при изменении значения одного из них будет автоматически установлено значение для другого.

{% endnote %}

## Настроить график работы {#work-schedule}
Вы можете настроить график, по которому работают исполнители задач этой очереди. Эти данные используются при [автоматическом расчете затраченного времени](#calculate-time). Чтобы установить его, в поле **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-working-calendar }}** выберите подходящий вариант.

Если ни один из вариантов графика работы вам не подходит, вы можете [создать свой](schedule.md).

## Выбрать отображение времени {#displayed-time}

По умолчанию время отображается в виде **1н 2д 3ч 4м 5с**: рабочих неделях, рабочих днях, часах, минутах и секундах. Чтобы изменить это, в поле Отображаемое время выберите один из вариантов.

## Записывать время без букв {#number-without-letters}

В базовом учете времени вы не можете указать время просто числом и всегда должны уточнить, что именно записываете: недели, дни, часы, минуты или секунды.

В расширенном учете времени вы можете выбрать предпочитаемую единицу времени и вводить ее числом без необходимости добавлять букву. Чтобы сделать это, в поле **{{ ui-key.startrek.ui_Queues_pages_queue-admin-tab-timetracking_TimetackingForm.field-use-summary-time }}** выберите один из вариантов.