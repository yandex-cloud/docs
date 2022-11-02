You can assign a role for a group as a resource. You can grant roles to users and groups from your organization.

For example, allow a user to view group information and manage its members.

{% list tabs %}

- Cloud Organization

   1. [Log in]({{ link-passport-login }}) to the organization's administrator account.

   1. Go to [{{org-full-name}}]({{ link-org-main }}).

   1. In the left panel, select **Groups** ![icon-services](../../_assets/organization/icon-groups.svg) and click the line with the group name.

   1. Go to the **Group access bindings** tab.

   1. Click **Assign roles**.

   1. Click **Select user**.

   1. Select the appropriate user or group from the list or perform a search.

   1. Click **Add role** and choose `organization-manager.groups.memberAdmin`.

   1. Click **Save**.

   The user appears in the list of group access bindings.

{% endlist %}
