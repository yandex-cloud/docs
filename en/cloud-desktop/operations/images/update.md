---
title: Updating a {{ cloud-desktop-full-name }} image
description: Follow this guide to update a {{ cloud-desktop-name }} image.
---

# Updating an image

When you update an [image](../../concepts/images.md), your [desktops](../../concepts/desktops-and-groups.md) will be recreated. 

The system will recreate the [boot disk](../../concepts/disks.md#boot-disk) using the image you previously selected for the desktop group. You will lose the software and updates installed on the boot disk. The data disk will remain the same. The changes will not affect the user directory.

To apply changes to a specific desktop, [update](../desktops/update.md) it.

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/index.yaml) command to update an [image](../../concepts/desktops-and-groups.md):

      ```bash
      yc desktops image update --help
      ```

  1. Get a list of images in the default folder:

      ```bash
     yc desktops image list
      ```

      Result:

      ```bash
      +----------------------+-----------------+--------+---------------------+
      |          ID          |       NAME      | STATUS |   CREATED (UTC-0)   |
      +----------------------+-----------------+--------+---------------------+
      | e3vc67qdve8q******** | desktop-image-1 | ACTIVE | 2023-09-13 06:38:12 |
      | e3vqt6ucp1vr******** | desktop-image-2 | ACTIVE | 2025-02-18 00:00:00 |
      +----------------------+-----------------+--------+---------------------+
      ```


  1. Select the image `ID`, e.g., `e3vc67qdve8q********`.
  1. Update image parameters, e.g., its name:

      ```bash
      yc desktops image update \
        --id <image_ID> \
        --new-name <new_image_name>
      ```
      Result:

      ```text
      id: e3vc67qdve8q********
      folder_id: b1go79qlt1tp********
      created_at: "2023-09-13T06:38:12.285Z"
      status: ACTIVE
      name: renamed-desktop-image
      min_disk_size: "64424509440"
      ```

{% endlist %}