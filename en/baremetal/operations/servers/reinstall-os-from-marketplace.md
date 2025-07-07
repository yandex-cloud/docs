---
title: How to reinstall an OS on a {{ baremetal-name }} server using a {{ marketplace-name }} image
description: In this tutorial, you will learn how to reinstall a {{ baremetal-full-name }} server OS from a {{ marketplace-full-name }} image.
---

# Reinstalling an OS from a {{ marketplace-full-name }} image

{{ baremetal-full-name }} allows you to reinstall a server OS from a [{{ marketplace-full-name }}](/marketplace) public image. During reinstallation, you can select any {{ baremetal-name }} server OS available in {{ marketplace-name }}, redistribute disk space, rebuild RAID arrays, and reconfigure root user access settings.

To reinstall a {{ baremetal-name }} server OS:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in its row, and select ![ArrowsRotateLeft](../../../_assets/console-icons/arrows-rotate-left.svg) **{{ ui-key.yacloud.baremetal.action_reinstall-server-os-menu }}**.
  1. In the window that opens:

      1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select one of the available OS images.
      1. {% include [server-lease-step6](../../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}

          If you do not make any changes to the disk partitioning, the server will retain the previous RAID and disk space allocation settings.
      1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

      1. Click **{{ ui-key.yacloud.baremetal.action_reinstall-server-os }}** and wait for the server OS reinstallation to complete.

{% endlist %}