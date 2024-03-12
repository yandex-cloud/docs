1. Upload the product logo in SVG format.

1. Select product categories.

1. In the **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** field, select the service plan that you created or create a new one.

1. Under **Preset**, click **Choose preset**. In the window that opens:

   1. Select a preset, i.e., a group of Yandex Cloud services for the application to operate on. The following presets are currently available:
      * {{ network-load-balancer-name }} + {{ ig-name }}
      * {{ network-load-balancer-name }} + {{ ig-name }} + {{ mpg-name }}
      * {{ network-load-balancer-name }} + {{ ig-name }} + {{ mmy-name }}
      * {{ network-load-balancer-name }} + {{ ig-name }} + {{ mrd-name }}
      * {{ network-load-balancer-name }} + {{ ig-name }} + {{ objstorage-name }}
   1. Under **Preset parameters**, set the default parameters for resources to be created during the application installation. Make sure the disk image meets the [requirements](../../marketplace/operations/create-image.md).

   To enable users to edit the defaults, copy the name of the variable from the tooltip next to the preset parameter and create a field with that variable name under **App parameters**.

1. List parameters to be specified by the user before installing the application under **App parameters**. To do this, click **Overview** → **+ Create field**. To check the appearance of the fields with the settings you selected, go to the **Preview** tab.

   You can get user-defined values on a VM instance created by the application:
   * From the [metadata service](../../compute/operations/vm-info/get-info.md#inside-instance)
   * From the `/etc/cloud-app.conf` file

   The names of the parameters storing values are the same as those of the variables.

1. In the **Application template** field, select the folder to test application deployment in.

1. {% include [product-info](product-info.md) %}

1. {% include [links](links.md) %}

1. {% include [terms](terms.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.

After a version is created, click **Run** in the top-right corner to test the application deployment. Make sure that everything is up and running.