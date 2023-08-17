# Настроить переходы

{% note warning %}

По умолчанию настраивать очередь может [только ее владелец](queue-access.md).

{% endnote %}

С помощью переходов вы можете настроить правила изменения статусов задачи: условия перехода между статусами, автоматические действия, которые выполняются при изменении статуса, экран перехода для заполнения заданных полей пользователем.

## Добавить переход {#section_en2_fhb_wbb}

Вы можете добавить переход между статусами, которые заданы для вашего воркфлоу:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Выберите исходный статус на панели **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.tab-title--create-action }}**.

1. Настройте новый переход:

    Поле | Описание
    ----- | -----
    **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_create-action.target-status--label }}** | Укажите статус, в который осуществляется переход.
    **{{ ui-key.startrek.blocks-desktop_b-queue-issue-type__workflow-table.button-name }}** | Название кнопки в интерфейсе {{ tracker-name }}, которая будет переводить задачу в этот статус. Это же название используется для обозначения перехода в редакторе.
    **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_create-action.name-en--label }}** | Название кнопки в английском интерфейсе {{ tracker-name }}, которая будет переводить задачу в этот статус.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

1. Если вы хотите добавить к переходу условия или автоматические действия, [отредактируйте переход](workflow-action-edit.md).

## Настроить кнопку перехода {#section_k1g_khb_wbb}

Вы можете изменить статус, в который выполняется переход, и название кнопки перехода:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Выберите переход из правого столбца на панели **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--general }}**.

1. Настройте параметры перехода:

    Поле | Описание
    ----- | -----
    **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_create-action.target-status--label }}** | Укажите статус, в который осуществляется переход.
    **{{ ui-key.startrek.blocks-desktop_b-queue-issue-type__workflow-table.button-name }}** | Название кнопки в интерфейсе {{ tracker-name }}, которая будет переводить задачу в этот статус. Это же название используется для обозначения перехода в редакторе.
    **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_create-action.name-en--label }}** | Название кнопки в английском интерфейсе {{ tracker-name }}, которая будет переводить задачу в этот статус.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Настроить автоматические действия {#section_ems_23b_wbb}

Вы можете настроить автоматические действия, которые выполняет {{ tracker-name }} при переходе из статуса в статус. Это может быть изменение полей задачи, установка резолюций и так далее.

Чтобы добавить автоматическое действие:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Выберите переход из правого столбца на панели **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--functions }}**.

1. Выберите одну или несколько функций из выпадающего списка.

1. Настройте параметры функций и нажмите **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Задать условия перехода {#section_jrk_hmb_wbb}

Вы можете ограничить условия, при которых переход будет активен. Например, переход может быть доступен ограниченному списку сотрудников или только сотрудникам с определенными ролями.

#### Добавить условие

Чтобы добавить одно или несколько условий:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Выберите переход из правого столбца на панели **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--conditions }}**.

1. Укажите, как должны проверяться условия:

    - **{{ ui-key.startrek.blocks-desktop_workflow-condition.type--all }}** — необходимо выполнение всех условий;

    - **{{ ui-key.startrek.blocks-desktop_workflow-condition.type--any }}** — необходимо выполнение хотя бы одного условия.

1. Выберите одно или несколько условий из выпадающего списка.

    Кроме простых условий вы можете добавить [группу](#dlentry_jt4_jrb_wbb).

1. Настройте условия и нажмите **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

#### Добавить группу условий {#dlentry_jt4_jrb_wbb}

Вы можете группировать условия, чтобы логически их объединять.

Чтобы добавить группу условий:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Выберите переход из правого столбца на панели **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--conditions }}**.

1. В списке **{{ ui-key.startrek.ui_components_workflow-conditions_ConditionsMenu.add-condition }}** выберите **Условия, объединенные логическим И/ИЛИ**.

1. Добавьте условия в группу и выберите, как должны проверяться условия внутри группы.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Настроить экран перехода {#section_uf2_sks_gcb}

Экран перехода — это всплывающее окно, с помощью которого вы можете предложить пользователю изменить определенные параметры задачи. Например, на экране перехода можно попросить пользователя проставить резолюцию, оставить комментарий или записать потраченное время.

Чтобы настроить экран перехода:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Выберите переход из правого столбца на панели **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--screen }}**.

1. Включите опцию **Показывать экран для этого перехода**.

1. Настройте параметры экрана:
    
   Название | Описание
   ----- | -----
   **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.screen-title--label-ru }}** | Текст в заголовке всплывающего окна
   **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.screen-title--label-en }}** | Текст в заголовке всплывающего окна в английском интерфейсе
   **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.screen-elements-title }}** | Выберите поля, которые можно будет настроить на экране перехода. При необходимости задайте для полей значения по умолчанию.<br/><br/>Чтобы сделать поле обязательным для заполнения, поставьте отметку справа от поля.
   **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.worklogs-enable }}** | Включите опцию, чтобы на экране перехода появилась форма учета времени.
   **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.linking-enable }}** | Включите опцию, чтобы на экране перехода появилась форма добавления связей с другим и задачами.
   **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.comment-enable }}** | Включите опцию, чтобы на экране перехода появилось поле для комментария.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Удалить переход {#section_del_fl_1}

Убедитесь, что после удаления перехода не окажется статусов, в которые нельзя перейти.

1. Нажмите ![](../../_assets/tracker/delete-agile-status.png) рядом с названием перехода.

1. Подтвердите удаление.



