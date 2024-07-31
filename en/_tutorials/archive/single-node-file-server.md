# Single-node file server


In this tutorial, you will create a single-node [NFS](https://docs.microsoft.com/en-us/windows-server/storage/nfs/nfs-overview) file server using the [Samba](https://www.samba.org/) software suite and the [{{ vpc-full-name }}](../../vpc/) network infrastructure. The server will be hosted on a VM running [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os). You will be able to connect to the server from Linux, macOS, and Windows computers.

You can create an infrastructure for a single-node file server using one of these tools:
* [Management console](../../tutorials/archive/single-node-file-server/console.md): Create your infrastructure one step at a time from the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/archive/single-node-file-server/terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download a {{ TF }} configuration example and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).
