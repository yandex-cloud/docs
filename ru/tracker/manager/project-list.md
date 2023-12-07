# Список задач проекта

На вкладке **Список задач** отображаются все задачи, которые [добавлены](create-project.md#add-tickets) в проект. Список отображает структуру проекта: вы можете выстроить иерархию работ в виде дерева подзадач, ранжировать задачи вручную или отсортировать их по одному из полей.

Чтобы открыть список задач проекта:

1. На панели слева выберите ![](../../_assets/tracker/svg/project.svg)&nbsp;**Проекты** или перейдите по [прямой ссылке]({{ link-tracker }}pages/projects) и откройте страницу проекта.

1. Перейдите на вкладку **Список задач**. 

1. Настройте отображение списка:

  {% include [issues-table-queue-filter-project](../../_includes/tracker/issues-table-queue-filter-project.md) %}

  {% include [issues-table-project](../../_includes/tracker/issues-table-project.md) %}

## Действия с задачами {#issue-actions}

Чтобы в списке задач проекта открыть меню действий с задачей, в конце строки с описанием задачи нажмите ![](../../_assets/tracker/svg/actions.svg) **Действия**.

В меню доступны действия:
* ![](../../_assets/tracker/text-edit/link.svg) **{{ ui-key.startrek.ui_components_projects_hooks.copy-to-clipboard }}**;
* ![](../../_assets/tracker/svg/move-up.svg) **{{ ui-key.startrek.ui_components_projects_hooks.issue-actions--move-up }}** (только при ручной сортировке);
* ![](../../_assets/tracker/svg/move-down.svg) **{{ ui-key.startrek.ui_components_projects_hooks.issue-actions--move-down }}** (только при ручной сортировке);
* ![](../../_assets/tracker/svg/convert.svg) **Преобразовать в [веху](milestones.md) или задачу**.
* ![](../../_assets/tracker/svg/icon-remove.svg) **{{ ui-key.startrek.ui_components_projects_hooks.delete-from-project }}**.
