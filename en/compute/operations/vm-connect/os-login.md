---
title: How to connect to a VM via {{ oslogin }}
description: Follow this guide to connect to a VM via {{ oslogin }}.
---

# Connecting to a virtual machine via {{ oslogin }}

[{{ oslogin }}](../../../organization/concepts/os-login.md) is used to provide users and [service accounts](../../../iam/concepts/users/service-accounts.md) with SSH access to VMs using {{ iam-short-name }}.

## Getting started {#before-you-begin}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

[Create](./os-login-create-vm.md) a new virtual machine with {{ oslogin }} support or [set up](./enable-os-login.md) access via {{ oslogin }} for an existing VM as needed.

{% note info %}

Required roles:

{% include [os-login-roles-needed-for-vm-access](../../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

{% endnote %}

## Connecting using a standard SSH client {#connect-with-ssh-client}

You can connect to a VM with {{ oslogin }} access enabled using a standard SSH client either with an SSH key [saved](../../../organization/operations/add-ssh.md) in the {{ oslogin }} profile of a user or service account or a short-lived exported SSH certificate of a user or service account.

{% list tabs group=os_login_type %}

- Connecting with an SSH key {#ssh-key}

  {% include [oslogin-ssh-connect-with-ssh-key](../../../_includes/compute/oslogin-ssh-connect-with-ssh-key.md) %}

- Connecting with an SSH certificate {#ssh-cert}

  {% include [oslogin-connect-with-exported-cert](../../../_includes/compute/oslogin-connect-with-exported-cert.md) %}

  {% include [os-login-certificate-short-lived](../../../_includes/compute/os-login-certificate-short-lived.md) %}

{% endlist %}

You will connect to the specified VM. If this is your first time connecting to this VM, a new user profile will be created in the VM's operating system.

## Connecting using the YC CLI {#connect-with-yc-cli}

You can connect to a VM with {{ oslogin }} access enabled using the [YC CLI](../../../cli/quickstart.md) either with an SSH key [saved](../../../organization/operations/add-ssh.md) in the {{ oslogin }} profile of a user or service account or an SSH certificate of a user or service account.

{% list tabs group=os_login_type %}

- Connecting with an SSH key {#ssh-key}

  {% include [oslogin-connect-with-key](../../../_includes/compute/oslogin-connect-with-key.md) %}

- Connecting with an SSH certificate {#ssh-cert}

  {% include [oslogin-connect-with-cli](../../../_includes/compute/oslogin-connect-with-cli.md) %}

{% endlist %}

You will connect to the specified VM. If this is your first time connecting to this VM, a new user profile will be created in the VM's operating system.

#### See also {#see-also}

* [{#T}](../../../organization/operations/os-login-access.md)
* [{#T}](../../../organization/operations/add-ssh.md)
* [{#T}](./os-login-export-certificate.md)
* [Connecting to a {{ k8s }} node via {{ oslogin }}](../../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an {{ oslogin }} profile for VM management via Ansible](../../../tutorials/security/sa-oslogin-ansible.md)
