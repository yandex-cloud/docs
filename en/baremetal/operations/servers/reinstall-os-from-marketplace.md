---
title: How to reinstall an OS on a {{ baremetal-name }} server from a {{ marketplace-name }} image
description: Follow this guide to reinstall a {{ baremetal-full-name }} server OS from a {{ marketplace-full-name }} image.
---

# Reinstalling an OS from a {{ marketplace-full-name }} image

{{ baremetal-full-name }} allows you to reinstall a server OS from a [{{ marketplace-full-name }}](/marketplace) public image. During reinstallation, you can select any OS available in {{ marketplace-name }} for {{ baremetal-name }} servers, as well as redistribute disk space, rebuild RAIDs, and reconfigure root user access parameters.

To reinstall a {{ baremetal-name }} server OS:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the server is in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the row with the server you need, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![ArrowsRotateLeft](../../../_assets/console-icons/arrows-rotate-left.svg) **{{ ui-key.yacloud.baremetal.action_reinstall-server-os-menu }}**.
  1. In the window that opens:

      1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select one of the available OS images.
      1. Optionally, configure disk partitioning:

          1. Under **{{ ui-key.yacloud.baremetal.title_section-disk }}**, click **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Specify the partitioning parameters. To create a new partition, click ![icon](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.actions_add-partition }}**.

             {% note info %}

             To build RAID arrays and configure disk partitions yourself, click **{{ ui-key.yacloud.baremetal.action_destroy-raid }}**.

             {% endnote %}

          1. Click **{{ ui-key.yacloud.common.save }}**.

          If you do not make any changes to the disk partitioning, the server will retain the previous RAID and disk space allocation settings.
      1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

      1. Click **{{ ui-key.yacloud.baremetal.action_reinstall-server-os }}** and wait until the server OS is reinstalled.

{% endlist %}