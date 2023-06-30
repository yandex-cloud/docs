# Добавить команду очереди

{% note warning %}

По умолчанию настраивать очередь может [только ее владелец](queue-access.md).

{% endnote %}

Команда очереди — это сотрудники, которые создают и выполняют задачи в очереди. Владелец очереди — это сотрудник, у которого есть полные права на изменение настроек очереди. Вы можете задать команду и владельца очереди на вкладке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--team }}**.

## Изменить владельца очереди {#change-owner}

Владелец управляет очередью:

* редактирует ее [основные параметры](edit-queue-general.md);
* добавляет пользователей в [команду очереди](queue-team.md);
* настраивает [уведомления](subscriptions.md);
* изменяет [права доступа к очереди](queue-access.md).

Чтобы изменить владельца очереди:

1. Откройте [страницу очереди](../user/queue.md).

1. В правом верхнем углу страницы нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--team }}**.

1. Нажмите на значок ![](../../_assets/tracker/icon-edit.png) возле имени владельца.

1. Введите имя или логин нового владельца.

1. Чтобы все новые задачи автоматически назначались на владельца, включите опцию **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_team.field--bind-to-lead }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.save }}**.

## Изменить команду очереди {#edit-team}

В команду обычно входят пользователи, работающие над задачами очереди. Для участников команды вы можете настроить особые права доступа к задачам очереди.

Чтобы изменить список участников команды:

1. Откройте [страницу очереди](../user/queue.md).

1. В правом верхнем углу страницы нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--team }}**.

1. Чтобы добавить участника, введите имя или логин пользователя в поле **{{ ui-key.startrek.blocks-desktop_b-queue-form.queue-team }}**.

1. Чтобы удалить участника, нажмите на значок ![](../../_assets/tracker/remove-task-type.png) возле имени пользователя.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.save }}**.
