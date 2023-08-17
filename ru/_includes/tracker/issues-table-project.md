* Чтобы выбрать поля, которые вы хотите видеть в таблице списка задач слева от диаграммы, нажмите значок ![](../../_assets/tracker/svg/settings-old.svg). Отметьте нужные пункты и нажмите **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.

* Чтобы найти задачи в списке, в поле **{{ ui-key.startrek.ui_components_filter-pane.search-placeholder }}** введите текст.

* Чтобы настроить порядок отображения в списке, нажмите ![](../../_assets/tracker/svg/sorting.svg)&nbsp;**{{ ui-key.startrek.ui_components_SortButton.default-title }}**, укажите параметр и нажмите ![](../../_assets/tracker/svg/new-first.svg). В этом случае ручное перемещение задач станет недоступно.

* Чтобы сгруппировать задачи по статусу, исполнителю или другим параметрам, нажмите кнопку ![](../../_assets/tracker/svg/group.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_issues-table.group-by--null }}** и выберите подходящий вариант из списка.

* Чтобы отфильтровать список задач, используйте конструктор фильтров. Для этого на панели ![](../../_assets/tracker/svg/filter.svg)&nbsp;**{{ ui-key.startrek.ui_components_IssueListsPanel.filters }}** выберите параметры и укажите значения, по которым будет сформирован список задач.

* Чтобы поменять местами столбцы списка, над списком нажмите значок ![](../../_assets/tracker/svg/settings-old.svg). Затем в блоке **{{ ui-key.startrek.ui_components_Table2.added-columns }}** зажмите параметр и перетащите его внутри блока. Нажмите **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.

* Чтобы изменить размер столбца в блоке, зажмите его край и измените ширину.

* Чтобы скрыть блок со списком задач, нажмите на значок ![](../../_assets/tracker/svg/close-block.svg).

* Чтобы изменить вид списка задач, выберите ![](../../_assets/tracker/svg/flat-list.svg)&nbsp;**{{ ui-key.startrek.ui_components_filter-pane.list-mode-flat }}** или ![](../../_assets/tracker/svg/tree-list.svg)&nbsp;**{{ ui-key.startrek.ui_components_filter-pane.list-mode-tree }}**.{#trees}

     {% note info %}

     В режиме древовидного списка вложенность одних задач в другие обозначает [связи](../../tracker/user/links.md) типа <q>Родительская задача — Подзадача</q>.

     {% endnote %}

   В режиме одноуровневого списка можно ранжировать (перемещать) задачи относительно других. Для этого слева от задачи зажмите ![](../../_assets/tracker/svg/range.svg) и перетащите ее на нужную позицию.

   В режиме древовидного списка можно создавать новые подзадачи или изменять связи для подзадач:

   * Чтобы создать подзадачу, напротив задачи нажмите кнопку ![](../../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.ui_components_projects_Table.add-sub-issue }}**:

      * Чтобы создать новую задачу, перейдите на вкладку **{{ ui-key.startrek.ui_components_CreateIssuePopup.new-issue }}**. Введите название и нажмите клавишу **Enter**.
      * Если задача уже существует, перейдите на вкладку **{{ ui-key.startrek.ui_components_CreateIssuePopup.existing-issue }}** и укажите ее ключ или название, затем выберите задачу из списка. Найти ключ можно на странице задачи над ее названием (например, `TEST-1234`).

   * Чтобы изменить связь, слева от подзадачи зажмите ![](../../_assets/tracker/svg/range.svg), сдвиньте указатель вправо и перетащите задачу под ту, которую хотите назначить родительской.

   * При выстраивании иерархии задач вы можете вкладывать одну задачу в другую или выносить подзадачу на верхний уровень. Чтобы вынести задачу на уровень выше, слева от подзадачи зажмите ![](../../_assets/tracker/svg/range.svg) и сдвиньте указатель влево.

   {% note info %}

   Ручное перемещение задач доступно, если в поле **{{ ui-key.startrek.ui_components_SortButton.default-title }}** не выбран параметр сортировки. По умолчанию для списка задач выбран ручной режим сортировки: вы можете перетаскивать задачи в списке. 

   {% endnote %}