---
title: "Как посмотреть список моих задач в {{ tracker-full-name }}"
description: "Из статьи вы узнаете, как можно посмотреть список своих задач." 
---

# Мои задачи

Найдите задачи, над которыми вы работаете:

1. На панели слева откройте ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.ui_components_NavigationBar.issue-lists-menu-item }}**.

1. Чтобы найти задачи, в которых вы являетесь автором, исполнителем или наблюдателем, выберите фильтр **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-my-issues }}**.

1. Если отобразились не все нужные задачи, откройте полный список:

    * На панели слева в нижней части страницы нажмите кнопку **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.filter-items-link }}** или перейдите по [прямой ссылке]({{ link-tracker }}issues/my-issues).

    * Чтобы открыть все задачи, которые доступны вам в {{ tracker-name }}, в нижней части окна нажмите кнопку **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.all-items-link }}** или перейдите по [прямой ссылке]({{ link-tracker }}issues).

Для поиска задач в списке используйте [фильтры по параметрам](#q-filters) или [добавьте условия поиска](default-filters.md#add-condition).

## Фильтры по параметрам {#q-filters}

Чтобы отфильтровать список задач и оставить в нем только задачи с выбранными параметрами, используйте фильтры. Кнопки фильтров по параметрам расположены над списком задач:

* Чтобы использовать стандартные фильтры, нажмите на название фильтра в списке в левом верхнем углу страницы:
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-favorite }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-my-issues }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-author }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-assignee }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-follower }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-waiting }}**.
    * **{{ ui-key.startrek.ui_components_IssuesPresetSelect.preset-deadline }}**.

* Чтобы отфильтровать задачи по [резолюции](../manager/create-resolution.md), нажмите кнопку **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--resolution }}** и выберите нужные значения из списка.

* Чтобы использовать [дополнительные параметры поиска](./default-filters.md#add-condition), нажмите кнопку ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_filter-pane_FieldsSelectButton.add-filter-field-button-title }}** и выберите поле.

## Найти задачи по названию {#search-name}

Если нужно найти задачи по названию:

1. На панели слева откройте ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.ui_components_NavigationBar.issue-lists-menu-item }}** или перейдите по [ссылке]({{ link-tracker }}issues/).

1. В поле **{{ ui-key.startrek.ui_components_filter-pane.search-placeholder }}** введите текст для поиска.

Поиск задачи осуществляется с учетом указанных фильтров.

## Настроить отображение задач {#manage-list}

{% note info %}

Настройка отображения задач доступна только в веб-интерфейсе {{ tracker-name }}.

{% endnote %}

Вы можете настроить отображение задач в списке или сохранить список в файл:

* Чтобы отобразить или скрыть параметры задач, справа над списком нажмите значок ![](../../_assets/tracker/svg/settings.svg), выберите параметры и нажмите кнопку **{{ ui-key.startrek.ui_components_TrackerSelect.applyChanges }}**.
* Чтобы сгруппировать задачи по определенному параметру, над списком нажмите ![](../../_assets/tracker/svg/group.svg) **{{ ui-key.startrek.blocks-desktop_b-filter.no-group }}** и выберите параметр.
* Чтобы сохранить список задач, в правой верхней части страницы нажмите значок ![](../../_assets/tracker/svg/export.svg) и выберите формат файла для загрузки или скопируйте список в буфер обмена.
