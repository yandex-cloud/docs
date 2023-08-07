# Creating an image from a desktop

{% note info %}

Make sure the [desktop](../../concepts/desktops-and-groups.md) you want to create a [custom image](../../concepts/images.md#custom-images) from is [stopped](../desktops/start-stop.md#stop).

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create an image.
   1. In the list of services, select **{{ cloud-desktop-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/cloud-desktop/images.svg) **Images**.
   1. Click **Add image**.
   1. In the **Image source** field, select **{{ cloud-desktop-name }}**.
   1. In the **Desktop** field, select the desktop to create the image from.

      The desktop [boot disk](../../concepts/disks.md#boot-disk) will be used for the image.
   1. Enter the image name.
   1. Click **Add**.

{% endlist %}
