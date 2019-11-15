### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#owner}

The`{{ roles-cloud-owner }}` is assigned for the cloud and makes the user the [owner of the cloud](../resource-manager/concepts/resources-hierarchy.md#owner). The owner can perform any operation with the cloud and its resources.

Only the cloud owner can assign users the `{{ roles-cloud-owner }}` role.

A cloud must have at least one owner. The sole owner of a cloud may not give up this role.

