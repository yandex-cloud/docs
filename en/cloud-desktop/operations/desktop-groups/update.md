---
title: Updating a desktop group
description: Follow this guide to update a desktop group.
---

# Updating a desktop group

{% include [updating-group-disclaimer](../../../_includes/cloud-desktop/updating-group-disclaimer.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the desktop group is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Next to the group you want to update, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Select an OS [image](../../concepts/images.md).
  1. Under **{{ ui-key.yacloud.vdi.section_disks }}**, increase the working disk size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Specify the number of vCPU cores.
      * Choose [guaranteed vCPU share](../../../compute/concepts/performance-levels.md).
      * Specify the amount of RAM.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
