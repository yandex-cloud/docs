# {{ baremetal-full-name }} overview

{{ baremetal-full-name }} provides the opportunity to [lease](../operations/servers/server-lease.md) a complete physical server by ordering one of the off-the-shelf configurations.

{{ baremetal-full-name }} allows you to remotely install an operating system on a server using ready-made images from {{ marketplace-short-name }} or by [uploading](../operations/image-upload.md) your own image to {{ objstorage-full-name }} and using it for installation. You can access the server using a [KVM console](../operations/servers/server-kvm.md) or over SSH.

All servers are connected to the [public](./network.md#public-network) internet as well as to a [private network](./network.md#private-network). You can reserve [dedicated public subnets](./network.md#public-subnet) in a public network. In a private network, you can create [private subnets](./network.md#private-subnet) and [VRF segments](./network.md#vrf-segment) and use them to group servers by specific task types.

## Servers and networks {#concepts}

* [{#T}](./servers.md)
* [{#T}](./server-configurations.md)
* [{#T}](./smart-disk-analysis.md)
* [{#T}](./network.md)
* [{#T}](./dhcp.md)
* [{#T}](./network-restrictions.md)