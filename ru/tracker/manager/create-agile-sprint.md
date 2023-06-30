# Спринты

{% note warning %}

Работа со спринтами возможна только на досках типа **{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--scrum-development-preset }}**.

{% endnote %}

{{ tracker-name }} поможет вам организовать работу по методологии Скрам. При таком подходе работа делится на спринты — итерации разработки определенной продолжительности. В начале каждой итерации происходит оценка задач и планирование работы на ближайший спринт.

## Спланировать спринт {#section_sjg_111_2gb}

#### Шаг 1. Оцените трудоемкость задач

Оцените трудоемкость задач бэклога. Трудоемкость оценивается в условных единицах Story Points, которые определяют сложность задач проекта относительно друг друга. Каждая команда самостоятельно договаривается, как именно определять трудоемкость своих задач.

Чтобы провести совместную командную оценку трудоемкости задач, используйте [покер планирования на доске задач](planning-poker.md).

Если у вас уже есть оценка трудоемкости задачи, вы можете [указать ее на странице задачи](../user/edit-ticket.md#edit-fields) в поле **{{ ui-key.startrek-backend.fields.issue.storyPoints }}**.

Чтобы указать оценки трудоемкости для нескольких задач при планировании спринта:

1. На верхней панели {{ tracker-name }} нажмите **{{ ui-key.startrek.blocks-desktop_m-head.menu-agile }}** и выберите вашу доску.

1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-board.sprints }}**.

1. Если задач слишком много, скройте лишние с помощью [фильтров](#section_ync_v5r_yfb).

1. Наведите курсор на задачу в колонке **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.tasks }}**.

1. Введите количество **{{ ui-key.startrek-backend.fields.issue.storyPoints }}** в поле справа.

    Чтобы добавить задачу на страницу покера для [командной оценки](planning-poker.md), нажмите кнопку ![](../../_assets/tracker/context-menu.png) и выберите пункт **{{ ui-key.startrek.blocks-desktop_b-sprint-task.actions-menu--add-to-poker }}**.

#### Шаг 2. Создайте новый спринт {#create_sprint}

1. Нажмите кнопку ![](../../_assets/tracker/add-sprint.png) в правой части блока **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.sprints }}**.

1. Введите название спринта и время его начала и окончания.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_sprint-form.button-save }}**.

#### Шаг 3. Добавьте задачи в спринт

Добавить задачу в спринт можно несколькими способами:

- На странице **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.sprints }}** перетащите задачу из колонки **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.tasks }}** в колонку спринта. Если задач слишком много, скройте лишние с помощью [фильтров](#section_ync_v5r_yfb).

- На странице задачи укажите спринт в соответствующем поле на панели справа.

- Чтобы быстро добавить много задач, воспользуйтесь [массовым редактированием](bulk-change.md#change-parameters): отфильтруйте задачи и укажите спринт в соответствующем поле при редактировании.

## Изменить статус спринта {#section_f1f_21r_yfb}

Статус указывает на готовность задач спринта. Чтобы изменить статус спринта:

1. На верхней панели {{ tracker-name }} нажмите **{{ ui-key.startrek.blocks-desktop_m-head.menu-agile }}** и выберите вашу доску.

1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.sprints }}**.

1. Нажмите значок ![](../../_assets/tracker/edit-sprint.png) справа от названия спринта.

1. Выберите один из статусов:

    Статус | Описание
    ----- | -----
    {{ ui-key.startrek-backend.applinks.samsara.status.open }} | Задачи спринта не взяты в работу.
    {{ ui-key.startrek-backend.applinks.samsara.status.in.progress }} | Задачи спринта находятся в работе.
    {{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }} | Задачи спринта решены.<br/><br/> Если в спринте есть незакрытые задачи или задачи, закрытые без резолюции, во всплывающем окне укажите что с ними делать: перенести в бэклог, перенести в новый спринт или оставить в этом спринте.
    {{ ui-key.startrek.blocks-desktop_b-sprints-list.sprint-status--archived }} | Спринт перемещен в архив и не отображается в общем списке спринтов. Чтобы открыть список архивных спринтов, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.archived-sprints }}**.<br/><br/>В архивный спринт нельзя добавить задачу.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_sprint-form.button-save }}**.

## Объединить задачи в эпик {#section_vj5_4f5_zfb}

Эпик — тип задачи, который позволяет группировать задачи из разных очередей и планировать трудозатраты.

На доске можно [создавать эпики и добавлять в них задачи](epic.md).

## Применить фильтры {#section_ync_v5r_yfb}

Чтобы на вкладке **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.sprints }}** отобразились только те задачи, которые обладают определенными параметрами, примените фильтры. Для этого:

1. На верхней панели {{ tracker-name }} нажмите **{{ ui-key.startrek.blocks-desktop_m-head.menu-agile }}** и выберите вашу доску.

1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.sprints }}**.

1. В левой части страницы выберите параметры отбора задач. Для этого нажмите кнопку фильтра:

    - **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.field-type--resolution }}**

        Чтобы на странице отобразились закрытые задачи с определенной резолюцией, выберите одну или несколько резолюций из списка.

    - **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.field-type--status }}**

        Чтобы на странице отобразились задачи с определенным статусом, выберите один или несколько статусов из списка.

    - **{{ ui-key.startrek.ui_components_agile_common_QuickFiltersItem.quick-filter--assignee-me }}**

        На странице спринта отобразятся задачи, которые пользователь выполняет.

    - **{{ ui-key.startrek.ui_components_agile_common_QuickFiltersItem.quick-filter--author-me }}**

        На странице спринта отобразятся задачи, которые пользователь создал.

    - [**{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.epics }}**](epic.md)

        Чтобы выбрать задачи, которые входят в эпик, нажмите на блок с названием эпика.

        Чтобы выбрать задачи, которые не объединены в эпики, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.without-epics }}**.

    - **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.versions }}**

        Чтобы на странице отобразились задачи, которые принадлежат к определенной версии, нажмите на блок с названием эпика.

    - **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.components }}**

        Чтобы на странице отобразились задачи с определенным компонентом, нажмите на блок с названием компонента.

    - **{{ ui-key.startrek.blocks-desktop_b-page-agile-sprints.tags }}**

        Чтобы на странице отобразились задачи с определенным тегом, нажмите на блок с названием тега.

## Настроить отображение спринтов {#section_jyp_w25_xgb}

Вы можете настроить страницу спринтов так, чтобы список задач и спринты отображались в одной колонке. Для этого:

1. {% include [open-personal-settings](../../_includes/tracker/open-personal-settings.md) %}

1. Выберите опцию **{{ ui-key.startrek.blocks-desktop_b-page-settings.sprint-columns-view-content }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_sprint-form.button-save }}**.

