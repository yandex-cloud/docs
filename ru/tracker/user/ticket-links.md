# Изменить связи задачи

Задачу можно связать с другими задачами, чтобы сгруппировать задачи с общей темой или обозначить их зависимость друг от друга.

Число связей задачи не ограничено. Список связанных задач отображается под описанием задачи.

Также к задаче можно привязать [коммит в репозиторий](#section_commit). 

{% note info %}

Связь с задачей создается автоматически, если указать ее ключ в комментарии или описании.

{% endnote %}

## Добавить связь {#add-link}

Чтобы создать связь с другой задачей:

1. Под описанием задачи нажмите **{{ ui-key.startrek.ui_components_CreateIssueLinkButton.add-relation }}**.

1. Выберите подходящий [тип связи](links.md) и создайте связь:

    * Чтобы создать новую задачу, выберите вкладку **{{ ui-key.startrek.ui_components_CreateIssuePopup.new-issue }}**. Введите название и нажмите клавишу **Enter**.

    * Если задача уже существует, выберите вкладку **{{ ui-key.startrek.ui_components_CreateIssuePopup.existing-issue }}** и укажите ее ключ или название, затем выберите задачу из списка. Найти ключ можно на странице задачи над ее названием (например, `TEST-1234`).

Чтобы добавить связь сразу нескольким задачам, используйте [массовые операции](../manager/bulk-change.md#add-links).

## Создать подзадачу {#create-subtask}

Сложные задачи можно разбить на более простые подзадачи и отслеживать их выполнение отдельно. После создания подзадачи вы можете изменить [тип связи](links.md).

Чтобы создать подзадачу:

1. Откройте страницу задачи, к которой вы хотите создать подзадачу.

1. В правом верхнем углу выберите **{{ ui-key.startrek.ui_components_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_IssueMenu.create-subissue }}**.

1. Заполните поля так же, как при [создании новой задачи](./create-ticket.md).

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_CreateIssueForm.create-issue }}**. Вверху страницы над названием подзадачи отобразится ссылка на родительскую задачу.

## Изменить тип связи {#change-link-type}

Чтобы изменить [тип связи](links.md) у задачи:

1. Откройте страницу одной из двух связанных задач.

1. В списке **{{ ui-key.startrek.ui_components_IssueLinks.links-group-title--relates }}** под описанием задачи выберите связь, тип которой требуется изменить.

1. Напротив связанной задачи нажмите ![](../../_assets/horizontal-ellipsis.svg) → **Изменить тип связи** и выберите новый тип.

## Удалить связь {#delete-link}

Чтобы удалить связь у задачи:

1. Откройте страницу одной из двух связанных задач.

1. В списке **{{ ui-key.startrek.ui_components_IssueLinks.links-group-title--relates }}** под описанием задачи выберите связь, которую требуется удалить.

1. Напротив связанной задачи нажмите кнопку ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **{{ ui-key.startrek.blocks_touch_b-related-issues.delete }}**.

## Сделать задачу подзадачей {#make-subtask}

Задачу можно сделать частью более крупной (родительской) задачи:

1. В правом верхнем углу выберите **{{ ui-key.startrek.ui_components_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_IssueMenu.to-subissue }}**.

1. Укажите ключ или название родительской задачи, затем выберите ее из списка. Найти ключ можно на странице задачи над ее названием (например, `TEST-1234`).

1. Нажмите **{{ ui-key.startrek.components_FormButtons.update }}**.

## Изменить родительскую задачу {#edit-parent-task}

1. Откройте страницу подзадачи.

1. В правом верхнем углу выберите **{{ ui-key.startrek.ui_components_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_IssueMenu.to-subissue }}**.

1. Укажите ключ или название новой родительской задачи, затем выберите ее из списка. Найти ключ можно на странице задачи над ее названием (например, `TEST-1234`).

1. Нажмите **{{ ui-key.startrek.components_FormButtons.update }}**.

## Удалить связь с родительской задачей {#delete-parent-task}

Чтобы удалить связь с родительской задачей:

1. Откройте страницу родительской задачи.

1. В списке **{{ ui-key.startrek.ui_components_IssueLinks.links-group-title--relates }}** под описанием задачи выберите подзадачу, связь с которой требуется удалить.

1. Напротив связанной задачи нажмите кнопку ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **{{ ui-key.startrek.blocks_touch_b-related-issues.delete }}**.

## Связать коммит с задачей {#section_commit}

Вы можете привязать к задаче коммит в репозиторий, который [подключен к {{ tracker-name }}](../user/add-repository.md). Для этого укажите ключ задачи в комментарии к коммиту. Привязанные коммиты можно просмотреть:

* на странице задачи в разделе **{{ ui-key.startrek.ui_components_IssueLinks.external-relations }}**;
* на странице очереди в правом верхнем углу в разделе ![](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.startrek.blocks-desktop_b-ticket-workflow.commits }}**.

Если вы не видите раздел  **{{ ui-key.startrek.blocks-desktop_b-ticket-workflow.commits }}**, убедитесь, что она включена в [настройках очереди](../manager/edit-queue-general.md).
