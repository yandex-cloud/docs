# Как настроить колонки на доске

Карточки задач распределены по колонкам в соответствии с их статусом. Настройте колонки доски, чтобы видеть нужные статусы и перемещать задачи между ними. Колонки на досках бывают двух видов: [по статусам](#status) и [произвольные](#user-columns).

Перейдите на страницу доски: на панели слева нажмите ![](../../_assets/tracker/svg/boards.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.boards }}** и выберите доску.

## Колонки по статусам {#status}

Чтобы перейти к колонкам по статусам, на верхней панели доски нажмите **{{ ui-key.startrek.ui_components_agile_common_ViewModeControl.columns }}** → **{{ ui-key.startrek.ui_components_agile_common_ViewModeControl.columnsByStatus }}**.

### Добавить колонку {#add-status-cols}

Чтобы добавить колонку по статусу на доску задач:

1. На странице доски нажмите кнопку **{{ ui-key.startrek.ui_components_agile_backlog_BacklogAddColumnButton.add-column }}**.

1. Введите параметры новой колонки:

    * Укажите один или несколько статусов в поле **{{ ui-key.startrek.ui_components_agile_common_ColumnForm.create-column-label--statuses }}**. Для этого начните вводить название статуса и выберите значение из списка.

    * Введите название колонки.

    * Задайте максимальное число задач, которое может содержаться в колонке. Если их будет больше — колонка станет желтого цвета, но при этом в колонку можно будет добавлять задачи, превышая указанное ограничение.

1. Нажмите **{{ ui-key.startrek.ui_components_agile_common_ColumnForm.create-column-submit-button--create }}**.

1. Чтобы просмотреть список статусов, которые не используются на доске, рядом с крайней правой колонкой нажмите значок ![](../../_assets/tracker/svg/unused-status.svg). Добавьте нужные статусы на доску: на карточке статуса нажмите ![](../../_assets/tracker/svg/actions.svg), затем **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardUnusedStatuses.unused-statuses-create-column }}** или **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardUnusedStatuses.unused-statuses-add-to-column }}**.

   {% note info %}

   Если на доске есть задачи, статусы которых не привязаны к колонкам, они не отобразятся на доске. 

   {% endnote %}
    
1. Чтобы добавить заметку с текстом, который будет отображаться под названием колонки, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardColumnHeader.column-menu--add-note }}**.

### Изменить колонку {#edit-status-cols}

Вы можете изменить параметры колонки и ее расположение на доске.

* Чтобы отредактировать название, максимальное количество задач в колонке или изменить статусы, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-edit.svg) **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardColumnHeader.column-menu--edit }}**.

* Чтобы изменить расположение колонки на доске, перетащите ее в нужное место.

* Чтобы отредактировать заметку с текстом, который отображается под названием колонки, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **Редактировать заметку**.

### Удалить колонку {#delete-status-cols}

Чтобы удалить колонку с доски, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardColumnHeader.column-menu--delete }}**.

Если в удаленной колонке были задачи, они будут перенесены в блок **{{ ui-key.startrek.ui_components_agile_common_UnusedStatusesButton.unused-statuses-button }}**. Чтобы просмотреть такие задачи, рядом с крайней правой колонкой нажмите значок ![](../../_assets/tracker/svg/unused-status.svg), затем нажмите название статуса.

## Произвольные колонки {#user-columns}

На досках можно создавать, перемещать и удалять произвольные колонки. Это касается всех колонок, кроме первой — колонки с неразобранными задачами. Также внутри произвольных колонок можно создавать задачи, перемещать их как внутри колонки, так и между колонками.

Чтобы перейти к произвольным колонкам, на верхней панели доски нажмите **{{ ui-key.startrek.ui_components_agile_common_ViewModeControl.columns }}** → **{{ ui-key.startrek.ui_components_agile_common_ViewModeControl.customColumns }}**.

### Добавить колонку {#add-user-cols}

Чтобы добавить произвольную колонку на доску задач:

1. На странице доски нажмите кнопку **{{ ui-key.startrek.ui_components_agile_backlog_BacklogAddColumnButton.add-column }}**.

1. Введите параметры новой колонки:

    * Укажите название колонки.

    * Задайте максимальное число задач, которое может содержаться в колонке. Если их будет больше — колонка станет желтого цвета, но при этом в колонку можно будет добавлять задачи, превышая указанное ограничение.

1. Нажмите **{{ ui-key.startrek.ui_components_agile_common_ColumnForm.create-column-submit-button--create }}**.
    
1. Добавьте в колонку задачи: рядом с колонкой нажмите ![](../../_assets/tracker/svg/add-task.svg) и добавьте существующую задачу или создайте новую.
   
   {% note info %}

   Если на карточку задачи добавлено поле **Story Points**, то суммарное количество **Story Points** в колонке отображается в ее заголовке. Чтобы добавить поле **Story Points** в карточку задачи, на странице доски в правом углу панели поиска, сортировки и группировки нажмите кнопку ![](../../_assets/tracker/svg/actions.svg) → **{{ ui-key.startrek.ui_components_agile_common_FieldsSelect.fields-settings }}** и выберите поле **Story Points**.

   {% endnote %}

### Изменить колонку {#edit-user-cols}

Вы можете изменить параметры колонки и ее расположение на доске.

* Чтобы отредактировать название или максимальное количество задач в колонке, наведите указатель на эту колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-edit.svg) **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardColumnHeader.column-menu--edit }}**.

* Чтобы изменить расположение колонки на доске, перетащите ее в нужное место.

* Чтобы отредактировать заметку с текстом, который отображается под названием колонки, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **Редактировать заметку**.

### Удалить колонку {#delete-user-cols}

Чтобы удалить колонку с доски, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardColumnHeader.column-menu--delete }}**.
