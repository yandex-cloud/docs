---
title: "How to create an image from a desktop"
description: "This guide describes how you can create an image from a desktop."
---

# Creating an image from a desktop

{% note info %}

Make sure the [desktop](../../concepts/desktops-and-groups.md) you want to create a [custom image](../../concepts/images.md#custom-images) from is [stopped](../desktops/start-stop.md#stop).

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create an image.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
   1. In the left-hand panel, select ![image](../../../_assets/cloud-desktop/images.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
   1. Click **{{ ui-key.yacloud.vdi.button_add-image }}**.
   1. In the **{{ ui-key.yacloud.vdi.label_image-source }}** field, select `{{ ui-key.yacloud.iam.folder.dashboard.label_vdi }}`.
   1. In the **{{ ui-key.yacloud.vdi.label_desktop }}** field, select the desktop to create the image from.

      The desktop [boot disk](../../concepts/disks.md#boot-disk) will be used for the image.
   1. Enter the image name.
   1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}
