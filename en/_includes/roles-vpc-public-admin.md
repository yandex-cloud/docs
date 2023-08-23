#### {{ roles-vpc-public-admin }} {#vpc-public-admin}

The `{{ roles-vpc-public-admin }}` role enables you to create and delete [static public IP addresses](../vpc/concepts/address.md). It also includes all permissions granted by the `{{ roles-vpc-viewer }}` role.

The `{{ roles-vpc-public-admin }}` role is also required to create resources with public IP addresses, such as VMs or managed database clusters.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}

Important: if a network and subnet are in different folders, the `{{ roles-vpc-public-admin }}` role is checked for the folder where the _network_ is located.
