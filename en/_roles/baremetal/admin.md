
The `baremetal.admin` role enables managing {{ baremetal-name }} servers, private subnets, virtual routing and forwarding (VRF) segments, and OS server images, as well as managing server backups using {{ backup-name }}.

Users with this role can:
* View info on {{ baremetal-name }} [servers](../../baremetal/concepts/servers.md) and their [configuration](../../baremetal/concepts/server-configurations.md).
* Start and stop renting {{ baremetal-name }} servers and change their settings.
* View info on [private subnets](../../baremetal/concepts/private-network.md#private-subnet), as well as create, modify, and delete them.
* View info on [virtual routing and forwarding (VRF)](../../baremetal/concepts/private-network.md#vrf-segment) segments, as well as create, modify, and delete them.
* View info on the uploaded OS images for {{ baremetal-name }} servers, as well as upload, modify, and delete such images.
* Re-install OS’s for {{ baremetal-name }} servers.
* Use the [KVM console](../../baremetal/operations/servers/server-kvm.md).
* Use [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) to power the servers on, shut them down, and restart them.
* View info on connected backup [providers](../../backup/concepts/index.md#providers), as well as connect providers available in {{ backup-name }}.
* View info on resources [connected](../../backup/concepts/vm-connection/index.md) to {{ backup-name }}, as well as connect and disconnect resources to and from it.
* View info on [backup policies](../../backup/concepts/policy.md) as well as on resources linked to such policies.
* Link backup policies to target resources and unlink them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for backup policies.
* View details on {{ baremetal-full-name }} [quotas](../../baremetal/concepts/limits.md#baremetal-quotas).
* View info on {{ backup-name }} [quotas](../../backup/concepts/limits.md#backup-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `baremetal.editor` permissions.