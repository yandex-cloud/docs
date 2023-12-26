# How to migrate to the new {{ ml-platform-name }} version

Alongside its interface, the {{ ml-platform-name }} [resource model](../concepts/resource-model.md) was updated, too. To continue working on your projects created in the previous {{ ml-platform-name }} version, migrate them to the new version [automatically](#auto).

## Transferring projects and data automatically {#auto}

You can automatically migrate your projects, the interpreter state, the project resources, and all data from the previous {{ ml-platform-name }} version to the new one using the project transfer tool. To do this, select ![transfer](../../_assets/console-icons/folder-arrow-right.svg) **{{ ui-key.yc-ui-datasphere.transferring.title }}** in the left-hand menu and follow the prompts in the interface.

{% note warning %}

Once the projects are transferred to the new {{ ml-platform-name }} version, the projects in the old version will be deleted.

{% endnote %}

{% note info %}

You cannot transfer nodes automatically. If the projects to migrate contain any nodes, delete them on your own, transfer the projects, and create nodes again, or [contact]({{ link-console-support }}) support.

{% endnote %}

1. Choose the cloud and projects you want to transfer. You can only select a cloud that contains {{ ml-platform-name }} projects and where you have the `{{ roles-datasphere-admin }}` or `{{ roles-editor }}` role for the project folder.
1. Select the [community](../concepts/community.md) to transfer your projects to. Make sure the community has an active billing account. To migrate your projects to the selected community, you must have the `{{ roles-datasphere-communities-admin }}` role in this community or the `{{ roles-editor }}` role in an organization.
1. Click **{{ ui-key.yc-ui-datasphere.transferring.transfer-selected-projects }}**.

Once transferred, the projects will be available in the community you selected.
