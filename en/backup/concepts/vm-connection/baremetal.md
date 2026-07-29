---
title: Connecting {{ baremetal-full-name }} servers to {{ backup-full-name }}
description: In this tutorial, you will learn how to connect {{ baremetal-full-name }} VMs to {{ backup-full-name }}.
---

# Connecting {{ baremetal-full-name }} servers to {{ backup-name }}


To back up your [{{ baremetal-name }} servers](../../../baremetal/concepts/servers.md) in {{ backup-name }}, you need them connected to the service and properly set up.

For more on connecting {{ baremetal-name }} servers to {{ backup-name }}, see [{#T}](../../operations/index.md#connect-baremetal).

For the {{ backup-name }} connection to work correctly, link to the server a [service account](#sa) with the [`baremetal.editor`](../../../baremetal/security/index.md#baremetal-editor) and [`backup.user`](../../security/index.md#backup-user) roles or higher and configure [network access](#vm-network-access).

After you connect it to {{ backup-name }}, [link](../../operations/policy-vm/attach-and-detach-vm.md#attach-vm) the {{ baremetal-name }} server to a [backup policy](../policy.md).

{% note info %}

At the time of creating a backup, the {{ baremetal-name }} server must be running.

{% endnote %}

You can also link a policy to a {{ baremetal-name }} server when ordering the latter. A policy is linked asynchronously after you create and initialize a server and after you install and configure the {{ backup-name }} agent. This may take up to 10-15 minutes.

## Supported {{ marketplace-name }} images with automatic installation of the {{ backup-name }} agent {#os}


On {{ baremetal-name }} servers, the {{ backup-name }} agent is available for automatic installation if ordering servers using the following {{ marketplace-name }} images:

* CentOS 7
* Debian 11
* Ubuntu 18.04 LTS
* Ubuntu 20.04 LTS
* Ubuntu 22.04 LTS
* Ubuntu 24.04 LTS

{% note info %}

The OS must be installed from a public image (a {{ marketplace-full-name }} product).

{% endnote %}

### Unaided installation on a supported operating system {#self-install}

You can install the {{ backup-name }} agent manually on a {{ baremetal-name }} server running one of these operating systems:

{% include [baremetal-os-list](../../../_includes/backup/baremetal-os-list.md) %}

To install the agent on a server, follow [this guide on connecting a {{ baremetal-name }} server to {{ backup-name }}](../../operations/backup-baremetal/backup-baremetal.md).

If you have issues installing the {{ backup-name }} agent, [contact]({{ link-console-support }}) support.

### Updating the operating system kernel {#os-kernel-update}

{% include [update-kernel-headers-description](../../../_includes/backup/operations/update-kernel-headers-description.md) %}

To upgrade the Linux kernel header version, follow [this guide on restoring the {{ backup-name }} agent on a {{ baremetal-name }} server](../../operations/backup-baremetal/restore-agent.md).

## Service account {#sa}

A [service account](../../../iam/concepts/users/service-accounts.md) is a special account the {{ backup-name }} agent uses to get registered with the Cyberprotect [provider](../index.md#providers).

When renting a {{ baremetal-name }} server you want to configure backups for in {{ backup-name }}, you need to link to it a service account with the [`baremetal.editor`](../../../baremetal/security/index.md#baremetal-editor) and [`backup.user`](../../security/index.md#backup-user) roles or higher.

You can [assign the role](../../../iam/operations/sa/assign-role-for-sa.md) to an existing service account or [create](../../../iam/operations/sa/create.md) a new service account with required roles.

## Network access permissions {#vm-network-access}

For the {{ backup-name }} agent to be able to exchange data with the backup provider servers, make sure the {{ baremetal-name }} server has network access to the IP addresses of the {{ backup-name }} resources as per the table below:

{% list tabs group=traffic %}

- Outgoing traffic {#outgoing}

  {% include [outgoing-rules](../../../_includes/backup/outgoing-rules.md) %}

  {% note tip %}

  When installing the {{ backup-name }} agent on your {{ baremetal-name }} server, you may need to install some missing software components from the internet. To have this done, allow all incoming network traffic for the network interface connected to the [public network](../../../baremetal/concepts/public-network.md) for as long as the installation continues. Once the {{ backup-name }} agent is installed, you can restrict network traffic once again in line with the network access permissions mentioned above.

  {% endnote %}

{% endlist %}

To provide network access:
{#provide-access}

* When [renting a server](../../../baremetal/operations/servers/server-lease.md), select `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}` or `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}` in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field to assign a public IP address to the server.
* Make sure the sever network settings do not block outgoing traffic to the resources specified above.

## Connection statuses {#statuses}

You can view the server connection to {{ backup-name }} status info in the [management console]({{ link-console-main }}) on the server list page in **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**. The following statuses are available:

* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-ok }}`: {{ backup-name }} is connected to the server, backups are being created as per the specified policies, the {{ backup-name }} agent is online.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}`: {{ backup-name }} is connected, but there are no associated policies; no backups are being created.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-failed }}`: Agent is offline, or agent registration failed.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-not-connected }}`: {{ backup-name }} is not connected to the server.

#### See also {#see-also}

* [{#T}](../../operations/index.md#connect-baremetal)
* [{#T}](./compute.md)
* [{#T}](./external-resources.md)