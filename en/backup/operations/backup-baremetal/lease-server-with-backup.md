---
title: How to lease a {{ baremetal-full-name }} server with a connection to {{ backup-full-name }}
description: Follow this guide to lease a {{ baremetal-name }} server with a connection to {{ backup-name }}.
---

# Leasing a {{ baremetal-full-name }} server with a connection to {{ backup-name }}

{% note info %}

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

{% endnote %}

You can back up your {{ baremetal-name }} [servers](../../../baremetal/concepts/servers.md) with supported Linux-based operating systems: {#os-support}

{% include [baremetal-os-list](../../../_includes/backup/baremetal-os-list.md) %}


## Getting started {#before-you-begin}

1. [Create](../../../iam/operations/sa/create.md) a service account with the [baremetal.editor](../../../baremetal/security/index.md#baremetal-editor) and [backup.editor](../../security/index.md#backup-editor) roles.
1. [Create](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair.


## Leasing a {#server-rent} server

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to lease a server in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-server }}**.
  1. Select an [availability zone](../../../overview/concepts/geo-scope.md).
  1. Select a [pool](../../../baremetal/concepts/servers.md#server-pools).
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-config }}**:

      1. Select the server configuration.
      1. Configure disk partitioning:

          1. Click **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Keep the default partitioning and click **{{ ui-key.yacloud.common.save }}**.

          {% note info %}

          The disk partitioning parameters are vital to have your server restored from a backup later on. For more information, see [{#T}](../backup-vm/recover.md).

          {% endnote %}

  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select an [operating system supported in {{ backup-name }}](#os-support).
  1. Under **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}**, specify how many servers you want to lease and for what period.
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

      1. In the **{{ ui-key.yacloud.baremetal.field_subnet-id }}** field, click **{{ ui-key.yacloud.common.create }}**.
      1. Optionally, if you need to enable DHCP for automatic IP address assignment, do so in the **{{ ui-key.yacloud.baremetal.title_routing-settings }}** section.
      1. Enter the subnet name and click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
      1. In the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select `{{ ui-key.yacloud.baremetal.label_public-ip-auto }}`.

          For the [{{ backup-name }}](../../concepts/agent.md) agent to exchange data with the [backup provider](../../concepts/index.md#providers) servers, make sure the server has network access to the IP addresses of {{ backup-name }} resources based on the following table: {#ip-access}

          {% include [outgoing traffic](../../../_includes/backup/outgoing-rules.md) %} 

  1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      1. Generate a password for the root user. To do this, click **{{ ui-key.yacloud.baremetal.field_password }}** next to the **{{ ui-key.yacloud.component.password-input.label_button-generate }}** field.

      {% note warning %}

      Once you have ordered your server, you will no longer be able to view the password. Save the password to a secure location right away.

      {% endnote %}

      1. In the **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** field, paste the contents of the public key file you created during the [preparation step](#before-you-begin).

  1. Enable server backup in {{ backup-name }}:

      1. Expand **{{ ui-key.yacloud.baremetal.title_section-backup }}**.
      1. Select a [backup policy](../../concepts/policy.md) or [create](../../operations/policy-vm/create.md) a new one.
      1. Select the [service account](../../../iam/concepts/users/service-accounts.md) with the `baremetal.editor` and `backup.editor` roles that you created during the [preparation step](#before-you-begin).

  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-info }}**, enter the server name.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-server }}**.

{% endlist %}

For more information on leasing a server, see the [{{ baremetal-name }}](../../../baremetal/operations/servers/server-lease.md) documentation.