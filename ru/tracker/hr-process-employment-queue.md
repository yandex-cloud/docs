# Настроить автоматическое создание задач

Для организации процессов оформления и введения в курс дела новых сотрудников создайте очередь, в которой вы будете отслеживать процедурные вопросы, выдачу оборудования и допусков, а также ход испытательного срока. Настройте автоматическое создание соответствующего пула задач по факту закрытия задачи кандидата с резолюцией "Принят".

## Создайте очередь для новых сотрудников

1. [Создайте очередь](manager/create-queue.md) с помощью шаблона <q>{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--hr-preset }}</q>. 
1. В качестве имени укажите, например, `Employment Queue`.
1. Если нужно, настройте [рабочий процесс](manager/workflows.md#section_hr) или создайте [новый](manager/add-workflow.md).
1. Для рабочего процесса укажите тип задачи, например `Новые сотрудники`. Сохраните ключ типа задачи, он понадобится при создании триггеров.
1. Настройте [допуск к очереди](manager/queue-access.md) для защиты персональных данных сотрудников.

## Добавьте типы задач

Для различных процедур, связанных с оформлением и введением сотрудника в рабочий режим, создайте отдельные типы задач. Например, для выдачи доступов и оборудования создайте тип задачи <q>Доступы и оборудование</q>:

1. На странице очереди новых сотрудников `Employment Queue` в правом верхнем углу нажмите ![](../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. На панели слева выберите **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-types }}**.
1. Дождитесь загрузки страницы и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.add-issue-type }}**.
1. В появившейся форме:
   * в поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_events.issue-types-config--title--type }}** введите название нового типа, например, `Доступы и оборудование` и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.add-issue-type }}**. В появившейся форме создания типа задачи скопируйте и сохраните ключ задачи;
   * в поле  **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_events.issue-types-config--title--workflow }}** выберите подходящий рабочий процесс, например, `Quick Start`;
   * в поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_events.issue-types-config--title--resolutions }}** выберите нужные резолюции, например, `{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}`.

Аналогично добавьте еще нужные вам типы задач, например `Оформление документов`, `Испытательный срок` и т. д.
Чтобы сохранить новые типы, нажмите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.save }}**.

{% note info %}

Будут сохранены только те типы задач, для которых выбран рабочий процесс и хотя бы одна резолюция.
Типы задач должны быть уникальными.

{% endnote %}


## Настройте триггер в очереди кандидатов

Для автоматизации копирования задачи из очереди кандидатов `Candidates Queue` в очередь сотрудников `Employment Queue` создайте триггер, срабатывающий на переход статуса задачи кандидата в состояние "Принят":

1. На странице очереди кандидатов `Candidates Queue` в правом верхнем углу нажмите ![](../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. На панели слева выберите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**.
1. В поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_name }}** введите название триггера, например `employ_candidate`.
1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}** выберите **{{ui-key.startrek-backend.fields.issue.fields.system }}**  → **{{ ui-key.startrek-backend.fields.issue.status-key-value }}**.
1. В появившемся поле **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldChangedCondition }}** выберите опцию **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}**, а в новом поле рядом выберите опцию **Принят** (статус, который вы создали в рабочем процессе очереди кандидатов).
1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_actions }}** выберите **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--webhook }}**.
1. В открывшейся форме укажите параметры запроса. В поле **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-body }}** укажите параметры создаваемой подзадачи. Для подстановки значений из исходной задачи используйте [переменные](user/vars.md):

    #|
    || **Поле** | **Содержание** ||
    || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-method }} | {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-method--post }} ||
    || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-url }} | `{{ host }}/{{ ver }}/issues` ||
    || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-auth }} | {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-auth--oauth }} ||
    || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-token }} | <OAuth_токен> (см. [Руководство по получению токена](concepts/access.md#section_about_OAuth)) ||
    || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-token-header }} | Authorization ||
    || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-token-type }} | OAuth ||
    || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-content-type }} | application/json ||
    || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-body }} |
    >```
    >{
    >    "queue":"<ключ_очереди_Employment_Queue>",
    >    "summary":"not_var{{issue.summary.json}}",
    >    "description":"not_var{{issue.description.json}}",
    >    "type":"<ключ_задачи_Новые_сотрудники>",
    >    "parent":"not_var{{issue.key}}"
    >}
    >```
    ||
    || Заголовки | Заголовок: `X-Org-ID` или `X-Cloud-Org-ID`.
    Значение: Идентификатор организации. Если у вас только организация {{ org-full-name }}, используйте заголовок `X-Cloud-Org-ID`, если только {{ ya-360 }} или оба типа организаций — `X-Org-ID`. Идентификатор можно найти на странице [**Администрирование** → **Организации**]({{ link-admin-settings }}). ||
    |#

    {% note info %}

    Параметры, которые вы передаете в теле запроса при помощи переменных, должны быть заполнены в исходной задаче. Иначе триггер не сработает.

    {% endnote %}

1. Чтобы сохранить триггер, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.  


## Настройте триггер в очереди сотрудников

После того как задача кандидата скопирована в очередь сотрудников `Employment Queue`, вам нужно создать в этой же очереди несколько подзадач, связанных с новым сотрудником: `Доступы и оборудование`, `Оформление документов`, `Испытательный срок` и т. д. Чтобы автоматизировать создание подзадач, создайте триггер, срабатывающий на переход статуса задачи нового сотрудника в состояние "В работе". Чтобы триггер срабатывал только для задач типа `Новые сотрудники`, укажите этот тип в условиях триггера.

### Создайте триггер 

1. На странице очереди сотрудников `Employment Queue` в правом верхнем углу нажмите ![](../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. На панели слева выберите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**.
1. В поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_name }}** введите название триггера, например `start_employment`.
1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}** выберите **{{ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek-backend.fields.issue.status-key-value }}**.
1. В появившемся поле **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldChangedCondition }}** выберите опцию **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}**, а в новом поле рядом выберите опцию **В работе** (статус, который вы создали в рабочем процессе очереди кандидатов).
1. Добавьте еще одно условие: в блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}** выберите **{{ ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek-backend.fields.issue.type-key-value }}**.
1. В появившемся поле **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldChangedCondition }}** выберите опцию **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldEquals }}**, а в новом поле рядом выберите опцию **Новые сотрудники**.
1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_actions }}** в поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_add-action }}** выберите **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--webhook }}**.
1. В открывшейся форме укажите параметры запроса так же, как было сделано выше. В поле **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-body }}** измените описание (`description`) и ключ типа задачи (`type`), например: 

```
{
    "queue":"<ключ_очереди_Employment_Queue>",
    "summary":"not_var{{issue.summary.json}}",
    "description":"Выдать доступы и оборудование",
    "type":"<ключ_задачи_Доступы_и_оборудование>",
    "parent":"not_var{{issue.key}}"
}
```

### Добавьте действия

Для автоматического создания других подзадач добавьте соответствующие действия в триггер:

1. Внизу в поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_add-action }}** выберите **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--webhook }}**.
1. Заполните форму так же, как было сделано выше. В поле **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-body }}** измените описание и ключ типа задачи, например:

```
{
   "queue":"<ключ_очереди_Employment_Queue>",
   "summary":"not_var{{issue.summary.json}}",
   "description":"Испытательный срок",
   "type":"<ключ_типа_задачи_Испытательный_срок>",
   "parent":"not_var{{issue.key}}"
}
```
1. Аналогично добавьте действия для прочих задач.
1. Чтобы сохранить триггер, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.  

## Проверьте действие триггеров

1. На странице очереди новых сотрудников `Candidate Queue` выберите тестовую задачу и измените статус на **Принят**.
1. Убедитесь, что на странице очереди сотрудников `Employment Queue` появилась новая задача.
1. Откройте задачу и в поле статуса выберите **В работу**.
1. Убедитесь, что в очереди появились все необходимые подзадачи.
