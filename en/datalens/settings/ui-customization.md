---
title: "UI customization in {{ datalens-full-name }}"
description: "UI customization in {{ datalens-full-name }} allows you to adapt the {{ datalens-short-name }} user interface to your needs."
---

# UI customization in {{ datalens-full-name }}

{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}

UI customization in {{ datalens-short-name }} allows you to adapt your {{ datalens-short-name }} instance user interface to your needs; this includes setting up colors, logo, and design of individual elements.

To customize the UI:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/sliders.svg) **Service settings**.
1. In the **UI customization** section, click **Configure**.
1. Customize the design:

   * **UI theme**: Select the UI theme for which you want to set the color palette.
   * **Contrast**: Select the contrast for which you want to set the color palette.
   * **Color palette**: Select colors for the UI theme and contrast. You can customize a unique palette for each combination of theme and contrast.

      You can set the colors manually or generate them:

      {% list tabs %}

      - Manually

         * **Main color**: Used as a background for buttons and controls: switches, checkboxes, and selectors. Additionally, the main color is used as a theme for tooltips.
         * **Main color on hovering the cursor**: When manually customized, you can select any color. When generating a palette, a darker shade of the main color is set automatically.
         * **Page background**: Page background color. For a light theme, white is the most commonly used color. Dark themes have more options, from neutral gray shades to warm or cool colors.
         * **Additional color**: Used as a background for cards and other elements placed on top of the page background.
         * **Selected elements**: Color for selected elements, e.g., clicked buttons, selected rows, or selected text.
         * **Selected items when hovering the cursor**: Color for selected items (e.g., clicked buttons or selected rows) when hovering over them.
         * **Text on selected items**: Text color on selected items. Set it to contrast with the color of the selected elements.
         * **Lines and outlines**: Color of the active card or tab, as well as the color of the loading indicator.
         * **Link**: Link text color.
         * **Link on hover**: Link text color when the cursor hovers over it.
         * **Logo background**: Background color for the logo on the left panel.

      - Generate

         Click ![image](../../_assets/console-icons/arrows-rotate-left.svg) **Generate palette** and select the main color. Other colors will be automatically generated based on it. If required, edit the color settings manually.

      {% endlist %}

   * **Contrasting color**: Select a color for the text on the button.
   * **Logo and favicon**: To replace the logo and favicon, [upload](../../storage/quickstart.md#upload-files) an SVG file to the {{ objstorage-full-name }} storage in a 1:1 ratio. Then copy the link to the file in the storage and paste it into this field. Click **Apply** to the right of the field.
   * **Rounding**: Sets the rounding of the corners of UI elements.

   {% note info %}

   The preview area displays how the UI elements will look like with the specified settings.

   {% endnote %}

1. At the top right, click **Save**.
1. To apply your custom UI settings, select **Enabled** at the top of the screen.

   {% note info %}

   With the _Community_ plan, you cannot apply your changes to the UI; however, you can learn how UI customization works, i.e., generate palettes and save your settings.

   {% endnote %}
