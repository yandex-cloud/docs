# Диаграмма Ганта в проектах {{ tracker-name }}

На диаграмме Ганта для проекта в {{ tracker-name }} отображаются все задачи проекта и связи между ними.

## Построить диаграмму для проекта {#sec_project}

Чтобы перейти к диаграмме Ганта:

1. На [панели слева]({{ link-tracker }}) выберите ![](../../_assets/tracker/svg/project.svg)&nbsp;**Проекты** или перейдите по [прямой ссылке]({{ link-tracker }}pages/projects) и откройте страницу проекта.

1. {% include [go-to-gantt](../../_includes/tracker/go-to-gantt.md) %}

1. {% include [gantt-time-scale](../../_includes/tracker/gantt-time-scale.md) %}

## Изменить связи между задачами {#links}

{% include [gantt-links](../../_includes/tracker/gantt-links.md) %}

* Если у задачи есть блокеры, которые не входят в текущий проект, на диаграмме слева от полосы задачи появится значок ![](../../_assets/tracker/svg/blocker.svg) с их количеством. 

   * Чтобы включить отображение внешних блокеров в списке задач, перейдите в [](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**Настройки диаграммы** → **Показывать внешние блокеры**.

   * В списке задач внешние блокеры выделены серым цветом и отображаются под зависимой задачей. Если включен [иерархический тип отображения](#trees), блокеры отображаются под веткой задач. Внешние блокеры нельзя перемещать в списке, но их можно открыть и отредактировать.

   * Сроки начала работ и дедлайн для внешних блокеров можно [изменять](#timing).

   * Чтобы удалить связь между внешним блокером и зависимой задачей, нажмите значок ![](../../_assets/tracker/svg/blocker.svg), а затем ![](../../_assets/tracker/svg/del-link.svg) **Удалить связь**.

## Изменить сроки задач {#timing}

{% include [gantt-timing](../../_includes/tracker/gantt-timing.md) %}

{% include [gantt-timing-prolongate](../../_includes/tracker/gantt-timing-prolongate.md) %}

* Если для родительской задачи не указаны сроки, напротив нее на диаграмме отображается подсказка в виде голубой полосы в соответствии со сроками всех подзадач.

## Назначить исполнителя {#assigned}

{% include [gantt-assigned](../../_includes/tracker/gantt-assigned.md) %}

## Настройки диаграммы {#settings}

### Отображение полосы задачи {#issue-bar}

{% include [issue-bar](../../_includes/tracker/issue-bar.md) %}

### Область таймлайна {#timeline}

{% include [timeline-area](../../_includes/tracker/timeline-area.md) %}

{% include [external-blockers](../../_includes/tracker/external-blockers.md) %}

### Цвет задачи {#task-color}

{% include [color-issue](../../_includes/tracker/color-issue.md) %}

## Отображение блока со списком задач {#tasks-view}

{% include [issues-table-project](../../_includes/tracker/issues-table-project.md) %}
