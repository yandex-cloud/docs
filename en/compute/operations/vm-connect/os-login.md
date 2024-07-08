---
title: "How to connect to a VM via OS Login"
description: "Follow this guide to connect to a VM via OS Login."
---

# Connecting to a virtual machine via OS Login

[OS Login](../../../organization/concepts/os-login.md) is used to provide users with SSH access to VMs through {{ iam-short-name }}. To grant access to a VM that supports OS Login at the OS level, [assign](../../../iam/operations/roles/grant.md) a user the `compute.osLogin` or `compute.osAdminLogin` role.

## Getting started {#before-you-begin}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

[Create](./os-login-create-vm.md) a new virtual machine with OS Login support or [set up](./enable-os-login.md) access via OS Login for an existing VM as needed.

## Connecting to a VM via OS Login using an SSH certificate over the YC CLI {#connect-via-cli}

{% include [oslogin-connect-with-cli](../../../_includes/compute/oslogin-connect-with-cli.md) %}

## Connecting to a VM via OS Login using an SSH certificate over a standard SSH client {#connect-via-exported-certificate}

{% include [oslogin-connect-with-exported-cert](../../../_includes/compute/oslogin-connect-with-exported-cert.md) %}

{% note info %}

The certificate is valid for one hour. After this time has elapsed, you will need to [export](./os-login-export-certificate.md) a new certificate to connect to the VM.

{% endnote %}

## Connecting to a VM via OS Login using an SSH key over the YC CLI {#connect-via-key}

{% include [oslogin-connect-with-key](../../../_includes/compute/oslogin-connect-with-key.md) %}

#### See also {#see-also}

* [{#T}](../../../organization/operations/os-login-access.md)
* [{#T}](../../../organization/operations/add-ssh.md)
* [{#T}](./os-login-export-certificate.md)
* [Connecting to a {{ k8s }} node via OS Login](../../../managed-kubernetes/operations/node-connect-oslogin.md)