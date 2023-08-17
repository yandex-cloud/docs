# Уведомления о ваших задачах

Для каждой роли в {{ tracker-name }} можно настроить список событий, уведомления о которых вы хотите получать. Например, вы можете получать уведомления об изменении статуса задачи или добавлении к задаче комментария. 

## Настроить список событий {#section_iqn_y55_xgb}


1. На панели слева нажмите ![](../../_assets/tracker/svg/settings.svg) **{{ ui-key.yacloud.settings.label_settings }}**. Затем выберите ![](../../_assets/tracker/svg/interface.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.appearance-title }}** и нажмите **{{ ui-key.startrek.blocks-desktop_b-head.manage-subscriptions }}**. Вы также можете перейти по ссылке [{{ link-sub-roles }}]({{ link-sub-roles }}).

1. Выберите роль и настройте список событий, уведомления о которых хотите получать по почте или в [отчете об изменениях](notification-digest.md):
    - чтобы добавить событие, нажмите кнопку ![](../../_assets/tracker/button-plus.png);
    - чтобы удалить событие, нажмите на значок ![](../../_assets/tracker/small-x.png);
    - чтобы удалить все уведомления для роли, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-subscriptions-roles.reset }}**.

    {% note info %}

    Для наиболее важных событий (например, изменен исполнитель или дедлайн) уведомления отключить нельзя.

    {% endnote %}


## Добавить роли для уведомлений {#sec_add_role}

При необходимости вы можете выбрать дополнительные роли и настроить для них уведомления:

- **{{ ui-key.startrek-backend.roles.role.name.modifier }}** — вы изменяли задачу;
- **{{ ui-key.startrek-backend.roles.role.name.access }}** — вы перечислены в поле **{{ ui-key.startrek-backend.fields.issue.access }}** задачи;
- **{{ ui-key.startrek-backend.roles.role.name.queue-lead }}** — вы владелец очереди, в которую входит задача;
- **{{ ui-key.startrek-backend.roles.role.name.team-member }}** — вы участник команды очереди, в которую входит задача;
- **Ответственный за компонент** — вы ответственный за компонент, к которому относится задача;
- **{{ ui-key.startrek-backend.roles.role.name.favorite-follower }}** — вы добавили задачу в избранное.

В списке могут быть доступны и другие роли, которые настроены в вашей организации.

Чтобы добавить роли и настроить для них уведомления:


1. На панели слева нажмите ![](../../_assets/tracker/svg/settings.svg) **{{ ui-key.yacloud.component.navigation-menu.label_notifications }}**. Затем выберите ![](../../_assets/tracker/svg/interface.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.appearance-title }}** и нажмите **{{ ui-key.startrek.blocks-desktop_b-head.manage-subscriptions }}**. Вы также можете перейти по ссылке [{{ link-sub-roles }}]({{ link-sub-roles }}).

1. В нижней части страницы нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-subscriptions-roles.add-role }}** и выберите роль. Чтобы удалить роль, нажмите на значок ![](../../_assets/tracker/remove-task-type.png) возле названия роли.

1. Для роли [настройте список событий](notification-settings.md#section_iqn_y55_xgb), уведомления о которых вы хотите получать.