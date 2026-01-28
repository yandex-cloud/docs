---
title: How to lease a custom-configured server in {{ baremetal-full-name }}
description: Follow this guide to lease a {{ baremetal-full-name }} server in a custom configuration built as per your requirements.
---

# Leasing a custom-configured server

You can [configure](../../concepts/server-configurations.md#custom) your server yourself. Proceed as follows:

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Lease a server {#server-lease}

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [server-lease-step1](../../../_includes/baremetal/instruction-steps/server-lease-step1.md) %}
  1. {% include [server-lease-step2](../../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. Click **{{ ui-key.yacloud.baremetal.label_create-server }}** and, in the window that opens, select `{{ ui-key.yacloud.baremetal.servers.ServerConfigPage.custom-configs_b5Ab9 }}`. In the window that opens, set up the server configuration:

      1. Under **{{ ui-key.yacloud_components.baremetal.cpuTitle }}**, select the CPU that suits you best.

          Filter by manufacturer, number of cores, and clock frequency as needed.
      1. Under **{{ ui-key.yacloud_components.baremetal.ramLabel }}**, specify the type and amount of RAM available on the server.
      1. Under **{{ ui-key.yacloud_components.baremetal.disks }}**, add to the server a disk group of the form factor you choose:

          1. In the **{{ ui-key.yacloud_components.baremetal.type }}** field, select disk type.
          1. In the **{{ ui-key.yacloud_components.baremetal.size }}** field that appears, select disk size.
          1. In the **{{ ui-key.yacloud_components.baremetal.amount }}** field that appears, select the number of disks in the group.

          There must be at least one group consisting of at least two disks on the server.

          You can add more disk groups of other form factors. Do it by clicking ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.baremetal.addDiskButton }}**.
      1. Under **{{ ui-key.yacloud_components.baremetal.networkLabel }}**, select the server's network card connection speed for [public](../../concepts/network.md#public-network) and [private](../../concepts/network.md#private-network) networks, and whether MC-LAG [aggregation groups](../../concepts/mc-lag.md) must be provided on the server.
      1. Select the [server pool](../../concepts/servers.md#server-pools) the server will be in under **{{ ui-key.yacloud.baremetal.field_hardware-pool-id }}**.
      1. Under **{{ ui-key.yacloud_components.baremetal.withReserve }}**, specify whether [redundant power supply](../../concepts/servers.md#server-power-supply) is required.
      1. Click **{{ ui-key.yacloud.common.continue }}**.
  1. In the window that opens, set the server up as follows:

      1. Under **{{ ui-key.yacloud.baremetal.title_section-server-config }}** and **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}**, make sure the server configuration you have provided so far is adequate.

          If not, click ![arrow-left](../../../_assets/console-icons/arrow-left.svg) under **{{ ui-key.yacloud.baremetal.title_section-server-config }}** to return to configuration setup.
      1. In the **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}** field, select the [lease period](../../../baremetal/concepts/servers.md#server-lease): `1 day` or `1 year`.
      
          {% include [server-lease-step6-period](../../../_includes/baremetal/instruction-steps/server-lease-step6-period.md) %}
      1. {% include [server-lease-step7-bm](../../../_includes/baremetal/instruction-steps/server-lease-step7-bm.md) %}
      1. Under **{{ ui-key.yacloud.baremetal.title_section-disk }}**, configure disk partitioning:

          1. Click **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Specify partition settings. To create a new partition, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.actions_add-partition }}**.

              To configure RAID arrays and disk partitions by yourself, click ![square-plus](../../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.baremetal.action_add-to-raid }}**.
          1. Click **{{ ui-key.yacloud.common.save }}**.
      1. {% include [server-lease-step9-bm](../../../_includes/baremetal/instruction-steps/server-lease-step9-bm.md) %}
      1. {% include [server-lease-step10-bm](../../../_includes/baremetal/instruction-steps/server-lease-step10-bm.md) %}
      1. If you are installing an OS from a {{ marketplace-short-name }} public image, specify server access settings under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}
      
      1. Optionally, enable server backup in [{{ backup-full-name }}](../../../backup/index.yaml):

          {% include [server-lease-step11](../../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}

          For more information, see [{#T}](../../../backup/operations/backup-baremetal/lease-server-with-backup.md).
      1. {% include [server-lease-step12](../../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}
      1. {% include [server-lease-step13](../../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}

{% endlist %}

As a result, the server [status](../../concepts/servers.md#server-status) will change to `PROVISIONING`. {{ baremetal-full-name }} will need up to five calendar days to create the configuration you requested and start the server, after which its status will change to `RUNNING`.
