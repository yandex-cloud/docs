{% note info %}

To create, modify, and edit a [VM](../../compute/concepts/vm.md), you need the `compute.editor` _minimum_ [role](../../compute/security/index.md#compute-editor) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). To create a VM with a licensed image, you will additionally need the `license-manager.viewer` [role](../../marketplace/security/index.md#license-manager-viewer).

To create a VM with a [public IP address](../../vpc/concepts/address.md#public-addresses), you will additionally need the `vpc.publicAdmin` [role](../../vpc/security/index.md#vpc-public-admin).

{% endnote %}