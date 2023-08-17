# Локальные поля задач

Если требуется добавить в задачи новый параметр, которого нет среди существующих в {{ tracker-name }} полей, вы можете добавить локальные поля в вашу очередь.

{% note info %}

Список существующих глобальных полей можно посмотреть на странице [Настройки {{ tracker-name }}]({{ link-admin-fields }}).

{% endnote %}

Локальное поле можно использовать только в задачах той очереди, к которой оно привязано. Преимущество локальных полей в том, что владелец очереди может управлять такими полями без риска повлиять на процессы работы в других очередях. Пользователи, которые работают в других очередях, не будут видеть это поле в своих задачах.

## Добавить локальное поле {#add-local-field}

{% note alert %}

По умолчанию настраивать очередь может [только ее владелец](manager/queue-access.md).

{% endnote %}

1. Откройте [страницу очереди](user/queue.md).

1. В правом верхнем углу страницы нажмите ![](../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--fields }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.button--create-field }}**.

1. Выберите тип поля и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_field-create-modal.button--next }}**.

1. Задайте параметры нового поля:
    * **{{ ui-key.startrek.blocks-desktop_field-create-form.label--category }}**. Все поля в {{ tracker-name }} сгруппированы по категориям. Выберите категорию, которая лучше всего подходит для нового поля.

    * **{{ ui-key.startrek.blocks-desktop_field-create-form.label--name }}**. Старайтесь давать полям короткие и емкие названия.

    * **{{ ui-key.startrek.blocks-desktop_field-create-form.label--name-eng }}**. Это название видно в английском интерфейсе {{ tracker-name }}.

    * **{{ ui-key.startrek.blocks-desktop_field-create-form.label--number-type }}** (только для полей типа <q>{{ ui-key.startrek.blocks-desktop_field-create-form.field-type-number }}</q>).

    * **{{ ui-key.startrek.blocks-desktop_field-create-form.label--options }}** (только для полей типа <q>{{ ui-key.startrek.blocks-desktop_field-create-form.field-type-option-list }}</q>) — укажите возможные значения и их порядок.

    * **{{ ui-key.startrek.blocks-desktop_field-create-form.label--option-list }}** (только для полей типа <q>{{ ui-key.startrek.blocks-desktop_field-create-form.field-type-option-list }}</q>).
    
    * **{{ ui-key.startrek.blocks-desktop_field-create-form.label--users-count }}** (только для полей типа <q>выбор сотрудников</q>).

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_field-create-modal.button--create }}**.

## Редактировать локальное поле {#edit-local-field}

Редактирование параметров локального поля через веб-интерфейс {{ tracker-name }} не поддерживается. Для этого можно использовать [{{ api-name }}](concepts/queues/edit-local-field.md).


## Ограничения локальных полей {#restrictions}

#### Особенности использования локальных полей

* Для поиска задач по локальному полю с помощью языка запросов нужно [указать очередь перед ключом или названием поля](user/query-filter.md#local_fields).

* При [переносе](user/move-ticket.md) и [клонировании](user/clone.md) задачи с локальными полями в другую очередь значения локальных полей будут удалены.

* При использовании [макросов](manager/create-macroses.md), [триггеров](user/trigger.md) или [автодействий](user/autoactions.md), чтобы подставить значение локального поля в [комментарий](user/set-action.md#create-comment), [формулу](user/set-action.md#section_calc_field) или [HTTP-запрос](user/set-action.md#create-http) с помощью [переменной](user/vars.md#local-fields), используйте формат записи `{{issue.local.<ключ поля>}}`. 

#### Где нельзя использовать локальные поля

Локальные поля временно не поддерживаются в некоторых сценариях работы с задачами. Поддержка этих сценариев будет добавлена позже.

* При создании доски задач не получится настроить автоматическое добавление задач по значению локального поля. Это условие можно будет добавить позже, на [странице редактирования](manager/edit-agile-board.md#board-settings) доски с помощью [языка запросов](user/query-filter.md).

* На доске задач локальные поля не отображаются на [карточках](manager/edit-agile-board.md#sec_layout).

* Локальные поля нельзя использовать в [правилах SLA](sla-head.md).

* Значения локальных полей нельзя изменять с помощью [групповых операций](manager/bulk-change.md).

## Как обращаться к локальным полям через API {#local-fields-api}

При работе с локальными полями через [API {{ tracker-name }}](about-api.md) доступно два типа действий:

* Присвоить значение локальному полю.  
  
  Чтобы получить или изменить значение локального поля в задаче через API, в теле [запроса](concepts/issues/patch-issue.md) укажите его идентификатор в формате `603fb94c38bbe658d04da2e6--<ключ поля>: "<новое значение локального поля>"`.

  Чтобы узнать идентификатор локального поля, выполните запрос, который позволяет получить [список локальных полей в определенной очереди](concepts/queues/get-local-fields.md).

* Изменить параметры локального поля, например название, описание, или множество доступных значений поля. Подробнее в [справочнике API {{ tracker-name }}](concepts/queues/edit-local-field.md).
