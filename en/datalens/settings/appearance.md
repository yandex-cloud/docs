---
title: Appearance settings in {{ datalens-full-name }}
description: The {{ datalens-full-name }} appearance settings enable you to change how the interface looks.
---


# Appearance settings in {{ datalens-full-name }}

The appearance settings allow you to change how the interface looks for the entire organization:

* [Customize the UI](#ui-customization).
* Add, edit, or delete [color palettes](#palette-settings) for charts.

{% note info %}

These settings can be edited by the {{ datalens-short-name }} instance [administrator](../security/roles.md#datalens-admin) (the `{{ roles-datalens-admin }}` role).

{% endnote %}

To access the appearance settings:

1. In the left-hand panel, select ![image](../../_assets/console-icons/sliders.svg) **Service settings**. If the panel does not show ![image](../../_assets/console-icons/sliders.svg), first select ![image](../../_assets/console-icons/ellipsis.svg) **More**, then ![image](../../_assets/console-icons/sliders.svg) **Service settings**.
1. Select the **Appearance** tab.

   ![image](../../_assets/datalens/settings/customization.png)



## UI customization {#ui-customization}

With UI customization, you can configure how your custom {{ datalens-short-name }} instance looks, i.e., its colors, logo, and individual elements.

The customization settings can be edited by the {{ datalens-short-name }} instance [administrator](../security/roles.md#datalens-admin) (the `{{ roles-datalens-admin }}` role).

For UI customization:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main-skip-promo }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/sliders.svg) **Service settings**.
1. Select the **Appearance** tab.
1. In the **UI customization** section, click ![image](../../_assets/console-icons/palette.svg) **Configure**.


   {% cut "Customizing the UI" %}

   ![image](../../_assets/datalens/settings/ui-customization.png)

   {% endcut %}


1. Customize the design:

   * **UI theme**: Select the UI theme for which you want to set the color palette.
   * **Contrast**: Select the contrast for which you want to set the color palette.
   * **Color palette**: Select colors for the UI theme and contrast. You can customize a unique palette for each combination of theme and contrast.

     You can set the colors manually or generate them:

     {% list tabs %}

     - Manually

       * **Main color**: Used as a background for buttons and controls, i.e., switches, checkboxes, and selectors. Additionally, the main color is used as a theme for tooltips.
       * **Main color on hover**: When manually customized, you can select any color. When generating a palette, a darker shade of the main color is set automatically.
       * **Page background**: Page background color. For a light theme, white is the most commonly used color. Dark themes have more options, from neutral gray shades to warm or cool colors.
       * **Dashboard background**: Default dashboard background color. Users can [override](../operations/dashboard/add-dashboard-background.md) it for specific dashboards.
       * **Widget background**: Default widget background color and opacity. Users can [override](../operations/dashboard/add-widget-background.md) this setting for all widgets on a dashboard or configure each widget individually.
       * **Elevated element background**: Background color of cards and other elevated elements. This setting does not affect the background color of widgets.
       * **Selected elements**: Color for selected elements, e.g., clicked buttons, selected rows, or selected text.
       * **Selected items on hover**: Color for selected items (e.g., clicked buttons or selected rows) when hovering over them.
       * **Text on selected items**: Text color on selected items. Set it to contrast with the color of the selected elements.
       * **Lines and outlines**: Color of the active card or tab, as well as the color of the loading indicator.
       * **Link**: Link text color.
       * **Link on hover**: Link text color when hovering over it.

     - Generate

       Click ![image](../../_assets/console-icons/arrows-rotate-left.svg) **Generate palette** and select the main color. Other colors will be automatically generated based on it. If required, edit the color settings manually.

     {% endlist %}

   * **Contrasting color**: Select a color for the button text.
   * **Logo and favicon**: To replace the logo and favicon, [upload]({{ link-docs }}/storage/quickstart#upload-files) a 1:1 aspect ratio SVG file to {{ objstorage-full-name }}. Then copy the link to the file in the storage and paste it into this field. Click **Apply** next to the field.
   
      
   * **Rounding**: Sets corner rounding for the following UI elements:

     * **Button**: Select one of the preset options.
     * **Widgets**: Select a preset option or enable **Specify custom value** and enter a value from `0` to `24` in increments of `2`.


   {% note info %}

   You can check the preview area to see how the UI elements will look like with the specified settings.

   {% endnote %}

1. At the top right, click **Save**.
1. To apply the customized UI, enable the corresponding option under **UI customization**.

## Managing a chart color palette {#palette-settings}

In {{ datalens-full-name }}, you can [create](#create-palette), [edit](#edit-palette), or [delete](#delete-palette) a color palette and [configure the default palette](#default-palette).


A palette can be created, edited, or deleted by the {{ datalens-short-name }} instance [administrator](../security/roles.md#datalens-admin) (the `{{ roles-datalens-admin }}` role).


### Creating a color palette {#create-palette}

{% include [create-palette](../../_includes/datalens/settings/create-palette.md) %}

### Editing a color palette {#edit-palette}

{% include [edit-palette](../../_includes/datalens/settings/edit-palette.md) %}

### Deleting a color palette {#delete-palette}

{% include [delete-palette](../../_includes/datalens/settings/delete-palette.md) %}


### Setting up the default color palette {#default-palette}

{% include [default-palette](../../_includes/datalens/settings/default-palette.md) %}


