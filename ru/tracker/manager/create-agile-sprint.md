# Спринты

{{ tracker-name }} поможет вам организовать работу по методологии Скрам. При таком подходе работа делится на спринты — итерации разработки определенной продолжительности. В начале каждой итерации происходит оценка задач и планирование работы на ближайший спринт.

{% note warning %}

Работа со спринтами по умолчанию подключена на досках **С бэклогом и спринтами**. Если вы хотите работать со спринтами на **Простой доске**, [включите на ней бэклог](backlog.md#add-backlog).

{% endnote %}

## Спланировать спринт {#planning}

#### Шаг 1. Оцените трудоемкость задач

Оцените трудоемкость задач бэклога. Трудоемкость оценивается в условных единицах **Story Points**, которые определяют сложность задач проекта относительно друг друга. Каждая команда самостоятельно договаривается, как именно определять трудоемкость своих задач. Оценку задачи можно [указать на странице задачи](../user/edit-ticket.md#edit-fields) в поле **Story Points**.

Для командной оценки задач используйте [покер планирования на доске задач](poker.md).

#### Шаг 2. Создайте новый спринт {#create_sprint}

После создания доски на вкладке **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** у нее уже создан первый спринт. Если вы его еще не спланировали, переходите к следующему шагу. Если первый спринт у вас уже завершен и вы хотите создать новый:

1. На вкладке **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** в правой части доски нажмите **+ {{ ui-key.startrek.ui_components_agile_common_SprintForm.create-sprint }}**.

1. Введите название спринта, выберите длительность и укажите время его начала и окончания. Чтобы сразу взять спринт в работу, оставьте опцию **{{ ui-key.startrek.ui_components_agile_common_SprintFormFields.take-sprint-to-work }}** включенной. 

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_agile_common_SprintForm.create-sprint }}**.

#### Шаг 3. Добавьте задачи в спринт

Добавить задачу в спринт можно несколькими способами:

- На вкладке **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** перетащите задачу из колонки **{{ ui-key.startrek.ui_components_agile_backlog_BacklogIssue.backlog-default-column }}** в колонку спринта.

- На странице задачи, на панели справа, в поле **{{ ui-key.startrek-backend.fields.issue.boards }}**, укажите название или идентификатор доски, а в блоке **{{ ui-key.startrek-backend.fields.issue.fields.agile }}**, в поле **{{ ui-key.startrek-backend.fields.issue.sprint }}**, выберите из списка нужный спринт.

- Чтобы быстро добавить много задач, воспользуйтесь [массовым редактированием](agile-new-issues.md#bulk): на доске, на карточке одной из задач, нажмите ![](../../_assets/tracker/svg/actions.svg) → **{{ ui-key.startrek.ui_components_agile_common_IssueActionsMenu.select-issue }}** и нажимайте на другие задачи, которые требуется добавить в спринт. Как только все задачи будут выбраны, на панели внизу доски нажмите **{{ ui-key.startrek.ui_components_agile_common_BulkActionsPanel.add-to-sprint }}** и выберите нужный.

## Редактировать спринт {#sprint-edit}

Для редактирования спринта:

1. Справа от заголовка спринта нажмите ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/svg/icon-edit.svg) **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardColumnHeader.column-menu--edit }}**.

1. В открывшемся окне вы можете изменить название спринта, длительность, время начала и окончания, а также включить опцию **{{ ui-key.startrek.ui_components_agile_common_SprintFormFields.take-sprint-to-work }}**.
   
1. Чтобы сохранить изменения, нажмите кнопку **{{ ui-key.startrek.ui_components_agile_common_SprintForm.edit-sprint }}**.

## Изменить статус спринта {#sprint-status}

Когда все задачи для спринта спланированы и наступает дата начала спринта, на доске, на вкладке **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}**, рядом со спринтом нажмите **{{ ui-key.startrek.ui_components_agile_common_StartSprintButton.start }}**.

Когда работа над спринтом завершится, нажмите рядом с ним **Завершить**. Если в спринте остались незавершенные задачи, вам будет предложено оставить их в текущем спринте, вернуть в бэклог или перенести в новый спринт, который сразу же можно создать. Как только все задачи будут завершены, спринт будет отображаться в блоке **{{ ui-key.startrek.ui_components_agile_common_FinishedSprintsButton.finished-sprints }}**.
