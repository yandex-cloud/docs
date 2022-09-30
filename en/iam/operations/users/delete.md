# Deleting a user from the cloud

{% note warning %}

Deleting a user from the cloud is an operation that cannot be undone. If you accidentally delete a user, you can [add](create.md) them to the cloud again.

{% endnote %}

These instructions describe how to revoke all cloud roles from a user. If the cloud belongs to an [organization](../../../organization/), [check](../../../organization/manage-users.md) and, if needed, [revoke](../../../organization/edit-account.md) roles in {{ org-full-name }}.

{% list tabs %}

- Management console

   1. Log in to the [management console]({{ link-console-main }}).
   1. [Select the desired cloud](../../../resource-manager/operations/cloud/switch-cloud.md).
   1. Go to [Access bindings]({{ link-console-cloud }}?section=resource-acl).
   1. Select the appropriate user in the list and click ![image](../../../_assets/options.svg) next to the user's name.
   1. Click **Remove bindings**.
   1. Confirm revoking all roles from the user.

{% endlist %}
