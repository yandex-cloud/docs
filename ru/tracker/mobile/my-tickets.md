---
title: "Как посмотреть список моих задач в {{ tracker-full-name }}"
description: "Из статьи вы узнаете, как можно посмотреть список своих задач." 
---

# Мои задачи

Найдите задачи, над которыми вы работаете:

1. Откройте мобильное приложение {{ tracker-full-name }}. 

1. Чтобы найти задачи, в которых вы являетесь автором, исполнителем или наблюдателем, выберите фильтр **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-my-issues }}**.

1. Для поиска задач в списке используйте [быструю фильтрацию](#q-filters) или [добавьте условия поиска](default-filters.md#add-condition).

## Быстрая фильтрация {#q-filters}

* Чтобы использовать стандартные фильтры, нажмите на название фильтра в списке в левом верхнем углу страницы:
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-favorite }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-my-issues }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-author }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-assignee }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-follower }}**.
    * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-waiting }}**.
    * **{{ ui-key.startrek.ui_components_IssuesPresetSelect.preset-deadline }}**.

* Чтобы отфильтровать задачи по [резолюции](../manager/create-resolution.md), нажмите кнопку **{{ ui-key.startrek-backend.fields.issue.resolution-key-value }}** и выберите нужные значения из списка.

* Чтобы использовать [дополнительные параметры поиска](./default-filters.md#add-condition), нажмите кнопку ![](../../_assets/tracker/svg/gantt-settings-button.svg) и выберите параметр.

## Найти задачи по названию {#search-name}

В поле **Поиск по названию, описанию, комментариям** введите текст для поиска.

Поиск задачи осуществляется с учетом указанных фильтров.