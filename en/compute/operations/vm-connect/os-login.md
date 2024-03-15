---
title: "How to connect to a VM via OS Login"
description: "Follow this guide to connect to a VM via OS Login."
---

# Connecting to a VM via OS Login

[OS Login](../../../organization/concepts/os-login.md) is used to provide users with SSH access to VMs through {{ iam-short-name }}. To grant access to a VM that supports OS Login at the OS level, [assign](../../../iam/operations/roles/grant.md) a user the `compute.osLogin` or `compute.osAdminLogin` role.

Please note that you cannot use an [SSH key pair](./ssh.md#creating-ssh-keys) to connect to VMs with OS Login access enabled.

## Getting started {#before-you-begin}

1. Enable [access via OS Login](../../../organization/operations/os-login-access.md) at the organization level.
1. If necessary, [create](./os-login-create-vm.md) a new VM with OS Login support or [set up](./enable-os-login.md) access via OS Login for an existing VM.

## Connecting to a VM via OS Login using the CLI {#connect-via-cli}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. View a description of the CLI command to connect to a VM:

   ```bash
   yc compute ssh --help
   ```

1. Get a list of all VMs in the default folder:

   ```bash
   yc compute instance list
   ```

   Result:

   ```text
   +----------------------+-----------------+---------------+---------+----------------------+
   |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
   +----------------------+-----------------+---------------+---------+----------------------+
   | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
   | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
   +----------------------+-----------------+---------------+---------+----------------------+
   ```

1. Connect to the VM by specifying its name. The connect command depends on the VM's Linux version:

   * **Debian, Ubuntu 20.04+**

      ```bash
      yc compute ssh \
          --name <VM_name>
      ```

      When using OS Login to connect to the VM, you can specify the VM ID rather than its name:

      ```bash
      yc compute ssh \
          --id <VM_ID>
      ```

   * **CentOS 7, Ubuntu 18.04**

      ```bash
      yc compute ssh \
          --name <VM_name> \
          -o "PubkeyAcceptedKeyTypes=+ssh-rsa-cert-v01@openssh.com"
      ```

      When using OS Login to connect to the VM, you can specify the VM ID rather than its name:

      ```bash
      yc compute ssh \
          --id <VM_ID> \
          -o "PubkeyAcceptedKeyTypes=+ssh-rsa-cert-v01@openssh.com"
      ```

## Connecting to a VM over SSH using an OS Login certificate {#connect-via-exported-certificate}

{% include [oslogin-connect-with-exported-cert](../../../_includes/compute/oslogin-connect-with-exported-cert.md) %}

{% note info %}

The certificate is valid for one hour. After this time has elapsed, you will need to [export](./os-login-export-certificate.md) a new certificate to connect to the VM.

{% endnote %}
