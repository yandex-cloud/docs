---
title: How to create an image from a desktop
description: In this tutorial, you will create an image from a desktop.
---

# Creating an image from a desktop

{% note info %}

Before creating a [custom image](../../concepts/images.md#custom-images), make sure the target [desktop](../../concepts/desktops-and-groups.md) is [stopped](../desktops/start-stop.md#stop).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an image.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_add-image }}**.
  1. In the **{{ ui-key.yacloud.vdi.label_image-source }}** field, select `{{ ui-key.yacloud.iam.folder.dashboard.label_vdi }}`.
  1. In the **{{ ui-key.yacloud.vdi.label_desktop }}** field, select the desktop for your image.

      To create an image, we will use the desktop’s [boot disk](../../concepts/disks.md#boot-disk).
  1. Specify the image name.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}
