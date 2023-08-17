# Создать фильтр задач

Если для поиска задач в {{ tracker-name }} вам не хватает [системных фильтров](default-filters.md), вы можете создать свой фильтр и искать задачи по любым параметрам: названию, описанию, текстам комментариев, значениям полей, дате изменения и так далее. Например, с помощью фильтра можно найти все задачи в заданной очереди, у которых вы автор или исполнитель.

Сохраненные фильтры можно использовать, чтобы отбирать задачи для [дашбордов](dashboard.md) и [Agile-досок](../manager/create-agile-board.md).

## Создать фильтр {#create}

### Шаг 1. Откройте список задач {#open-tasks}

Чтобы открыть все задачи, которые доступны вам в {{ tracker-name }}: 

* на панели слева откройте ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.caption }}**, затем в нижней части окна нажмите кнопку **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.all-items-link }}**;
* или перейдите по [прямой ссылке]({{ link-tracker }}issues).

### Шаг 2. Задайте условия фильтрации {#set-conditions}

Чтобы задать условия фильтра, можно использовать несколько способов:

- **Фильтрация по параметрам**

    Используйте кнопки управления фильтрами по параметрам, которые расположены над списком задач. Чтобы отфильтровать задачи по [резолюции](../manager/create-resolution.md), нажмите кнопку **{{ ui-key.startrek-backend.fields.issue.resolution-key-value }}** и выберите нужные значения из списка.


- **Условия поиска по параметрам**

    Добавьте параметры задачи и укажите их возможные значения:

    1. Над списком задач нажмите кнопку ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_filter-pane_FieldsSelectButton.add-filter-field-button-title }}**.

    1. Выберите параметр задачи, затем задайте его значение. 

        В списке останутся только те задачи, параметры которых удовлетворяют заданному условию.
    	
    1. Если нужно уточнить условия поиска, добавьте еще несколько параметров.

    Например, вы можете искать задачи по названию или описанию: 

    - Чтобы найти задачи, названия которых содержат заданную фразу, добавьте в условия поиска параметр **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** и введите текст для поиска.

    - Чтобы найти задачи, описания которых содержат заданную фразу, добавьте в условия поиска параметр **{{ ui-key.startrek-backend.fields.issue.description-key-value }}** и введите текст для поиска.


    {% note info %}

    Если вы зададите несколько условий поиска, будут найдены только те задачи, которые удовлетворяют всем условиям одновременно.

    {% endnote %}

- **{{ ui-key.startrek.ui_components_dashboard_FilterEditor.editor-source-radio-query }}**

    Язык запросов позволяет задать условия, которые невозможно настроить с помощью параметров. Например, найти задачи, которые были открыты в течение последней недели. Подробнее о языке запросов читайте в разделе [{#T}](query-filter.md).

    1. В правом верхнем углу страницы нажмите ![](../../_assets/tracker/svg/query-language.svg) **{{ ui-key.startrek.ui_components_dashboard_FilterEditor.editor-source-radio-query }}**. Все параметры поиска, которые вы задали с помощью быстрых фильтров и условий, отобразятся в строке запроса.

    1. Добавьте в строку условия с помощью [языка запросов](query-filter.md).

        В списке останутся только те задачи, параметры которых удовлетворяют заданному условию.

### Шаг 3. Настройте внешний вид списка задач

- Чтобы отобразить или скрыть параметры задач, справа над списком нажмите ![](../../_assets/tracker/svg/list-settings.svg) **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader.settings }}**, выберите параметры и нажмите кнопку **{{ ui-key.startrek.ui_components_FilterFieldsSelect.applyChanges }}**.

- Чтобы сгруппировать задачи по определенному параметру, над списком нажмите ![](../../_assets/tracker/svg/group.svg) **{{ ui-key.startrek.blocks-desktop_issues-table.group-by--null }}** и выберите параметр.

- Чтобы свернуть панель со списком фильтров, в верхнем правом углу нажмите ![](../../_assets/tracker/svg/icon-parameters.svg) **{{ ui-key.startrek.ui_components_PageIssues_FilterInputTypeSwitch.parameters }}**. 

### Шаг 4. Сохраните фильтр

Если вам часто приходится пользоваться одним и тем же фильтром, сохраните его. Ваши сохраненные фильтры доступны в поле выбора **{{ ui-key.startrek.ui_components_filter-pane.all-issues-filter-title }}** в разделе **{{ ui-key.startrek-backend.messages.user.named.request.folder.my }}**.

1. Над списком задач нажмите кнопку **{{ ui-key.startrek.blocks-desktop_issues-filter-save-modal.action_submit }}**.

1. Задайте название фильтра и выберите категорию для сохранения.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.change-category-form--change }}**.

Чтобы сохранить список задач, найденных с помощью фильтра, в правом верхнем углу нажмите кнопку ![](../../_assets/tracker/svg/icon-export-tasks.svg) **{{ ui-key.startrek.ui_components_FilterExportMenu.menu-item-export }}** и выберите формат файла для загрузки или скопируйте список в буфер обмена.

## Редактировать фильтр {#edit}

#### Изменить условия фильтра

1. В верхней части окна в поле **{{ ui-key.startrek.ui_components_page-issues_touch.all-issues-filter-title }}** выберите ваш фильтр.

1. [Измените условия поиска задач](#set-conditions) с помощью быстрых фильтров, параметров или языка запросов.

1. Над списком задач нажмите кнопку **{{ ui-key.startrek.blocks-desktop_issues-filter-save-modal.action_submit }}**:

    * Чтобы сохранить фильтр под текущим именем, нажмите кнопку **{{ ui-key.startrek.ui_components_filter-pane.action-title-save }}**.

    * Чтобы сохранить фильтр под другим именем, нажмите кнопку **{{ ui-key.startrek.ui_components_filter-pane.action-title-save-as }}**. Затем задайте имя фильтра, выберите категорю и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.action_submit }}**.


#### Удалить фильтр

1. В верхней части окна в поле **{{ ui-key.startrek.ui_components_page-issues_touch.all-issues-filter-title }}** выберите ваш фильтр.

1. Удалите фильтр одним из спообов:

    * Справа от названия фильтра нажмите значок ![](../../_assets/tracker/svg/icon-filter-delete.svg) **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.filter-remove-confirm-submit }}**. 

    * В верхнем правом углу страницы нажмите значок ![](../../_assets/tracker/svg/actions.svg) **{{ ui-key.startrek.ui_components_FilterExportMenu.title }}** и выберите ![](../../_assets/tracker/svg/icon-filter-delete.svg) **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.filter-remove-confirm-submit }}**.