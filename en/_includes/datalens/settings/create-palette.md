
{% note warning %}

To create a palette, the user needs the [admin](../../../datalens/security/roles.md#datalens-admin) role for a {{ datalens-short-name }} instance.
  
{% endnote %}


To create a color palette:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![image](../../../_assets/console-icons/sliders.svg) **Service settings**.
1. Select the **Appearance** tab.
1. Under **Palettes**, add a new palette:

   {% list tabs %}

   - Gradient color palette

     The gradient color palette is used in charts for numerical indicators.

     1. Go to **Gradient color palettes** and click **+ Add palette**.
     1. In the window that opens, enter the following parameters:

        * Enter the **Palette name** at the top.
        * Enter the start value for the gradient color at the bottom left and its end value at the bottom right. For example, specify `0044A3` on the left and `8CCBFF` on the right for a gradient from dark-blue to light-blue.

          To add an intermediate gradient value, click ![image](../../../_assets/console-icons/plus.svg) below and specify the value. The changes will be displayed in the preview window.

     1. Click **Save**.

   - Color palette

     The color palette is used in charts for discrete values: indicator names, measurement values.

     1. Go to **Color palettes** and click **+ Add palette**.
     1. In the window that opens, enter the following parameters:

        * Enter the **Palette name** at the top.
        * In the list on the right, click **+ Add color** and enter values for palette colors, in hex format.

          There are 20 default colors. You can edit, add, or delete palette colors. To change the order of colors, drag them using the mouse pointer. The changes will be displayed in the preview window.

     1. Click **Save**.

   {% endlist %}