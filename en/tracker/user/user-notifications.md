# Notifications about your issues

For each role in {{ tracker-name }}, you can configure a list of events you want to be notified about. For example, you can get notifications about the issue status change or new comments added to the issue.

## Configuring event lists {#section_iqn_y55_xgb}


1. In the panel on the left, click ![](../../_assets/tracker/svg/settings.svg) **Settings**. Then select ![](../../_assets/tracker/svg/interface.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.appearance-title }}** and click **Notification settings**. You can also follow the link [{{ link-sub-roles }}]({{ link-sub-roles }}).

1. Select a role and configure the list of events you want to be notified about via email or in [update reports](notification-digest.md):
   - To add an event, click ![](../../_assets/tracker/button-plus.png).
   - To delete an event, click ![](../../_assets/tracker/small-x.png).
   - To delete all notifications for the current role, click **Delete notifications**.

   {% note info %}

   You cannot disable notifications for the most important events (for example, when the assignee or deadline was changed).

   {% endnote %}


## Adding notification roles {#sec_add_role}

If needed, you can select additional roles or set up notifications for them:

- **{{ ui-key.startrek-backend.roles.role.name.modifier }}**: You made changes to the issue.
- **{{ ui-key.startrek-backend.roles.role.name.access }}**: You are listed in the issue's **{{ ui-key.startrek-backend.fields.issue.access }}** field.
- **{{ ui-key.startrek-backend.roles.role.name.queue-lead }}**: You are the owner of the queue the issue is in.
- **{{ ui-key.startrek-backend.roles.role.name.team-member }}**: You are on the team of the queue the issue is in.
- **Component Owner**: You are responsible for the component that the issue is related to.
- **{{ ui-key.startrek-backend.roles.role.name.favorite-follower }}**: You added the issue to your favorites.

Other roles that have been set up in your organization can also be available in the list.

To add roles and set up notifications for them:


1. In the panel on the left, click ![](../../_assets/tracker/svg/settings.svg) **{{ ui-key.yacloud.component.navigation-menu.label_notifications }}**. Then select ![](../../_assets/tracker/svg/interface.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.appearance-title }}** and click **Notification settings**. You can also follow the link [{{ link-sub-roles }}]({{ link-sub-roles }}).

1. Click **Add role** at the bottom of the page and select a role. To delete a role, click ![](../../_assets/tracker/remove-task-type.png) next to the role name.

1. [Configure the list of events](notification-settings.md#section_iqn_y55_xgb) you want to be notified about for the role.