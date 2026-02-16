# Migrating a workflow to a new {{ ml-platform-name }} version

The update to the {{ ml-platform-name }} interface also brought changes to its [resource model](../concepts/resource-model.md). To keep working with your projects created in the old {{ ml-platform-name }} version, migrate them to the new version [automatically](#auto).

## Migrating projects and data automatically {#auto}

You can automatically migrate your projects, interpreter state, project resources, and all data from the old {{ ml-platform-name }} version to the new one using the project migration tool. To do this, select ![transfer](../../_assets/console-icons/folder-arrow-right.svg) **{{ ui-key.yc-ui-datasphere.transferring.title }}** in the left-hand menu and follow the prompts in the interface.

{% note warning %}

Once the projects are transferred to the new {{ ml-platform-name }} version, those in the old version will be deleted.

{% endnote %}

{% note info %}

Automatic migration of nodes is not supported. If the projects you want to migrate contain nodes, delete them, migrate the projects, and create the nodes again, or [contact]({{ link-console-support }}) support.

{% endnote %}

1. Select the cloud and projects you want to migrate. You can only select clouds which contain {{ ml-platform-name }} projects and where you have the `{{ roles-datasphere-admin }}` or `{{ roles-editor }}` [role](../security/index.md) for the project folder.
1. Select the [community](../concepts/community.md) to transfer your projects to. Make sure this community has an active billing account. To migrate your projects to the selected community, you need the `{{ roles-datasphere-communities-admin }}` role in this community or the `{{ roles-editor }}` role in the organization.
1. Click **{{ ui-key.yc-ui-datasphere.transferring.transfer-selected-projects }}**.

Once transferred, the projects will be available in the community you selected.
