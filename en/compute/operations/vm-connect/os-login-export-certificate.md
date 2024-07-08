---
title: "How to export an OS Login certificate"
description: "Follow this guide to locally export an OS Login certificate so it can be used to connect over SSH to VMs with OS Login access configured."
---

# Exporting an OS Login certificate

You can use a certificate to enable a user or a third-party tool, such as [Terraform](https://www.terraform.io/) or [Ansible](https://www.ansible.com/), to use SSH to connect to a VM with OS Login access enabled. To do this, locally export an OS Login certificate and use it to access a VM using a standard SSH client. The exported certificate is valid for one hour.

{% include [oslogin-export-certificate](../../../_includes/compute/oslogin-export-certificate.md) %}

You can use the exported OS Login certificate to [connect](./os-login.md#connect-via-exported-certificate) to a VM with OS Login access [configured](../vm-control/vm-update.md#enable-oslogin-access).

#### See also {#see-also}

* [{#T}](../../../organization/operations/os-login-access.md)
* [{#T}](../../../organization/operations/add-ssh.md)
* [{#T}](./os-login.md)
* [Connecting to a {{ k8s }} node via OS Login](../../../managed-kubernetes/operations/node-connect-oslogin.md)