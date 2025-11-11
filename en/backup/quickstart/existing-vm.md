---
title: How to get started with {{ backup-full-name }} on an existing VM
description: Follow this guide to connect to {{ backup-name }} and get started with it on your existing VMs.
---

# How to get started with {{ backup-full-name }} on an existing VM


{% include [quickstart-billing-paragraph](../../_includes/backup/quickstart-billing-paragraph.md) %}

Make sure you have a {{ compute-full-name }} [VM instance](../../compute/concepts/vm.md). In this tutorial, you will connect a [Linux](https://en.wikipedia.org/wiki/Linux) VM instance to {{ backup-name }}. If you have no suitable VM instance, follow [{#T}](./new-vm.md).

{% include [quickstart-paid-resources](../../_includes/backup/quickstart-paid-resources.md) %}

To get started with {{ backup-name }}:

1. [Set up the infrastructure](#deploy-infrastructure).
1. [Activate {{ backup-name }}](#activate-provider).
1. [Install the {{ backup-name }} agent](#connect-vm).
1. [Link your VM to a backup policy](#add-policy).

If you no longer need the resources you created, [delete them](#clear-out).

## Set up the infrastructure {#deploy-infrastructure}

1. In the [cloud network](../../vpc/concepts/network.md#network) hosting the VM you want to connect to {{ backup-name }}, [create](../../vpc/operations/security-group-create.md) a security group with the following outgoing traffic [rules](../../vpc/concepts/security-groups.md#security-groups-rules):

    {% include [outgoing-rules](../../_includes/backup/outgoing-rules.md) %}

1. Assign the new [security group](../../vpc/concepts/security-groups.md) to the VM you are connecting to {{ backup-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      {% include [attach-sg-to-vm-console](../../_includes/backup/operations/attach-sg-to-vm-console.md) %}

    {% endlist %}

1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `backup.editor` [role](../security/index.md#backup-editor) to it. 
1. Link the new [service account](../../iam/concepts/users/service-accounts.md) to the VM you are connecting to {{ backup-name }}:

    {% include [connect-sa-to-vm-intro](../../_includes/connect-sa-to-vm-intro.md) %}

    {% list tabs group=instructions %}

    - Management console {#console}

      {% include [connect-sa-to-vm-console](../../_includes/backup/operations/connect-sa-to-vm-console.md) %}

    {% endlist %}

## Activate {{ backup-name }} {#activate-provider}

{% include [quickstart-activate-provider](../../_includes/backup/quickstart-activate-provider.md) %}

## Install the {{ backup-name }} agent {#connect-vm}

{% include [install-agent-linux](../../_includes/backup/operations/install-agent-linux.md) %}

## Link your VM to a backup policy {#add-policy}

{% include [quickstart-attach-to-policy-after-agent-setup](../../_includes/backup/quickstart-attach-to-policy-after-agent-setup.md) %}

1. {% include [quickstart-check-vm-agent-status](../../_includes/backup/quickstart-check-vm-agent-status.md) %}
1. {% include [quickstart-attach-vm-to-policy](../../_includes/backup/quickstart-attach-vm-to-policy.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../operations/backup-vm/delete.md) VM backups, if any.
1. [Delete](../operations/delete-vm.md) the VM from {{ backup-name }}.

## What's next {#what-is-next}

* [Learn about the service's features](../concepts/index.md)
* [See other guides on how to use the service](../operations/index.md)

#### See also {#see-also}

{% include [see-also-snapshot](../../_includes/backup/see-also-snapshot.md) %}

* [{#T}](./index.md)