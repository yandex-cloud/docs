# Настроить типы задач

{% note warning %}

По умолчанию настраивать очередь может [только ее владелец](queue-access.md).

{% endnote %}

В очередь могут входить задачи разных типов, например <q>Новая возможность</q>, <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--improvement }}</q> или <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--bug }}</q>. Каждому типу задач соответствует свой [воркфлоу](./workflows.md) и набор [резолюций](./create-resolution.md). В настройках очереди вы можете изменить набор типов, которые доступны при создании новой задачи, а также указать тип по умолчанию для новых задач.

Список всех типов задач можно посмотреть в [настройках {{ tracker-name }}]({{ link-admin-types }}).

## Добавить тип задачи в очередь {#add-ticket-type-queue}

Чтобы добавить в очередь новый тип задачи:

1. Перейдите на страницу очереди.

1. В верхнем правом углу нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--types }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.add-issue-type }}**.

1. Задайте параметры:
    * **{{ ui-key.startrek.blocks-desktop_b-queue-form.choose-issue-type }}** — выберите один из доступных типов.
        В {{ tracker-name }} доступны наиболее популярные типы задач. Если нужного вам типа среди них нет, администратор может [создать его](#create-ticket-type).
    * **{{ ui-key.startrek.blocks-desktop_b-queue-form.choose-workflow }}** — укажите воркфлоу, который будет применяться к задачам этого типа. Выберите один из готовых воркфлоу или [создайте новый](add-workflow.md) на его основе.
    * **{{ ui-key.startrek.blocks-desktop_b-queue-form.choose-resolutions }}** — выберите возможные резолюции.
        По умолчанию в {{ tracker-name }} доступны наиболее популярные резолюции. Если нужной вам резолюции среди них нет, администратор может [создать ее](create-resolution.md).

1. В блоке **{{ ui-key.startrek.blocks-desktop_b-queue-issue-type.workflow-view-label }}** отображаются основные параметры выбранного воркфлоу. При необходимости вы можете его отредактировать или создать копию.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-queue-form.save }}** внизу вкладки.

{% note tip %}

В настройках очереди вы можете указать тип задач по умолчанию. Тогда все новые задачи в очереди будут создаваться с выбранным типом. Для этого в правом верхнем углу нажмите **Тип задачи по умолчанию:** и выберите тип из списка.

{% endnote %}


## Создать тип задачи {#create-ticket-type}

{% note warning %}

Создавать новые типы задач может только [администратор](../role-model.md). Созданный тип задачи нельзя удалить или отредактировать.

{% endnote %}

В {{ tracker-name }} доступны наиболее популярные типы задач. Если подходящего типа среди них нет, создайте новый:

1. Убедитесь, что вы авторизованы в {{ tracker-full-name }} как [администратор](../role-model.md).

1. На панели слева выберите ![](../../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue.cp }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.tracker-settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--types }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_page-admin-tab.create--types }}**.

1. Заполните поля и нажмите **{{ ui-key.startrek.blocks-desktop_b-create-ticket-form__labels.submit }}**.


## Удалить тип задачи из очереди {#delete-ticket-type}

Если какой-то из типов задач больше не нужен в очереди, вы можете его удалить.

{% note warning %}

Удалить можно только типы, которые не используются ни в одной из задач очереди.

{% endnote %}

Чтобы удалить тип задачи из очереди:

1. Перейдите на страницу очереди.

1. В верхнем правом углу нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--types }}**.

1. Удалите тип с помощью кнопки ![](../../_assets/tracker/remove-task-type.png).

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-queue-form.save }}** внизу вкладки.
