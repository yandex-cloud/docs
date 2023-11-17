# Эпики

Эпик — [тип задачи](add-ticket-type.md), который позволяет группировать задачи, связанные общей темой. В эпик могут входить задачи из разных очередей и спринтов.

Эпики удобно использовать для декомпозиции работы, если вы работает по Agile-методологиям. Самые крупные задачи могут быть эпиками, далее они разбиваются на истории, а истории — на задачи для исполнителей.

{% note info %}

У эпика не может быть родительской задачи.
Эпик не может быть подэпиком другого эпика.
Создать эпик можно только в очереди, в которой есть эпик как тип задачи.

{% endnote %}

## Создать эпик на доске {#create-epic}

1. На доске нажмите кнопку ![](../../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.blocks-desktop_m-head.new-issue }}**.
1. Перейдите на страницу полной формы создания задачи. Для этого нажмите ![](../../_assets/tracker/svg/open-full.svg) (**{{ ui-key.startrek.ui_components_create-issue-popup_CreateIssuePageLink.open-create-form }}**).
1. Заполните все необходимые поля задачи. В поле **{{ ui-key.startrek.components_FormCreateIssue.field--type }}** укажите `{{ ui-key.startrek-backend.fields.issue.epic }}`. 
1. Нажмите кнопку **{{ ui-key.startrek.ui_components_CreateIssueForm.create-issue }}**.

## Добавить задачу в эпик {#add-to-epic}

Вы можете добавить задачу в эпик с помощью [связи](../user/ticket-links.md) одним из двух способов: со страницы эпика или со страницы задачи.

### Добавить со страницы эпика {#add-from-epic}

1. На странице эпика в блоке **{{ ui-key.startrek.ui_components_issue-links_InternalLinksCollapse.relations }}** нажмите **{{ ui-key.startrek.ui_components_CreateIssueLinkButton.add-relation }}**.

1. Выберите тип связи **{{ ui-key.startrek-backend.fields.issue.links.relationship.has.epic }}**.

1. Укажите [ключ задачи](../user/create-ticket.md#key).

### Добавить со страницы задачи {#add-from-task}

1. На странице задачи в блоке **{{ ui-key.startrek.ui_components_issue-links_InternalLinksCollapse.relations }}** нажмите **{{ ui-key.startrek.ui_components_CreateIssueLinkButton.add-relation }}**.

1. Выберите тип связи **{{ ui-key.startrek-backend.fields.issue.epic }}**.

1. Укажите [ключ эпика](../user/create-ticket.md#key).

{% note warning %}

Задача может входить только в один эпик.

{% endnote %}


## Создать новую задачу в эпике {#create-in-epic}

1. На странице эпика в блоке **{{ ui-key.startrek.blocks-desktop_b-related-issues__title.is_epic_of }}** нажмите ![](../../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.blocks-desktop_calendar-editor--overrides-modal.add-button }}**.
1. Заполните необходимые поля и сохраните задачу.

## Удалить задачу из эпика {#remove-from-epic}

Удалить задачу из эпика можно одним из двух способов: на странице задачи или на доске.

### Удалить задачу на странице задачи {#remove-from-task}

На странице задачи в блоке **{{ ui-key.startrek.ui_components_issue-links_InternalLinksCollapse.relations }}** в секции **{{ ui-key.startrek-backend.fields.issue.epic }}** удалите связь с эпиком.

### Удалить задачу на доске {#remove-on-board}

На доске [сгруппируйте задачи по эпику](#group-by-epic) и перетащите карточку задачи в раздел **{{ ui-key.startrek.ui_components_IssuesGroupHeader.no-epic }}**.

## Сгруппировать задачи по эпикам {#group-by-epic}

1. На странице доски в правом верхнем углу нажмите кнопку ![](../../_assets/tracker/svg/group.svg).
1. В списке опций выберите **{{ ui-key.startrek-backend.fields.issue.epic }}**.

## Отфильтровать задачи по эпику {#filter-by-epic}

Вы можете настроить отображение задач по эпику на доске и на странице очереди.

### Отфильтровать задачи на доске {#filter-on-board}

Чтобы отфильтровать задачи по эпику на доске:

1. В верхнем правом углу нажмите ![](../../_assets/tracker/svg/filter.svg)&nbsp;**{{ ui-key.startrek.ui_components_page-issues_touch_FilterSettingsMenu.item-filters }}**. Над колонками доски отобразится панель для настройки фильтра. 
1. Нажмите значок ![](../../_assets/tracker/svg/add-filter.svg). Выберите **{{ ui-key.startrek-backend.fields.issue.epic }}**. 
1. В диалоговом окне введите ключ эпика, по которому хотите отфильтровать задачи.

### Отфильтровать задачи на странице очереди {#filter-in-queue}

Вы также можете отфильтровать задачи в очереди или на странице задач с помощью [языка запросов](../user/query-filter.md):

1. В правом верхнем углу страницы нажмите ![](../../_assets/tracker/svg/query-language.svg) **{{ ui-key.startrek.ui_components_dashboard_FilterEditor.editor-source-radio-query }}**. Все текущие параметры поиска, которые были заданы с помощью быстрых фильтров и условий, отобразятся в строке запроса.
1. Добавьте в строку условия для фильтрации по эпику. Например:

	* Отобразить все задачи, у которых есть эпик:

		```
		epic: notEmpty()
		```

	*  Отобразить все задачи из эпика с ключом `EPIC-1`:

		```
		epic: "EPIC-1"
		```
