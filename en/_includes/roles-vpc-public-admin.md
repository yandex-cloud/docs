### vpc.publicAdmin {#vpc-public-admin}

The `{{ roles-vpc-public-admin }}` role lets you manage external connectivity:

- Create [static public IP addresses](../vpc/concepts/address.md).
- Enable and disable the **NAT to the internet** function.

The `{{ roles-vpc-public-admin }}` role is also required to create resources with public IP addresses, such as VMs or managed database clusters.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}