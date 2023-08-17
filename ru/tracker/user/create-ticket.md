# Как создать задачу

Вы можете создавать задачи в любой из доступных [очередей](../queue-intro.md). Выбирайте очередь так, чтобы ее тематика соответствовала тематике задачи. Если вы не знаете, в какой очереди создать задачу, уточните это у руководителя проекта или администратора вашей организации.


## Создать задачу {#create-task}

Чтобы создать задачу:

1. Нажмите кнопку ![](../../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.blocks-desktop_m-head.new-issue }}** на панели слева.

1. В левом верхнем углу выберите очередь, в которой вы хотите создать задачу.

    {% note info %}

    Владелец очереди может [настроить упрощенные формы](../manager/attach-form.md) для создания задач в очереди. В этом случае выберите подходящую форму и заполните поля, следуя подсказкам. Если вы сомневаетесь, как правильно заполнять форму, обратитесь к владельцу очереди.

    Если к очереди не подключено ни одной упрощенной формы, откроется стандартная форма создания задачи.

    {% endnote %}

1. Введите название задачи.

1. Добавьте описание задачи. Для форматирования текста используйте [разметку YFM](markup.md).

1. Чтобы добавить в задачу файлы или изображения, нажмите **{{ ui-key.startrek.ui_components_AttachmentsManager.attach }}**.

1. Чтобы добавить список этапов выполнения задачи, нажмите кнопку **{{ ui-key.startrek.ui_components_IssueChecklist.add-checklist }}**.

1. На панели справа укажите: 
    
    * Основные параметры задачи: <q>{{ ui-key.startrek.components_FormCreateIssue.field--type }}</q>, <q>{{ ui-key.startrek.components_FormCreateIssue.field--priority }}</q>, <q>{{ ui-key.startrek.components_FormCreateIssue.field--dueDate }}</q>, <q>{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.field-type--project }}</q>, <q>{{ ui-key.startrek.components_FormCreateIssue.field--tags }}</q>.

    * Список пользователей, которые имеют отношение к задаче: введите имя или логин в полях <q>{{ ui-key.startrek.components_FormCreateIssue.field--assignee }}</q> и <q>{{ ui-key.startrek.components_FormCreateIssue.field--followers }}</q> или нажмите кнопку **{{ ui-key.startrek.blocks-desktop_i-autocomplete-control.assign-me }}**, чтобы добавить себя.
    
        Вы также можете оставить значения по умолчанию, чтобы настроить их позже.

1. При необходимости задайте [дополнительные параметры](create-param.md#default-fields). Для этого добавьте поля с помощью кнопки ![](../../_assets/tracker/task-params-btn.png) **{{ ui-key.startrek.ui_components_PageCreateIssue.add-parameter }}** и заполните их.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_CreateIssueForm.create-issue }}**.

    {% note tip %}

    Если вам приходится создавать много похожих задач, создайте для них [шаблон](ticket-template.md).

    {% endnote %}

## Ключ задачи {#key}

Каждой новой задаче автоматически присваивается ключ — уникальный код, по которому задачу можно идентифицировать. Ключ задачи состоит из [ключа очереди](../manager/create-queue.md#key) и номера задачи (например, `TEST-1234`). На странице задачи ключ отображается под ее заголовком.

Ключ задачи можно использовать:

* Чтобы [создать связь с задачей](ticket-links.md).
* Чтобы ссылаться на задачу в других задачах — для этого вставьте ключ очереди в текст комментария или в описание задачи. Он будет преобразован в ссылку.
* Для прямого доступа к задаче по адресу: `({{ link-tracker-example-1 }})`.

## Создать подзадачу {#subtask}

Сложные задачи можно разбить на более простые подзадачи и отслеживать их выполнение отдельно. После создания подзадачи вы можете изменить [тип связи](links.md).

Чтобы создать подзадачу:

1. Откройте страницу задачи, к которой вы хотите создать подзадачу.

1. В правом верхнем углу выберите **{{ ui-key.startrek.ui_components_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_IssueMenu.create-subissue }}**.

1. Заполните поля так же, как при [создании новой задачи](#create-task).

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_CreateIssueForm.create-issue }}**.


#### Следующий шаг 

[Как просмотреть мои задачи](my-tickets.md)



