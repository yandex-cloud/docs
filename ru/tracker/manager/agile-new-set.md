# Настроить доску


## Настроить колонки {#cols}

Карточки задач распределены по колонкам в соответствии с их статусом. Настройте колонки доски, чтобы видеть нужные статусы и перемещать задачи между ними.

### Добавить колонку {#add-cols}

Чтобы добавить колонку на доску задач:

1. На странице доски нажмите кнопку **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardAddColumnButton.new-column-button }}**.

1. Введите параметры новой колонки:

    * Укажите один или несколько статусов в поле **{{ ui-key.startrek.ui_components_agile_common_ColumnForm.create-column-label--statuses }}**. Для этого начните вводить название статуса и выберите значение из списка.

    * Введите название колонки.

1. Нажмите **{{ ui-key.startrek.ui_components_agile_common_ColumnForm.create-column-submit-button--create }}**.

1. Чтобы просмотреть список статусов, которые не используются на доске, рядом с крайней правой колонкой нажмите значок ![](../../_assets/tracker/svg/unused-status.svg). Добавьте нужные статусы на доску: на карточке статуса нажмите ![](../../_assets/tracker/svg/actions.svg), затем **{{ ui-key.startrek.ui_components_agile_common_ColumnForm.create-column-label--statuses }}** или **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardUnusedStatuses.unused-statuses-add-to-column }}**.

   {% note info %}

   Если на доске есть задачи, статусы которых не привязаны к колонкам, они не отобразятся на доске. 

   {% endnote %}
    
1. Чтобы добавить заметку с текстом, который будет отображаться под названием колонки, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardColumnHeader.column-menu--add-note }}**.

### Изменить колонку {#edit-cols}

Вы можете изменить параметры колонки и ее расположение на доске.

* Чтобы отредактировать название или изменить статусы колонки, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-edit.svg) **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardColumnHeader.column-menu--edit }}**.

* Чтобы изменить расположение колонки на доске, перетащите ее в нужное место.

* Чтобы отредактировать заметку с текстом, который отображается под названием колонки, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **{{ ui-key.startrek.blocks-desktop_b-agile-board.edit-note }}**.

### Удалить колонку {#delete-cols}

Чтобы удалить колонку с доски, наведите указатель на колонку и нажмите ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardColumnHeader.column-menu--delete }}**.

Если в удаленной колонке были задачи, они будут перенесены в блок **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_columns.status-list-title }}**. Чтобы просмотреть такие задачи, рядом с крайней правой колонкой нажмите значок ![](../../_assets/tracker/svg/unused-status.svg), затем нажмите название статуса.

## Настроить карточки {#cards}

Настройте внешний вид карточки задачи, чтобы видеть на доске важные для вас параметры или быстро искать задачи с определенными тегами и компонентами.

По умолчанию на карточке задачи отображаются значения полей ключ, название, исполнитель и некоторых других. Чтобы настроить отображение полей на карточке задачи:

1. На странице доски в правом верхнем углу нажмите кнопку ![](../../_assets/tracker/svg/icon-card.svg) **Выбрать поля карточки**.

1. Отметьте поля задачи, которые будут отображаться на карточке. Можно добавить любые поля или убрать уже настроенные, кроме названия задачи (поле **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.issue-type-task }}**).

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_FieldsSelect.applyChanges }}**.

1. Чтобы выделить определенные теги или компоненты задач цветами:
   
   1. Настройте карточку, чтобы на ней отображались поля **{{ ui-key.startrek.components_FormCreateIssue.field--tags }}** или **{{ ui-key.startrek.components_FormCreateIssue.field--components }}**.
   
   2. На карточке задачи нажмите название тега или компонента и выберите цвет.
   
   Выбранный тег или компоненты будет выделен цветом на всех карточках.

## Удалить доску {#delete-board}

Если доска задач вам больше не нужна, вы можете ее удалить. При этом все задачи, которые были на доске, сохранятся в {{ tracker-name }}. Если удалить доску проекта, задачи сохранятся в [списке задач проекта](project-list.md).

1. Перейдите на доску.

1. В правом верхнем углу нажмите ![](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardActionsMenu.delete-board-menu-item }}**.


1. Подтвердите удаление.
