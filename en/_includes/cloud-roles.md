#### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](roles-cloud-member.md) %}

#### {{ roles-cloud-owner }} {#owner}

The role of `{{ roles-cloud-owner }}` is assigned for the cloud and makes the user the [owner of the cloud](../resource-manager/concepts/resources-hierarchy.md#owner). The owner can perform any operations with the cloud and its resources.

Only the cloud owner can assign to or remove from the users the role `{{ roles-cloud-owner }}`.

A cloud must have at least one owner. The sole owner of a cloud may not give up this role.

