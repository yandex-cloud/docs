# How to transfer an external static IP address to a different cloud



## Issue description {#issue-description}

You need to transfer an external IP address to another cloud.

## Solution {#case-resolution}

Before transferring an external IP address to another cloud, do the following:

1. [Make the required IP address static](../../../vpc/operations/set-static-ip.md).
1. If the IP address is used on a VM instance, you should [disassociate](../../../compute/operations/vm-control/vm-detach-public-ip.md) it from the VM.
1. Check the quota for external IP addresses and static IP addresses in the cloud the address will be transferred to.

To transfer the IP address directly, create two [support tickets]({{ link-console-support }}): one from a source cloud, and the other, from the target cloud.

In each of the requests, please specify:

1. External IP address that you want to transfer to another cloud, or the ID of this IP address.
1. Confirmation of the IP address transfer from owners of both clouds.
1. Link to the support ticket created in the other cloud, or the ID of the ticket in the other cloud. They will be available after creating the tickets. You can provide them in a new response after creating the tickets.

This data will help us transfer your IP address to another cloud as quickly as possible.