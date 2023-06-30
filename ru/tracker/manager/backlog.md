# Бэклог

Бэклог — это список задач или требований к продукту, которые нужно реализовать. Обычно задачи в бэклоге упорядочены по приоритету.

{% note warning %}

Работа с бэклогом возможна только на досках типа **{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--scrum-development-preset }}** или на [новых досках](agile-new.md).

{% endnote %}

## Бэклог на новых досках {#new-backlog}

В [новых досках](agile-new.md) для бэклога можно подключить отдельную вкладку. Вкладка **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** состоит из двух частей:

* задачи бэклога;
* спринты.

На вкладке **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** можно собрать список приоритетных задач команды, отсортировать их по важности и распределить по спринтам. Вы сможете создавать задачи или добавлять существующие как в бэклог, так и сразу в спринт. Чтобы взять задачу из бэклога в спринт, достаточно перетащить ее карточку из одного списка в другой.

Следите за актуальностью задач в бэклоге: в нем не должно быть закрытых задач, дубликатов, а также задач, которые не будут взяты в работу в ближайшее время.

{% note warning %}

Отдельная вкладка **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** подключается прямо на доске. Отключить вкладку **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** и спринты пока нельзя, но в будущем появится такая возможность.

{% endnote %}

Чтобы включить бэклог и спринты на новых простых досках:
1. Нажмите **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader_EnableBacklogButton.enable-backlog }}** в верхней части экрана.
1. Если на доске уже есть задачи, выберите, куда их перенести: в бэклог или спринт.

Появится вкладка **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** со списком задач бэклога и спринтами.

## Как добавить задачи в бэклог на новых досках {##add-new-backlog}

Чтобы добавить одну задачу:
1. Решите, куда требуется добавить задачу: в бэклог или спринт, и в нужном разделе нажмите **+ {{ ui-key.startrek.ui_components_agile_common_AddIssueButton.add-issue-button }}**.
1. Выберите существующую задачу или создайте новую прямо на доске. Вы можете добавить или создать задачу из любой доступной вам очереди.

Чтобы добавить группу задач, например, все задачи очереди с определенным исполнителем, выполните импорт задач:
1. Нажмите **{{ ui-key.startrek.ui_components_agile_backlog_BacklogIssuesImportButton.import-issues }}** в верхней части экрана.
1. Выберите, куда поместить задачу: в бэклог или в спринт.
1. Нажмите **+ {{ ui-key.startrek.ui_components_issues-import_IssuesImportFilters.add-parameters }}** и задайте условие для выбора задач. Нажмите **{{ ui-key.startrek.ui_components_issues-import_IssuesImportDialog.import }}**. Задачи появятся на вкладке **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** или среди задач бэклога, или в спринте.