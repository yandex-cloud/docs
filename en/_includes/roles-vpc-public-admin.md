### vpc.publicAdmin {#vpc-public-admin}

The `{{ roles-vpc-public-admin }}` role lets you manage external connectivity:

- Create and delete [static public IP addresses](../vpc/concepts/address.md).
- Enable and disable the <q>NAT to the internet</q> function.
It also includes all permissions granted by the `{{ roles-vpc-viewer }}` role.

The `{{ roles-vpc-public-admin }}` role is also required to create resources with public IP addresses, such as VMs or managed database clusters.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}

Important: if a network and subnet are in different folders, the `{{ roles-vpc-public-admin }}` role is checked for the folder where the _network_ is located.

