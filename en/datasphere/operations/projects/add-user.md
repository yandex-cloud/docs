# Add a user to a project

{% include [select-user](../../../_includes/datasphere/organization-users.md) %}

{% list tabs %}

- Management console

   1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}

   1. Click the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab.

   1. {% include [select-user](../../../_includes/datasphere/select-from-list.md) %}

      If the required user is not on the list, click **{{ ui-key.yc-ui-datasphere.common.copy-link }}** and send them the copied link in any convenient way.

      Once the user accepts the invitation and follows the link, they become a member of the project.

{% endlist %}