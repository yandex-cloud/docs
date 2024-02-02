# Диаграмма Ганта в проектах {{ tracker-name }}

На диаграмме Ганта для проекта в {{ tracker-name }} отображаются все задачи проекта и связи между ними.

## Построить диаграмму {#sec_project}

Чтобы перейти к диаграмме Ганта:

1. На [панели слева]({{ link-tracker }}) выберите ![](../../_assets/tracker/svg/project.svg)&nbsp;**Проекты** или перейдите по [прямой ссылке]({{ link-tracker }}pages/projects/list) и откройте страницу проекта.

1. {% include [go-to-gantt](../../_includes/tracker/go-to-gantt.md) %}

1. {% include [gantt-time-scale](../../_includes/tracker/gantt-time-scale.md) %}

## Изменить связи между задачами {#links}

{% include [gantt-links](../../_includes/tracker/gantt-links.md) %}

* Если у задачи есть блокеры, которые не входят в текущий проект, на диаграмме слева от полосы задачи появится значок ![](../../_assets/tracker/svg/blocker.svg) с их количеством. 

   * Чтобы включить отображение внешних блокеров в списке задач, перейдите в [](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**{{ ui-key.startrek.ui_components_Gantt.timeline-config }}** → **{{ ui-key.startrek.ui_components_Gantt.show-external-blockers }}**.

   * В списке задач внешние блокеры выделены серым цветом и отображаются под зависимой задачей. Если включен [иерархический тип отображения](#trees), блокеры отображаются под веткой задач. Внешние блокеры нельзя перемещать в списке, но их можно открыть и отредактировать.

   * Сроки начала работ и дедлайн для внешних блокеров можно [изменять](#timing).

   * Чтобы удалить связь между внешним блокером и зависимой задачей, нажмите значок ![](../../_assets/tracker/svg/blocker.svg), а затем ![](../../_assets/tracker/svg/del-link.svg) **{{ ui-key.startrek.ui_components_Gantt.delete-link }}**.

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

{% note info %}

Настройки цвета задач сохраняются на уровне диаграммы проекта, то есть выбранная цветовая схема действует для всех пользователей, просматривающих эту диаграмму.

{% endnote %}

{% include [color-issue](../../_includes/tracker/color-issue.md) %}

### Критический путь {#critical-path}

{% include [critical-path](../../_includes/tracker/gantt-critical-path.md) %}

### Базовые планы {#baselines}

Базовый план – это сохраненная версия диаграммы Ганта проекта. С его помощью вы сможете оглянуться назад, сравнить изначально запланированные сроки с текущими. Базовые планы помогают спрогнозировать итог проекта и в ретроспективе  понять, что можно улучшить при планировании.

Чтобы открыть панель с базовыми планами проекта, над временной шкалой справа нажмите ![](../../_assets/console-icons/clock-arrow-rotate-left.svg).

#### Создание базового плана {#create-baseline}

Создавайте базовый план, когда на диаграмме выставлены актуальные дедлайны, вехи и связи между задачами. При создании плана сохранятся текущие сроки на диаграмме Ганта. Чтобы создать базовый план:

1. На панели с базовыми планами проекта нажмите **Создать**.
1. По умолчанию в названии базового плана указан день и месяц его создания. При необходимости скорректируйте название базового плана и нажмите **Создать**.

Базовый план сохранит текущее состояние сроков задач в проекте. На панели с базовыми планами вы сможете сравнивать текущие сроки задач проекта с зафиксированными в базовых планах: на сколько дней опережают или отстают фактические сроки от запланированных (по последней задаче в проекте).

#### Применение базового плана {#working-with-baselines}

Базовые планы можно накладывать поверх исходной диаграммы Ганта проекта. Для этого откройте панель с базовыми планами и нажмите на план. В режиме сравнения на диаграмме можно будет оценить различия:

1. Отставание от зафиксированного дедлайна для конкретных задач — при наведении курсора на сроки задачи в базовом плане.
1. Преобразование задачи в веху или наоборот — изменится внешний вид задачи или вехи на диаграмме, а также появится комментарий при наведении курсора.
1. Удаление задач из проекта — сроки таких задач не будут отображаться в режиме сравнения.
1. Добавление новых задач в проект — у таких задач не будут зафиксированы старые сроки.

Чтобы отключить режим сравнения, наведите курсор на ![](../../_assets/console-icons/clock-arrow-rotate-left.svg) и нажмите на выделенный цветом план. 

## Отображение блока со списком задач {#tasks-view}

{% include [issues-table-project](../../_includes/tracker/issues-table-project.md) %}

## Действия с задачами {#issue-actions}

Чтобы в блоке со списком задач открыть меню действий с задачей, справа от названия задачи нажмите ![](../../_assets/tracker/svg/actions.svg) **{{ ui-key.startrek.ui_components_Gantt_IssueActionsCell.issue-action-menu-title }}**.

В меню доступны действия:
* ![](../../_assets/tracker/text-edit/link.svg) **{{ ui-key.startrek.ui_components_projects_hooks.copy-to-clipboard }}**;
* ![](../../_assets/tracker/svg/move-up.svg) **{{ ui-key.startrek.ui_components_projects_hooks.issue-actions--move-up }}** (только при ручной сортировке);
* ![](../../_assets/tracker/svg/move-down.svg) **{{ ui-key.startrek.ui_components_projects_hooks.issue-actions--move-down }}** (только при ручной сортировке);
* ![](../../_assets/tracker/svg/convert.svg) **Преобразовать в [веху](../manager/milestones.md) или задачу**.
* ![](../../_assets/tracker/svg/icon-remove.svg) **{{ ui-key.startrek.ui_components_projects_hooks.delete-from-project }}**;
* ![](../../_assets/tracker/svg/gantt-palette.svg) **Выбрать цвет** (только при настройке цвета **{{ ui-key.startrek.ui_components_Gantt.color-type-by-manual }}**).
