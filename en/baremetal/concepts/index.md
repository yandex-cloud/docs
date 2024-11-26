# {{ baremetal-full-name }} overview

{{ baremetal-full-name }} provides the opportunity to lease a complete physical server by ordering one of the off-the-shelf configurations.

{{ baremetal-full-name }} allows you to remotely install an operating system on a server using ready-made images from {{ marketplace-short-name }} or by [uploading](../operations/image-upload.md) your own image to {{ objstorage-full-name }} and using it for installation. You can access the server using a KVM console or via SSH.

In case of server issues, you can [boot](../operations/servers/rescue-boot.md) it from a special Rescue CD to perform diagnostics or make the required changes to the OS configuration.

All servers are connected to the public internet as well as to a private network. In a private network, you can create private subnets and VRFs and use them to group servers by specific tasks.

## Servers and networks {#concepts}

* [{#T}](./servers.md)
* [{#T}](./server-configurations.md)
* [{#T}](./network.md)
