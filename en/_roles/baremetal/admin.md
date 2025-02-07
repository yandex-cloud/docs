The `baremetal.admin` role enables managing BareMetal servers, private subnets, virtual routing and forwarding (VRF) segments, and OS server images.

Users with this role can:
* View info on BareMetal [servers](../../baremetal/concepts/servers.md) and their [configuration](../../baremetal/concepts/server-configurations.md).
* Start and stop renting BareMetal servers and change their settings.
* View info on [private subnets](../../baremetal/concepts/network.md#private-subnet), as well as create, modify, and delete them.
* View info on [virtual routing and forwarding (VRF)](../../baremetal/concepts/network.md#vrf-segment) segments, as well as create, modify, and delete them.
* View info on the uploaded OS images for BareMetal servers, as well as upload, modify, and delete such images.
* Re-install OS’s for BareMetal servers.
* Use the [KVM console](../../baremetal/operations/servers/server-kvm.md).
* Use [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) to power the servers on, shut them down, and restart them.
* View details on Yandex BareMetal [quotas](../../baremetal/concepts/limits.md#baremetal-quotas).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `baremetal.editor` permissions.