# Макросы

Макрос в {{ tracker-name }} — это запрограммированный набор операций, который можно запустить на странице задачи. Используйте макросы, чтобы автоматизировать рутинные действия. Макросы позволяют в одно нажатие изменять параметры задачи, создавать типовые комментарии.

## Создать макрос {#section_inq_5b1_x2b}

{% note warning %}

По умолчанию настраивать очередь может [только ее владелец](queue-access.md).

{% endnote %}

У каждой очереди в {{ tracker-name }} свой набор макросов. Чтобы создать для очереди новый макрос:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. На панели слева выберите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}** и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.button-create }}**.

1. Настройте параметры нового макроса:
    - **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_name }}**.
    - **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_body }}** — текст сообщения (комментария ), которое будет создано при выполнении макроса. Если вы не хотите, чтобы макрос создавал сообщение, оставьте поле пустым.
        В текст сообщения можно подставлять [значения полей задачи](../user/vars.md). Для этого нажмите кнопку **{{ ui-key.startrek.blocks-desktop_trigger-action.action_add-variable }}** и выберите одно или несколько значений. В поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_body }}** появится конструкция вида `{{issue.ключ_поля}}`.
    - **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_actions }}** — выберите, какие поля задачи будет изменять макрос, и укажите их новые значения.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.action_create }}**.


## Изменить и удалить макрос {#section_swl_sdb_x2b}

{% note warning %}

По умолчанию настраивать очередь может [только ее владелец](queue-access.md).

{% endnote %}

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. На панели слева выберите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}** и наведите указатель на нужный макрос.

1. Чтобы изменить макрос, нажмите на значок ![](../../_assets/tracker/icon-edit.png).
   Чтобы удалить макрос, нажмите на значок ![](../../_assets/tracker/icon-delete.png).


## Выполнить макрос {#section_ekq_22b_x2b}

С помощью макросов вы можете изменять параметры задачи, создавать типовые комментарии. Выполнить макрос может любой пользователь, у которого есть доступ к изменению задачи.

Чтобы выполнить макрос:

1. Откройте страницу задачи.

1. Перейдите к полю для ввода комментария.

1. Нажмите ![](../../_assets/tracker/svg/macros.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}** и выберите макрос из раскрывающегося списка. 
    Вы можете выбрать несколько макросов одновременно. Если макросы изменяют один и тот же параметр, к параметру будет применен макрос, который выбран последним.


1. Чтобы выполнить макрос, нажмите кнопку **{{ ui-key.startrek.ui_components_macros_Dialog.apply-button-label }}**.


## Пример макроса {#macro_example}


Предположим, что сотрудник первой линии службы поддержки хочет перевести обращение пользователя в {{ tracker-name }} на сотрудника второй линии. Настроим макрос, который будет выполнять это действие:

1. Откройте очередь. 

1. В разделе **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}** нажмите кнопку [**{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.button-create }}**](#section_inq_5b1_x2b).

1. Задайте название макроса.

1. Напишите текст сообщения, которое будет добавлено в комментарий к задаче. Вы можете добавить параметры задачи с помощью кнопки **{{ ui-key.startrek.blocks-desktop_trigger-action.action_add-variable }}**.

1. Чтобы макрос назначил задачу на определенного сотрудника второй линии поддержки, в блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_actions }}** выберите поле **{{ ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek-backend.fields.issue.assignee-key-value }}** и укажите имя сотрудника.

1. Чтобы макрос изменил статус задачи, в блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_actions }}** выберите поле **{{ ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-status }}** и установите значение **Вторая линия поддержки**.
   Если в списке значений нет нужного статуса, [настройте воркфлоу](add-workflow.md). 
 
   ![](../../_assets/tracker/macro-example-line2.png)

1. Сохраните макрос. 

Чтобы выполнить созданный макрос:

1. Откройте страницу задачи.

1. Перейдите к полю для ввода комментария.

1. Нажмите ![](../../_assets/tracker/svg/macros.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}** и выберите макрос из раскрывающегося списка.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_macros_Dialog.apply-button-label }}**. Задача будет переведена на вторую линию поддержки.