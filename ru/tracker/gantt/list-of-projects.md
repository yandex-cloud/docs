# Диаграмма Ганта для списка проектов {{ tracker-name }}

На диаграмме Ганта для списка проектов в {{ tracker-name }} отображаются все проекты, а также задачи каждого из них и связи между ними.

## Построить диаграмму для списка проектов {#sec_projects}

Чтобы перейти к диаграмме Ганта:

1. Перейдите на [страницу проектов]({{ link-tracker }}pages/projects) или на [панели слева]({{ link-tracker }}) выберите ![](../../_assets/tracker/svg/project.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-queues-info.projects }}** и выберите, какой из списков открыть: **Полный список моих проектов** **{{ ui-key.startrek.ui_components_NavigationBar_ProjectsPanel.all-projects-link }}**.

1. Выберите вкладку **{{ ui-key.startrek.ui_components_filter-pane_ViewModeSwitch.mode-gantt }}**.
   * Слева от диаграммы отображается список проектов. Чтобы открыть список задач проекта, нажмите на значок ![](../../_assets/tracker/svg/arrow.svg) рядом с его названием. Задачи отобразятся в виде иерархического списка.
   * Сроки работы над проектами отображаются на диаграмме в виде полос, направленных вдоль оси времени. Начало каждой полосы соответствует дате начала работы над проектом, а ее конец — дате дедлайна.

1. Чтобы отображать только некоторые задачи внутри проектов, настройте фильтрацию по задачам. В правой части на панели над диаграммой, в разделе **{{ ui-key.startrek.ui_components_projects_ListFilterPane.filter-issues }}**, настройте фильтр, последовательно добавляя нужные параметры и задавая для них значения.

1. Чтобы настроить масштаб временной шкалы, в нижнем правом углу диаграммы выберите **{{ ui-key.startrek.ui_components_Gantt.scale-days }}**, **{{ ui-key.startrek.ui_components_Gantt.scale-month }}** или **{{ ui-key.startrek.ui_components_Gantt.scale-quarters }}**. Настройки масштаба сохранятся после обновления страницы или при повторном переходе в диаграмму.

## Изменить сроки проектов {#timing}

* Если сроки работы над проектом не отображаются на диаграмме (его даты начала и завершения не заданы), наведите указатель мыши на диаграмму напротив названия проекта, затем расположите полосу задачи в нужном месте и нажмите левую кнопку мыши.

* Чтобы сдвинуть одновременно даты начала и завершения проекта, перетащите полосу вдоль оси времени.

* Чтобы изменить длительность работы над проектом, потяните за левый край полосы (дата начала) или за правый край (дата завершения).

## Назначить ответственного {#assigned}

На диаграмме Ганта для списка проектов вы можете назначить или изменить ответственного за проект:

1. На полосе проекта нажмите кнопку ![](../../_assets/tracker/svg/pick-user.svg).

1. Введите имя сотрудника, который будет назначен ответственным.

{% note info %}

Если кнопка ![](../../_assets/tracker/svg/pick-user.svg) не отображается на полосе проекта, перейдите в ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**{{ ui-key.startrek.ui_components_Gantt.timeline-config }}** и в разделе **{{ ui-key.startrek.ui_components_Gantt.task-bar }}** отметьте пункт **{{ ui-key.startrek.ui_components_Gantt.show-issue-assignee }}**.

{% endnote %}

Аналогичным образом на диаграмме можно назначать и менять исполнителей задач каждого из проектов.

## Настройки диаграммы {#settings}

### Отображение полосы задачи {#issue-bar}

{% include [issue-bar](../../_includes/tracker/issue-bar.md) %}

### Область таймлайна {#timeline}

{% include [timeline-area](../../_includes/tracker/timeline-area.md) %}

{% include [external-blockers](../../_includes/tracker/external-blockers.md) %}

## Отображение блока со списком задач {#tasks-view}

* Чтобы найти задачи или проекты в списке, в поле **{{ ui-key.startrek.ui_components_projects_ListFilterPane.search-placeholder }}** введите текст.

* Чтобы настроить порядок отображения в списке, нажмите ![](../../_assets/tracker/svg/sorting.svg)&nbsp;**{{ ui-key.startrek.ui_components_SortButton.default-title }}**, укажите параметр и нажмите ![](../../_assets/tracker/svg/new-first.svg). В этом случае ручное перемещение задач станет недоступно.

* Чтобы отфильтровать список проектов, используйте конструктор фильтров. Для этого на панели ![](../../_assets/tracker/svg/filter.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-page-issues.page-title }}** в разделе **{{ ui-key.startrek.ui_components_projects_ListFilterPane.filter-projects }}** выберите параметры и укажите значения, по которым будет сформирован список проектов. Кроме того, в разделе **{{ ui-key.startrek.ui_components_projects_ListFilterPane.filter-issues }}** вы можете настроить дополнительный фильтр по задачам внутри проектов.
