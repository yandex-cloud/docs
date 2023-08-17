# Найти мои задачи

Чтобы найти задачи, с которыми вы работаете, используйте предустановленные _системные фильтры_. Фильтры выводят списки задач, в которых вы указаны как исполнитель, автор и так далее. Для поиска задач в списке используйте [стандартные фильтры](#sys_filters) или [добавьте условия поиска](#add-condition).

## Использовать стандартные фильтры {#sys_filters}

Найдите ваши задачи с помощью предустановленных системных фильтров.

1. В левом верхнем углу экрана нажмите **{{ ui-key.startrek.ui_components_agile_common_AgileFilters.all-issues-filter-title }}** и выберите один из вариантов:

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-favorite }}** – задачи, которые вы [добавили в избранное](../user/favourites.md#task-fav).

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-my-issues }}** – задачи, для которых вы являетесь автором, исполнителем или наблюдателем.

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-author }}** – задачи, для которых вы являетесь автором.

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-assignee }}** – задачи, в которых вы назначены исполнителем.

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-follower }}** – задачи, на обновления которых вы [подписались](../user/subscribe.md#section_xt5_xrv_jz).

    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-waiting }}** – задачи, в которых вас [призвали в комментарии](comments.md#call-comment).

    * **{{ ui-key.startrek.ui_components_IssuesPresetSelect.preset_deadline }}** – задачи, для которых вы являетесь автором, исполнителем или наблюдателем и в которых:
            
    * дедлайн уже наступил за последние две недели ![](../../_assets/tracker/deadline-red.png);
              
    * дедлайн наступит в ближайшие три месяца ![](../../_assets/tracker/deadline-grey.png).


1. После установки фильтра вы увидите выбранный список задач.

## Добавить условия поиска {#add-condition}

#### Поиск по параметрам

Чтобы найти в списке задачи по параметрам, которые нельзя задать с помощью системных фильтров, добавьте условия поиска.

  1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/gantt-settings-button.svg).

  1. Выберите параметр задачи, затем задайте его значение и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**. 

      В списке останутся только задачи, параметры которых удовлетворяют заданному условию.


  1. Если нужно уточнить условия поиска, добавьте еще несколько параметров.

  1. Чтобы отменить заданные условия поиска, на странице **{{ ui-key.startrek.blocks-desktop_b-page-issues.page-title }}** в правом верхнем углу нажмите кнопку **{{ ui-key.startrek.blocks-desktop_issues-filter.action--reset }}**. 

{% endlist %}
