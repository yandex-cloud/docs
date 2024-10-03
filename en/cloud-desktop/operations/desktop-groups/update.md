---
title: Updating a desktop group
description: Follow this guide to update a desktop group.
---

# Updating a desktop group

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the desktop group is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
   1. Next to the group to update, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
   1. Select an OS [image](../../concepts/images.md).

      {% note warning %}

      Updating an image deletes all data on the desktop [boot disks](../../concepts/disks.md#boot-disk). Data on [working disks](../../concepts/disks.md#working-disk) will persist.

      {% endnote %}

   1. Under **{{ ui-key.yacloud.vdi.section_disks }}**, increase the working disk size.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Specify the number of vCPU cores.
      * Choose a [guaranteed](../../../compute/concepts/performance-levels.md) vCPU performance.
      * Specify the amount of RAM.
   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

To apply the changes to the desktop, [update](../desktops/update.md) it.
