# Notifications about your subscriptions

For subscriptions that inform you about changes to queues, components, or versions, you can select the roles and events you want to be notified about.
To do this:


1. In the panel on the left, click ![](../../_assets/tracker/svg/settings.svg) **{{ ui-key.yacloud.settings.label_settings }}**. Then select ![](../../_assets/tracker/svg/interface.svg)&nbsp;**Interface** and click **Notification settings**. You can also follow the link [{{link-tracker}}subscriptions/manage]({{ link-sub-manage }}).

1. Next to the name of the queue, component, or version, select a role for which you want to set up an event list.

   {% note tip %}

   If there are no queues, components, or versions displayed on the **Subscriptions** tab, [subscribe to notifications](subscribe.md#section_xt5_xrv_jz).

   {% endnote %}

1. To add a role, click ![](../../_assets/tracker/button-plus.png).

1. Configure the [list of events](user-notifications.md#section_iqn_y55_xgb) you want to be notified about for the selected role. For example, notifications about the issue status change or new comments added to the issue.

   {% note info %}

   Events can't be deleted for certain roles. It means that [notifications have already been set up](user-notifications.md) for a similar role. You can edit these events in the relevant section on the **{{ ui-key.yacloud.component.navigation-menu.label_notifications }}** tab.

   {% endnote %}

1. To unsubscribe from a queue, component, or version, click ![](../../_assets/tracker/small-x.png) before the list of roles.