---
title: How to export an SSH certificate
description: Follow this guide to locally export an SSH certificate to use it for {{ oslogin }} access to properly configured VMs.
---

# Exporting an SSH certificate

You can use an SSH certificate of an [organization user](../../../organization/concepts/membership.md) or service account to enable a user or a third-party tool, such as [Terraform](https://www.terraform.io/) or [Ansible](https://www.ansible.com/), to use SSH to connect to a VM with {{ oslogin }} access enabled. To do this, locally export an SSH certificate and use it to access the VM via a standard SSH client. The exported certificate is valid for one hour.

{% include [oslogin-export-certificate](../../../_includes/compute/oslogin-export-certificate.md) %}

You can use the exported SSH certificate to [connect](./os-login.md#connect-with-ssh-client) to a VM with {{ oslogin }} access [enabled](../vm-control/vm-update.md#enable-oslogin-access).

#### See also {#see-also}

* [{#T}](../../../organization/operations/os-login-access.md)
* [{#T}](../../../organization/operations/add-ssh.md)
* [{#T}](./os-login.md)
* [Connecting to a {{ k8s }} node via {{ oslogin }}](../../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an {{ oslogin }} profile for VM management via Ansible](../../../tutorials/security/sa-oslogin-ansible.md)