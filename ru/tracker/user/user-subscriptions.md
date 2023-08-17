# Уведомления о ваших подписках

Для подписок на изменения очередей, компонентов или версий можно выбрать роли и настроить события, уведомления о которых вы хотите получать.
Для этого:


1. На панели слева нажмите ![](../../_assets/tracker/svg/settings.svg) **{{ ui-key.yacloud.settings.label_settings }}**. Затем выберите ![](../../_assets/tracker/svg/interface.svg)&nbsp;**Интерфейс** и нажмите **{{ ui-key.startrek.blocks-desktop_b-head.manage-subscriptions }}**. Вы также можете перейти по ссылке [{{link-tracker}}subscriptions/manage]({{ link-sub-manage }}).

1. Напротив названия очереди, компонента или версии выберите роль, для которой требуется настроить список событий. 

    {% note tip %}

    Если на вкладке **{{ ui-key.startrek.blocks-desktop_b-subscriptions-header.subscriptions }}** нет очередей, компонентов или версий, [подпишитесь на уведомления](subscribe.md#section_xt5_xrv_jz).

    {% endnote %}

1. Чтобы добавить роль, нажмите кнопку ![](../../_assets/tracker/button-plus.png).

1. Для выбранной роли [настройте список событий](user-notifications.md#section_iqn_y55_xgb), уведомления о которых вы хотите получать. Например, уведомления об изменении статуса задачи или добавлении к задаче комментария.
   
   {% note info %}
   
   Для некоторых ролей события нельзя удалить. Это значит, что для аналогичной роли уже [настроены уведомления](user-notifications.md). Вы можете отредактировать такие события в соответствующем разделе на вкладке **{{ ui-key.yacloud.component.navigation-menu.label_notifications }}**.

   {% endnote %}

1. Чтобы отписаться от очереди, компонента или версии, нажмите значок ![](../../_assets/tracker/small-x.png) перед списком ролей.