# Subscribing other users to queue updates

You can subscribe {{ tracker-name }} users to notifications about changes to all issues within a certain queue or changes related to specific versions or components.

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

To set up sending of notification about issue status changes in the queue:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg)&nbsp;**{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Click the **{{ ui-key.yacloud.component.navigation-menu.label_notifications }}** tab.

1. Set up sending of notifications:

   **About all issues in the queue**

   1. Click the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_notifications.queue }}** tab.

   1. List the names of the logins of users who need to send notifications.

   1. Select in which cases the users will be notified:

      - **{{ ui-key.startrek.blocks-desktop_trigger-action.title_createissue }}**: Users only get notifications when new issues are created.

      - **{{ ui-key.startrek-backend.profiles.category.everything }}**: Users are notified of any changes to issues.

   **About issues related to a specific version**

   You can set up sending of notifications about the issues whose properties include a certain version.

   1. Click the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_notifications.versions }}** tab.

   1. Select a version.

   1. List the names of the logins of users who need to send notifications.

   1. Select in which cases the users will be notified:

      - **{{ ui-key.startrek.blocks-desktop_trigger-action.title_createissue }}**: Users only get notifications when new issues are created.

      - **{{ ui-key.startrek-backend.profiles.category.everything }}**: Users are notified of any changes to issues.

   **About issues related to a specific component**

   You can set up sending of notifications about the issues whose properties include a certain component:

   1. Click the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_notifications.components }}** tab.

   1. Select the component.

   1. List the names of the logins of users who need to send notifications.

   1. Select in which cases the users will be notified:

      - **{{ ui-key.startrek.blocks-desktop_trigger-action.title_createissue }}**: Users only get notifications when new issues are created.

      - **{{ ui-key.startrek-backend.profiles.category.everything }}**: Users are notified of any changes to issues.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-settings.save }}**.
