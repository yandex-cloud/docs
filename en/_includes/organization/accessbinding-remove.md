
To revoke a group role from a user:

{% list tabs %}

- Cloud Organization

   1. [Log in]({{ link-passport-login }}) to the organization administrator account.

   1. Go to [{{org-full-name}}]({{ link-org-main }}).

   1. In the left-hand panel, select **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg) and click the line with the group name.

   1. Go to the **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** tab.

   1. Select a user from the list and click ![image](../../_assets/console-icons/ellipsis.svg) next to the username.

   1. Click **{{ ui-key.yacloud_org.entity.group.action_update-acl }}**.

   1. Click ![image](../../_assets/console-icons/xmark.svg) next to the role to revoke.

   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% note tip %}

To open the list of users allowed to manage the group at the [organization role](../../organization/security/index.md) level (e.g., organization admin or owner), go to the **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** tab and enable the **{{ ui-key.yacloud.common.resource-acl.label_inherited-bindings }}** option.

{% endnote %}
