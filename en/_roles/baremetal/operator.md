The `baremetal.operator` role enables working on the BareMetal servers and viewing info on the Yandex BareMetal resources.

Users with this role can:
* View info on BareMetal [servers](../../baremetal/concepts/servers.md) and their [configuration](../../baremetal/concepts/server-configurations.md).
* Use the [KVM console](../../baremetal/operations/servers/server-kvm.md).
* Use [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) to power the servers on, shut them down, and restart them.
* View info on [private subnets](../../baremetal/concepts/network.md#private-subnet) and [virtual routing and forwarding (VRF) segments](../../baremetal/concepts/network.md#vrf-segment).
* View info on the uploaded OS images for the servers.
* View details on Yandex BareMetal [quotas](../../baremetal/concepts/limits.md#baremetal-quotas).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `baremetal.viewer` permissions.