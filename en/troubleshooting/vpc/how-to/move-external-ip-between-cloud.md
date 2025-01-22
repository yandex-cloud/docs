# Moving an external static IP address to another cloud



## Issue description {#issue-description}

You need to transfer an external IP address to another cloud.

## Solution {#case-resolution}

Before transferring an external IP address to another cloud, perform these actions:

1. [Make the required IP address static](../../../vpc/operations/set-static-ip.md).
2. If the IP address is used on a VM instance, it should be [detached](../../../compute/operations/vm-control/vm-detach-public-ip.md) from the VM.
3. Check the quota for external IP addresses and static IP addresses in the cloud the address will be transferred to.


To transfer the IP address directly, create two [support requests](https://console.cloud.yandex.ru/support?section=contact): one from each cloud involved in the transfer.

In each of the requests, please specify:

1. External IP address that you want to transfer to another cloud (or the ID of this IP address).
2. Confirmation of the transfer operation from owners of both clouds.
3. Link to the support request created in the other cloud, or the ID of the request initiated from the other cloud. They will be available after creating the requests. You can provide them in a new response after creating the requests.

This data will help us transfer your IP address to another cloud as quickly as possible.
