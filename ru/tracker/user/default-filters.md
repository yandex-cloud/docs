# Найти мои задачи

Чтобы найти задачи, с которыми вы работаете, используйте предустановленные _системные фильтры_. Фильтры выводят списки задач, в которых вы указаны как исполнитель, автор и так далее. Для поиска задач в списке используйте [стандартные фильтры](#sys_filters) или [добавьте условия поиска](#add-condition).

## Использовать стандартные фильтры {#sys_filters}

Найдите ваши задачи с помощью предустановленных системных фильтров.

1. Перейдите на страницу со списком задач. Для этого на панели слева откройте ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.ui_components_NavigationBar.issue-lists-menu-item }}** или перейдите по [ссылке]({{ link-tracker }}issues).     

1. В поле с выпадающим списком выберите один из вариантов:

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-favorite }}** – задачи, которые вы [добавили в избранное](favourites.md#task-fav).

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-my-issues }}** – задачи, для которых вы являетесь автором, исполнителем или наблюдателем.

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-author }}** – задачи, для которых вы являетесь автором.

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-assignee }}** – задачи, в которых вы назначены исполнителем.

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-follower }}** – задачи, на обновления которых вы [подписались](subscribe.md#section_xt5_xrv_jz).

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-waiting }}** – задачи, в которых вас [призвали в комментарии](comments.md#call-comment).

    * **{{ ui-key.startrek.ui_components_IssuesPresetSelect.preset_deadline }}** – задачи, для которых вы являетесь автором, исполнителем или наблюдателем и в которых:
            
      * дедлайн уже наступил за последние две недели;
          
      * дедлайн наступит в ближайший месяц.

1. На странице фильтра вы увидите выбранный список задач. Вы можете добавить условия фильтрации, настроить внешний вид списка или сохранить список в файл:

    * Для поиска задач в списке используйте строку поиска **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.search-input-placeholder }}** или [добавьте условия поиска](#add-condition).


    * Чтобы сгруппировать задачи по определенному параметру, справа от строки поиска нажмите ![](../../_assets/tracker/svg/group.svg) **{{ ui-key.startrek.blocks-desktop_issues-table.group-by--null }}** и выберите параметр.


    * Чтобы сохранить список задач, в верхнем правом углу нажмите ![](../../_assets/tracker/svg/icon-export-tasks.svg) **{{ ui-key.startrek.ui_components_FilterExportMenu.menu-item-export }}** и выберите формат файла для загрузки или скопируйте список в буфер обмена.

    * Чтобы свернуть панель со списком фильтров, в верхнем правом углу страницы нажмите ![](../../_assets/tracker/svg/icon-parameters.svg) **{{ ui-key.startrek.ui_components_PageIssues_FilterInputTypeSwitch.parameters }}**. 

## Фильтрация по параметрам {#quick-filters}

{% note info %}

Фильтры по параметрам доступны только в веб-интерфейсе {{ tracker-name }}.

{% endnote %}

Чтобы отфильтровать список задач и оставить в нем только задачи с выбранными параметрами, используйте фильтры по параметрам. Кнопки фильтров по параметрам расположены над списком задач:

 * Чтобы отфильтровать задачи по [резолюции](../manager/create-resolution.md), нажмите кнопку **{{ ui-key.startrek-backend.fields.issue.resolution-key-value }}** и выберите нужные значения из списка.

 * Чтобы использовать [дополнительные параметры поиска](#add-condition), нажмите кнопку ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_filter-pane_FieldsSelectButton.add-filter-field-button-title }}** и выберите поле.

В результате в списке останутся только те задачи, которые удовлетворяют выбранным фильтрам.

## Добавить условия поиска {#add-condition}

#### Поиск по параметрам

Чтобы найти в списке задачи по параметрам, которые нельзя задать с помощью системных фильтров, добавьте условия поиска.

1. В верхнем правом углу страницы нажмите ![](../../_assets/tracker/svg/icon-parameters.svg) **{{ ui-key.startrek.ui_components_dashboard_IssuesStatEditor.editor-source-radio-parameters }}**. Под строкой поиска отобразится панель с установленными параметрами фильтрации.

1. Нажмите значок ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_filter-pane_FieldsSelectButton.add-filter-field-button-title }}**.  

1. Выберите параметр задачи, затем задайте его значение нажмите кнопку **{{ ui-key.startrek.ui_components_filter-field.save-button }}**. 

    В списке останутся только задачи, параметры которых удовлетворяют заданному условию.


1. Если нужно уточнить условия поиска, добавьте еще несколько параметров.

1. Чтобы отменить заданные условия поиска, над списком задач нажмите кнопку **{{ ui-key.startrek.ui_components_filter-pane.reset-button }}**.

Например, вы можете искать задачи по названию или описанию: 

* Чтобы найти задачи, название которых содержит заданную фразу, добавьте в условия поиска параметр **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** и введите текст для поиска.

* Чтобы найти задачи, описание которых содержит заданную фразу, добавьте в условия поиска параметр **{{ ui-key.startrek-backend.fields.issue.description-key-value }}** и введите текст для поиска.


{% note info %}

Если вы зададите несколько условий поиска, будут найдены только те задачи, которые удовлетворяют всем условиям одновременно.

{% endnote %}

#### Язык запросов

Если условия поиска не удается задать с помощью параметров задачи, используйте запрос:

1. В правом верхнем углу страницы нажмите кнопку ![](../../_assets/tracker/svg/query-language.svg) **{{ ui-key.startrek.ui_components_dashboard_FilterEditor.editor-source-radio-query }}**. Все параметры поиска, которые вы задали с помощью системных фильтров и условий, отобразятся в строке запроса.

1. Добавьте в строку условия с помощью [языка запросов](query-filter.md).

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_issues-filter.action--apply-query }}**. 

В списке останутся только задачи, параметры которых удовлетворяют заданному условию.

#### Сохранить фильтр

Чтобы сохранить условия поиска задач в виде фильтра:

1. На панели под списком задач нажмите кнопку ![](../../_assets/tracker/svg/save-filter.svg) **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.action_submit }}**.

1. Задайте имя и категорию фильтра. 

Ваши сохраненные фильтры доступны в поле выбора **{{ ui-key.startrek.ui_components_FilterEditorPane.all-issues-filter-title }}** в разделе **{{ ui-key.startrek-backend.messages.user.named.request.folder.my }}**.
