---
title: How to export an SSH certificate
description: Follow this guide to locally export an SSH certificate to use it for {{ oslogin }} access to properly configured VMs.
---

# Exporting an SSH certificate

You can use an SSH certificate of an [organization user](../../../organization/concepts/membership.md) or service account to enable a user or (via a [service account](../../../iam/concepts/users/service-accounts.md)) a third-party tool, such as [Terraform](https://www.terraform.io/) or [Ansible](https://www.ansible.com/), to use SSH to connect to [VMs](../../concepts/vm.md#project) or [separate nodes in a {{ k8s }} node group](../../../managed-kubernetes/concepts/index.md#node-group) with {{ oslogin }} access enabled. To do this, locally export an SSH certificate and use it to access the VM or {{ k8s }} node with a standard SSH client. The exported certificate is valid for one hour.

{% include [oslogin-export-certificate](../../../_includes/compute/oslogin-export-certificate.md) %}

You can use the exported SSH certificate to [connect](./os-login.md#connect-with-ssh-client) to a VM or {{ k8s }} node with {{ oslogin }} access [enabled](../vm-control/vm-update.md#enable-oslogin-access).

#### See also {#see-also}

* [{#T}](../../../organization/operations/os-login-access.md)
* [{#T}](../../../organization/operations/add-ssh.md)
* [{#T}](./os-login.md)
* [Connecting to a {{ k8s }} node via {{ oslogin }}](../../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an {{ oslogin }} profile for VM management via Ansible](../../../tutorials/security/sa-oslogin-ansible.md)