# Настроить доступ к очереди

{% note warning %}

По умолчанию настраивать очередь может только ее владелец.

{% endnote %}

## Настроить доступ к очереди {#set-access}

По умолчанию доступ пользователей к задачам очереди не ограничен.

В случае, если вы ограничите доступ к очереди, доступ к задачам по умолчанию будут иметь пользователи, указанные в полях **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--author }}**, **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--assignee }}**, **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--followers }}**, **Доступ**.


{% note warning %}

Для создания и редактирования задач, кроме доступа к очереди, пользователю требуется [полный доступ](../access.md) к {{ tracker-name }}. Подробнее читайте в разделе [{#T}](../role-model.md).

{% endnote %}


Вы можете изменить настройки доступа для отдельных пользователей, групп или ролей:

1. Откройте [страницу очереди](../user/queue.md).

1. В правом верхнем углу страницы нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--permissions }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.tab--queue }}**.

1. Добавьте пользователей и группы, для которых нужно настроить доступ:
    * **{{ ui-key.startrek.blocks-desktop_roles-table.users }}** — индивидуальные настройки для отдельных пользователей. Чтобы добавить пользователя в эту категорию, введите его логин или имя в строку поиска в верхней части таблицы.
    * **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.permissions-group--groups }}** — настройки для всех сотрудников.
        

    * **{{ ui-key.startrek.blocks-desktop_roles-table.roles }}** — настройки для пользователей, обладающих определенными ролями по отношению к задачам очереди:
        * **{{ ui-key.startrek-backend.roles.role.name.access }}** — пользователи, перечисленные в поле **{{ ui-key.startrek-backend.fields.issue.access }}** задачи;
        * **{{ ui-key.startrek-backend.roles.role.name.follower-key-value }}** — пользователи, подписавшиеся на задачу;
        * **{{ ui-key.startrek-backend.roles.role.name.author }}** — автор задачи;
        * **{{ ui-key.startrek-backend.roles.role.name.assignee }}** — исполнитель задачи;
        * **{{ ui-key.startrek-backend.roles.role.name.queue-lead }}**;
        * **{{ ui-key.startrek-backend.roles.role.name.team-member }}** — пользователи, добавленные в [команду очереди](queue-team.md). По умолчанию этой роли нет в списке, ее можно добавить с помощью строки поиска вверху таблицы.

1. Задайте права на действия с очередью:
    * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--create }}** — пользователи могут создавать новые задачи в этой очереди. 
    * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--read }}** — пользователи могут комментировать задачу и менять ее статус, но не имеют возможности менять значения полей в задаче.

        {% note info %}

        Для [изменения статуса одновременно у нескольких задач](bulk-change.md#change-status) прав на просмотр недостаточно. Необходимо иметь права на редактирование задач.

        {% endnote %}

    * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--write }}** — пользователи могут комментировать задачу, менять ее статус и редактировать поля задачи (например, изменять дедлайн, добавлять наблюдателей и так далее). 
    * **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**. — пользователи могут изменять [параметры очереди](edit-queue-general.md). 

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.save }}**.

Если пользователь одновременно обладает несколькими ролями, то ему доступны права на все действия, которые разрешены настройками этих ролей.

> **Пример**
>
> ![](../../_assets/tracker/access-roles.png)
>
> Если пользователь является одновременно автором и исполнителем задачи, у него будут права на **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--create }}**, **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--read }}** и **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--write }}**.

## Добавить сообщение для пользователей, у которых нет доступа {#deny-message}

По умолчанию при попытке открыть задачу очереди, к которой нет доступа, пользователи видят сообщение <q>Обратитесь к владельцу очереди</q> и имя владельца.

Вы можете изменить это сообщение. Например, указать другого пользователя с правами администратора очереди, к которому можно обратиться для получения доступа. Или написать, по какой причине доступ к очереди закрыт.

Чтобы изменить сообщение для пользователей, у которых нет доступа к очереди:

1. Откройте [страницу очереди](../user/queue.md).

1. В правом верхнем углу страницы нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--permissions }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.tab--queue }}**.

1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.access-denied-msg }}** нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.update-access-denied-msg-btn }}**.

1. Напишите сообщение и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.save }}**. 
  

## Настроить доступ к задачам с компонентом {#access-components}

Вы можете настраивать доступ к различным [компонентам](components.md) очереди. Это позволит задавать разные настройки для задач очереди без компонентов и для задач с компонентами. 

{% note warning %}

Правила доступа к компоненту имеют приоритет над правилами доступа к очереди.

{% endnote %}

Чтобы настроить доступ к задачам компонента:

1. Откройте [страницу очереди](../user/queue.md).

1. [Добавьте в очередь компоненты](components.md#create-component), с помощью которых вы будете разграничивать доступ к задачам.

1. В правом верхнем углу страницы нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--permissions }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.tab--components }}**.

1. Добавьте пользователей и группы, для которых нужно настроить доступ:
    * **{{ ui-key.startrek.blocks-desktop_roles-table.users }}** — индивидуальные настройки для отдельных пользователей. Чтобы добавить пользователя в эту категорию, введите его логин или имя в строку поиска в верхней части таблицы.

    * **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.permissions-group--groups }}** — настройки для всех сотрудников.

		

    * **{{ ui-key.startrek.blocks-desktop_roles-table.roles }}** — настройки для пользователей, обладающих определенными ролями по отношению к задачам очереди:
        * **{{ ui-key.startrek-backend.roles.role.name.access }}** — пользователи, перечисленные в поле **{{ ui-key.startrek-backend.fields.issue.access }}** задачи;
        * **{{ ui-key.startrek-backend.roles.role.name.follower-key-value }}** — пользователи, подписавшиеся на задачу;
        * **{{ ui-key.startrek-backend.roles.role.name.author }}** — автор задачи;
        * **{{ ui-key.startrek-backend.roles.role.name.assignee }}** — исполнитель задачи;
        * **{{ ui-key.startrek-backend.roles.role.name.queue-lead }}**;
        * **{{ ui-key.startrek-backend.roles.role.name.team-member }}** — пользователи, добавленные в [команду очереди](queue-team.md). По умолчанию этой роли нет в списке, ее можно добавить с помощью строки поиска вверху таблицы.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.save }}**.

	{% note tip %}

	Если нужно отключить специальные права доступа для компонента, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.reset }}**.

	{% endnote %}

1. Чтобы настроить для отдельной задачи доступ, который отличается от настроек доступа всей очереди, добавьте в задачу компонент.

Если задача относится к нескольким компонентам, доступ к задаче имеют все пользователи, которым разрешен доступ хотя бы к одному компоненту.

> **Пример**
>
> ![](../../_assets/tracker/access-components.png)
>
> Если задача относится к компонентам **Hardware** и **Software**, доступ к ней будут иметь как пользователи из группы <q>Разработка продуктов</q>, так и пользователи из группы <q>Разработка приложений</q>.

