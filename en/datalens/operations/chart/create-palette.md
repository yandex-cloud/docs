# Creating a color palette


{% note warning %}

To create a palette, the user needs the [admin](../../security/roles.md#datalens-admin) role for a {{ datalens-short-name }} instance.

{% endnote %}


To create a color palette:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![image](../../../_assets/datalens/service-settings.svg) **Service settings**.
1. Under **Palettes**, add a new palette:

   {% list tabs %}

   - Gradient color palette

      {% note info %}

      Use a gradient color palette in charts for numeric values.

      {% endnote %}

      1. Go to **Gradient color palettes** and click **+ Add palette**.
      1. In the window that opens, enter the following parameters:

         * Enter the **Palette name** at the top.
         * Enter the start value for the gradient color at the bottom left and its end value at the bottom right. For example, specify `0044A3` on the left and `8CCBFF` on the right so that the gradient changes from dark-blue to light-blue.

            To add an intermediate gradient value, click ![image](../../../_assets/datalens/plus.svg) at the bottom and specify the value. The changes will be displayed in the preview window.

      1. Click **Save**.

   - Color palette

      {% note info %}

      Use a color palette in charts for discrete values, such as measure names and dimension values.

      {% endnote %}

      1. Go to **Color palettes** and click**+ Add palette**.
      1. In the window that opens, enter the following parameters:

         * Enter the **Palette name** at the top.
         * In the list on the right, click **+ Add color** and enter values for palette colors in hexadecimal format.

            By default, values for 20 colors are set. You can edit, add, or delete palette colors. To change the order of colors, drag them using the mouse pointer. The changes will be displayed in the preview window.

      1. Click **Save**.

   {% endlist %}

## Changing a color palette {#update-palette}

To change a color palette:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![image](../../../_assets/datalens/service-settings.svg) **Service settings**.
1. Go to **Palettes** and click the line with the palette to change.
1. Make changes in the **Configure color palettes** window.
1. Click **Save**.

## Deleting a color palette {#delete-palette}

{% note info %}

Deleting a color palette resets the [color settings](../../concepts/chart/settings.md#color-settings) in all charts where it was used.

{% endnote %}

To delete a color palette:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![image](../../../_assets/datalens/service-settings.svg) **Service settings**.
1. Go to **Palettes** and hover over the name of the palette to delete.
1. Click ![image](../../../_assets/datalens/horizontal-ellipsis.svg) on the right and select **Delete**.
1. Click **Delete**.
