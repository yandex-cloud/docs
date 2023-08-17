# Изменить несколько задач

Вы можете изменить статусы и параметры сразу нескольких задач. Чтобы открыть список задач, перейдите на страницу очереди или фильтра.

## Изменить статус {#change-status}

Чтобы изменить статус задач:

1. Откройте список задач.

1. Поставьте отметку ![](../../_assets/tracker/svg/check.svg) возле задач, которые вы хотите изменить.
   
   Если вы хотите выбрать сразу все задачи на странице очереди или фильтра, поставьте отметку ![](../../_assets/tracker/svg/check.svg) над списком задач.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.change-status }}** под списком задач и выберите статус. 
   
   Доступны только те переходы между статусами, которые разрешены в [воркфлоу](workflow.md). Если вы выберете переход, который доступен только для части задач, статус изменится только у них.
   
1. После выполнения операции в правом нижнем углу отобразится уведомление о количестве задач, для которых успешно изменен статус.
   
   Чтобы открыть список задач, для которых невозможно выполнить переход в выбранный статус, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_guide.ticket--buttons--workflow_buttons--content-link }}** в уведомлении.

## Перенести задачи в другую очередь {#change-queue}

Чтобы изменить очередь задач:

1. Откройте список задач.

1. Поставьте отметку ![](../../_assets/tracker/svg/check.svg) возле задач, которые вы хотите перенести.
   
   Если вы хотите выбрать сразу все задачи на странице очереди или фильтра, поставьте отметку ![](../../_assets/tracker/svg/check.svg) над списком задач.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.move }}** под списком задач.

1. Выберите очередь, в которую будут перемещены задачи.

1. После выполнения операции в правом нижнем углу отобразится уведомление о количестве задач, которые успешно перемещены в другую очередь.
   
   Чтобы открыть список задач, для которых невозможно выполнить перенос, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_guide.ticket--buttons--workflow_buttons--content-link }}** в уведомлении. Перенос невозможен для задач, которые уже существуют в выбранной очереди.

После переноса в другую очередь задачам будет присвоен новый ключ. Ссылки на задачу со старым ключом останутся рабочими. При переходе по такой ссылке задача автоматически откроется в новой очереди. Однако по старому ключу задачу нельзя будет найти с помощью [фильтра](../manager/quick-filters.md) или [запроса](../user/query-filter#query-format.md).

## Добавить связь {#add-links}

Чтобы добавить связь сразу нескольким задачам:

1. Откройте список задач.

1. Поставьте отметку ![](../../_assets/tracker/svg/check.svg) возле задач, для которых вы хотите добавить связанную задачу.
   
   Если вы хотите выбрать сразу все задачи на странице очереди или фильтра, поставьте отметку ![](../../_assets/tracker/svg/check.svg) над списком задач.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-link }}** под списком задач, выберите [тип связи](../user/links.md) и создайте связь:

      * Чтобы создать новую задачу, выберите вкладку **{{ ui-key.startrek.ui_components_CreateIssuePopup.new-issue }}**. Введите название и нажмите клавишу **Enter**.
        
      * Если задача уже существует, выберите вкладку **{{ ui-key.startrek.ui_components_CreateIssuePopup.existing-issue }}** и укажите ее ключ или название, затем выберите задачу из списка. Найти ключ можно на странице задачи над ее названием (например, `TEST-1234`).

## Добавить задачи на доску или в проект {#add-project-board}

Чтобы добавить задачи на доску или в проект:

1. Откройте список задач.

1. Поставьте отметку ![](../../_assets/tracker/svg/check.svg) возле задач, которые вы хотите добавить на доску или в проект.
   
   Если вы хотите выбрать сразу все задачи на странице очереди или фильтра, поставьте отметку ![](../../_assets/tracker/svg/check.svg) над списком задач.

1. Нажмите кнопку ![](../../_assets/horizontal-ellipsis.svg) под списком задач.

   * Чтобы добавить задачи на доску, выберите **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-to-board }}**. Выберите одну или несколько досок и нажмите **{{ ui-key.startrek.ui_components_bulk_BulkChangeParametersDialog.button-submit-text }}**.

   * Чтобы добавить задачу в проект, выберите **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-to-projects }}**. Все подзадачи также будут добавлены в проект.

## Изменить параметры {#change-parameters}

Чтобы изменить параметры задач:

1. Откройте список задач.

1. Поставьте отметку ![](../../_assets/tracker/svg/check.svg) возле задач, которые вы хотите изменить.
   
   Если вы хотите выбрать сразу все задачи на странице очереди или фильтра, поставьте отметку ![](../../_assets/tracker/svg/check.svg) над списком задач.

1. Нажмите кнопку ![](../../_assets/horizontal-ellipsis.svg) под списком задач и выберите **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.edit-parameters }}**.

1. Выберите нужные параметры. Если нужных полей нет в списке, добавьте их с помощью кнопки **{{ ui-key.startrek.ui_components_BulkChangeParametersDialog.add-parameter }}**.

1. Задайте значения.
   
   Некоторые поля могут содержать список значений (например, поля <q>{{ ui-key.startrek.components_FormCreateIssue.field--followers }}</q>, <q>{{ ui-key.startrek-backend.messages.workflow.field.maillists }}</q> или <q>{{ ui-key.startrek.components_FormCreateIssue.field--tags }}</q>). По умолчанию новые значения дописываются в конец списка. Чтобы перезаписать поле, включите опцию **{{ ui-key.startrek.ui_components_BulkChangeParametersDialog.clear-previous-value }}**.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_BulkSuggestPopup.apply }}**.

## Стать участником задач {#change-my-tickets}

Чтобы добавить или удалить себя из полей **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.assignee }}** или **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.followers }}** в задачах:

1. Откройте список задач.

1. Поставьте отметку ![](../../_assets/tracker/svg/check.svg) возле задач, которые вы хотите изменить.
   
   Если вы хотите выбрать сразу все задачи на странице очереди или фильтра, поставьте отметку ![](../../_assets/tracker/svg/check.svg) над списком задач.

1. Нажмите кнопку ![](../../_assets/horizontal-ellipsis.svg) под списком задач и выберите вариант:

   * Чтобы стать участником задачи, выберите **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-me-to-followers }}** или **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.assignee-me }}**.

   * Чтобы отменить свое участие в задаче, выберите **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.remove-me-from }}** и укажите вариант: **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.followers }}**, **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.assignee }}** или **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.remove-from-both-fields }}**.
