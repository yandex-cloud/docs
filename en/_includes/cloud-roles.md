#### [!KEYREF roles-cloud-member]

[!INCLUDE [roles-cloud-member](roles-cloud-member.md)]

#### [!KEYREF roles-cloud-owner]

Role `[!KEYREF roles-cloud-owner]` is assigned for the cloud and makes the user the [owner of the cloud](../resource-manager/concepts/resources-hierarchy.md#owner). The owner can perform any operations with the cloud and the resources in it.

Only the cloud owner can assign to or remove from the users the role `[!KEYREF roles-cloud-owner]`.

The cloud must have at least one owner. The only owner of the cloud cannot remove this role from oneself.

