# Creating a service agent

With a [service agent](../../../iam/concepts/service-control.md#service-agent), you will be able to work with other services, e.g., refresh your authorization tokens for {{ ml-platform-name }} notebooks.

A service agent is a special service account under which {{ ml-platform-name }} projects will perform actions in other {{ yandex-cloud }} services. Once enabled in a community, a service agent will be available for all the projects in that community.

You can also [manage a service agent](../projects/jobs-with-ssa.md) from [{{ ds-jobs }}](../../concepts/jobs/index.md).

{% note info %}

To enable a service agent in a {{ ml-platform-name }} community, you need the `{{ roles-datasphere-communities-editor }}` [role](../../security/index.md) or higher.

You need the [admin](../../../resource-manager/security/index.md#resource-manager-admin) or [owner](../../../resource-manager/security/index.md#resource-manager-clouds-owner) role for the cloud to manage service access to resources.

{% endnote %}

{% include [cli-install](../../../_includes/cli-install.md) %}

1. To allow a service agent to operate in {{ ml-platform-name }}, ask your cloud admin or owner to run the following command in the {{ yandex-cloud }} CLI:

   ```bash
   yc iam service-control enable datasphere --cloud-id <cloud_ID>
   ```

   Where `--cloud-id` is the [ID of the cloud](../../../resource-manager/operations/cloud/get-id.md) you are going to use in the {{ ml-platform-name }} community.

1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) to it the roles required to use the selected service. For more information about the required roles, see **Access management** for the service in question.

    To send requests to nodes from a notebook, assign the `{{ roles-datasphere-user }}` role to the service account.       

1. {% include [ui-find-community](../../../_includes/datasphere/ui-find-community.md) %}
1. Select the community you want to create a service agent for.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.settings-key-value }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.settings.title }}**, click **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}**.
1. In the window that opens, select the service account and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% note info %}

To manage a community via the API, [add](add-user.md) the service account to the community member list. To send requests to a node from a notebook or access a project via the API, add the service account to the community and [project](../projects/add-user.md) member lists.

{% endnote %}
