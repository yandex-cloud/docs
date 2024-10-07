# Subscribing a user to notifications

By default, technical notifications for an organization are sent to users with the `organization-manager.organizations.owner` role.

You can also subscribe other users in your organization to receive technical notifications. To do this:

{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

  1. Go to [{{ org-full-name }}]({{ link-org-main }}).
  
      To subscribe a user to receive technical notifications, you need the `editor` [role](../../iam/roles-reference.md#editor) or higher for the organization.
  1. In the left-hand panel, select ![pencil](../../_assets/console-icons/bell.svg) **{{ ui-key.yacloud_org.pages.notifications }}**.
  1. Click **{{ ui-key.yacloud.common.add }}**. In the window that opens:

      1. Place the cursor in the input field and select the user you want to subscribe to notifications or use the search bar.

          You can subscribe multiple users to notifications at the same time.
      1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Users you have subscribed to notifications will receive technical notifications from the organization. Each subscribed user can configure the types and channels for receiving their notifications. For more information, see [{#T}](../../resource-manager/concepts/notify.md#notification-settings).