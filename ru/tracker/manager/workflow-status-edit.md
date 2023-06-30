# Настроить статусы

{% note warning %}

По умолчанию настраивать очередь может [только ее владелец](queue-access.md).

{% endnote %}

Для каждого воркфлоу вы можете задать набор допустимых статусов. Эти статусы можно будет назначить задачам, к которым применяется ваш воркфлоу.


## Создать статус {#create-status}

{% note warning %}

Создавать новые статусы задач может только [администратор](../role-model.md). Созданный статус нельзя удалить или отредактировать.

{% endnote %}

Статус — это атрибут задачи, который обозначает, на каком этапе находится выполнение задачи. Например: <q>{{ ui-key.startrek-backend.applinks.samsara.status.open }}</q>, <q>{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}</q>, <q>{{ ui-key.startrek-backend.presets.developmentPreset.board.column.testing }}</q>, <q>{{ ui-key.startrek-backend.applinks.samsara.status.closed }}</q>.

По умолчанию в {{ tracker-name }} доступны наиболее популярные статусы задач. Если подходящего статуса среди них нет, создайте новый:

1. Убедитесь, что вы авторизованы в {{ tracker-full-name }} как [администратор](../role-model.md).

1. На панели справа выберите ![](../../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue.cp }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.tracker-settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-issue-statuses }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_page-admin-tab.create--statuses }}**.

1. Заполните поля и нажмите **{{ ui-key.startrek.blocks-desktop_b-form-new-component.button-create }}**.


## Добавить статус в воркфлоу {#section_dcl_jdv_vbb}

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. На панели **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** нажмите кнопку **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-add-status }}**.

1. Заполните поля:

    Поле | Описание
    ----- | -----
    **Выберите новый статус** | Выберите один из доступных статусов.
    **Статус до перехода** | Выберите из какого статуса будет осуществляться переход. Если таких статусов несколько, вы сможете [добавить их позже](workflow-action-edit.md#section_en2_fhb_wbb).
    **{{ ui-key.startrek.blocks-desktop_workflow-editor.add-status-popup--name }}** | Название кнопки в интерфейсе {{ tracker-name }}, которая будет переводить задачу в этот статус. Это же название используется для обозначения перехода в редакторе.
    **{{ ui-key.startrek.blocks-desktop_workflow-editor.add-status-popup--name-en }}** | Название кнопки в английском интерфейсе {{ tracker-name }}, которая будет переводить задачу в этот статус.
    
   
   По умолчанию в {{ tracker-name }} доступны наиболее популярные статусы. Если нужного вам статуса среди них нет, администратор может [создать его](#create-status).

   
1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Изменить статус в воркфлоу {#section_q4q_nfv_vbb}

#### Сделать начальным статусом

Начальный статус — статус, в котором находится только что созданная задача. Чтобы сделать статус начальным:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Наведите указатель на нужный статус.

1. Нажмите на появившийся значок ![](../../_assets/tracker/initial-ststus-icon.png).

#### Настроить действие при комментировании

Вы можете настроить автоматическое изменение статуса задачи при комментировании:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Выберите статус на панели **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.tab-title--actions-on-comment }}**.

1. В списке **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.select-action }}** выберите один из вариантов:

    - <q>{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.make-no-transition }}</q> — новые комментарии не будут менять статус задачи.

    - <q>{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.prev-status }}</q> — задача будет переведена в свой предыдущий статус.

    - <q>{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.make-transition }}</q> — при добавлении комментария задача будет переведена в выбранный статус.

1. При необходимости включите опции **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.revert-assignee }}** и **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_actions-on-comment.on-assignee-comment-only }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

#### Добавить переход

Вы можете добавить переход между статусами, которые заданы для вашего воркфлоу:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Выберите исходный статус на панели **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.tab-title--create-action }}**.

1. Настройте новый переход:

    Поле | Описание
    ---- | --------
    **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_general.target-status--label }}** | Укажите статус, в который осуществляется переход.
    **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_general.name-ru--label }}** | Название кнопки в интерфейсе {{ tracker-name }}, которая будет переводить задачу в этот статус. Это же название используется для обозначения перехода в редакторе.
    **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_general.name-en--label }}** | Название кнопки в английском интерфейсе {{ tracker-name }}, которая будет переводить задачу в этот статус.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

1. Если вы хотите добавить к переходу условия или автоматические действия, [отредактируйте переход](workflow-action-edit.md).

## Удалить статус из воркфлоу {#section_mqt_5fv_vbb}

{% note warning %}

Нельзя удалить начальный статус или статус, из которого есть переходы.

{% endnote %}

Чтобы удалить статус из воркфлоу:

1. Выберите воркфлоу и нажмите кнопку ![](../../_assets/tracker/button-edit.png).

1. Наведите указатель на нужный статус.

1. Нажмите на появившийся значок ![](../../_assets/tracker/remove-task-type.png).

1. Подтвердите удаление.