# Как создать проект

## Создать проект {#create-project}

Вы можете создать полностью новый проект или взять за основу задачу.

### Новый проект {#new-project}

Чтобы создать проект:

1. Перейдите на любую страницу, с которой можно создать проект:

   * На панели слева выберите ![](../../_assets/tracker/svg/project.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-queues-info.projects }}**, затем нажмите **Создать** → **Проект**.
   * В [списке портфелей и проектов](my-projects.md) на вкладке **Список** под списком нажмите **Создать проект**.

1. Введите название проекта. Лучше, если оно будет коротким и понятным — так с проектом будет проще работать.

1. На вкладке **{{ ui-key.startrek.ui_components_projects_HeaderTabs.description-tab }}** добавьте информацию:

   * Описание проекта: над чем вы работаете и каких целей хотите достичь.
   * Прикрепленные файлы: рабочие материалы проекта.
   * Чеклист: список значимых этапов или целей проекта.
   * **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--status }}**: укажите, на каком этапе находится проект.
   * **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--startDate }}** и **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--endDate }}**.
   * **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--lead }}**, **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--clients }}** и **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--teamUsers }}**: начните вводить имя или логин сотрудника и выберите подходящий вариант из списка.
   * **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--tags }}**: добавьте или выберите теги, с помощью которых будет проще найти нужный проект.

1. [Добавьте](#add-tickets) в проект задачи. Вы можете добавить задачи со страницы проекта или со страницы задачи, а также при помощи операции [массового редактирования](bulk-change.md).

   Проект не привязан к очереди задач, поэтому в него можно добавить задачи из любой очереди, к которой у вас есть доступ. Доступ к задачам проекта зависит от [настроек доступа](../user/queue.md) очереди, к которой относится задача.

   {% note info %}

   * Одну и ту же задачу нельзя добавить в несколько проектов.
   * В проект можно добавить не более 2000 задач.
   
   {% endnote %}

1. По умолчанию новый проект будет доступен всем сотрудникам организации. Чтобы ограничить доступ к проекту, в верхнем правом углу страницы нажмите значок замка и выберите **{{ ui-key.startrek.ui_components_ProjectAccessButton.private-access }}**. Тогда проект будет доступен только тем пользователям, которые указаны в полях **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--teamUsers }}**, **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--createdBy }}**, **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--clients }}** и **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--lead }}**.

### Конвертировать задачу в проект {#convert-from-task}

Конвертируемая задача будет добавлена в проект, а в новом проекте отобразятся ее параметры:
* название, описание, чеклист;
* дата начала и завершения;
* автор, исполнитель и наблюдатели.

Комментарии к задаче сконвертируются в комментарии к проекту и отобразятся на вкладке **{{ ui-key.startrek.ui_components_projects_HeaderTabs.description-tab }}**.  

Чтобы создать проект на основе задачи:

1. Откройте страницу задачи. Задача не должна принадлежать другому проекту. Чтобы удалить задачу из проекта, очистите поле **{{ ui-key.startrek-backend.fields.issue.project-key-value }}** на панели справа.

1. В правом верхнем углу выберите **{{ ui-key.startrek.ui_components_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_IssueMenu.convert-to-project }}** и нажмите **Конвертировать**.

## Добавить задачи в проект {#add-tickets}

#### Со страницы проекта {#from-project}

1. Перейдите на вкладку **{{ ui-key.startrek.ui_components_projects_HeaderTabs.issues-tab }}** и нажмите **{{ ui-key.startrek.ui_components_projects_Table.add-issue }}**.

1. Чтобы создать новую задачу: 
   
   1. Выберите **{{ ui-key.startrek.ui_components_CreateIssuePopup.new-issue }}**.
   1. Укажите название задачи, выберите очередь и нажмите клавишу **Enter**.

1. Чтобы добавить существующую задачу:

   1. Выберите **{{ ui-key.startrek.ui_components_CreateIssuePopup.existing-issue }}**.
   1. Начните вводить ключ или название задачи и выберите подходящий вариант из списка.

#### Со страницы задачи {#from-ticket}

1. Откройте страницу задачи.

1. Нажмите на поле **{{ ui-key.startrek-backend.fields.issue.project-key-value }}** на панели справа. Если поля **{{ ui-key.startrek-backend.fields.issue.project-key-value }}** нет, добавьте его с помощью кнопки **{{ ui-key.startrek.ui_components_issues-import_IssuesImportFilters.add-parameters }}**.

1. Начните вводить название проекта в поле **{{ ui-key.startrek-backend.fields.issue.project-key-value }}** и выберите подходящий вариант из списка.

#### Добавить несколько задач {#from-bulk}

1. Отберите нужные задачи с помощью [фильтра](../user/create-filter.md).

1. Выберите задачи, которые вы хотите добавить в проект.

1. На панели снизу нажмите ![](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-to-projects }}**.

1. Начните вводить название проекта и выберите подходящий вариант из списка. 

1. Дождитесь окончания обработки задач.

#### Импортировать задачи {#from-import}

1. Откройте страницу проекта.

1. В верхнем правом углу нажмите **{{ ui-key.startrek.ui_components_Project_Header_IssuesImportButton.import-issues }}**.

1. Нажмите ![](../../_assets/tracker/svg/add-task.svg)&nbsp;**{{ ui-key.startrek.ui_components_issues-import_IssuesImportFilters.add-parameters }}** и задайте условие для выбора задач. 

1. Нажмите **{{ ui-key.startrek.ui_components_issues-import_IssuesImportDialog.import }}** и дождитесь окончания импорта задач.

## Удалить проект {#delete}

{% note alert %}

Удалить проект может его автор и пользователь, указанный в поле **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--lead }}**.

{% endnote %}

Чтобы удалить проект:

1. На панели слева выберите ![](../../_assets/tracker/svg/project.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-queues-info.projects }}** или перейдите по [прямой ссылке]({{ link-tracker }}pages/projects/list) и откройте страницу проекта.

1. В правом верхнем углу страницы нажмите ![](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.startrek.ui_components_ProjectMenu.remove-project }}**.