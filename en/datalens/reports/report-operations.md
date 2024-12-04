---
title: Working with a report
description: Follow this guide to learn how to work with a report.
---

# Working with a report


{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}


In this section, you will learn how to work with a report:

* [Creating a report](#create-report)
* [Adding, moving, or deleting pages](#report-pages)
* [Configuring widgets](#report-widget-settings)
* [Configuring a report](#report-settings)
* [Configuring pages](#page-settings)
* [Exporting a report](#report-export)

## Creating a report {#create-report}



There is a number of ways to create a report:

{% list tabs %}

- Workbook

  1. Go to the [page with workbooks and collections]({{ link-datalens-main }}/collections).
  1. Open the [workbook](../workbooks-collections/index.md) to create a report in.
  1. In the top-right corner, click **Create** and select **Report**.
  1. [Add pages](#report-pages) to your report.
  1. [Add](#add-widget) the required [widgets](../dashboard/widget.md) to the pages.
  1. [Configure your report](#report-settings) and its individual [pages](#page-settings).
  1. In the top-right corner, click **Save**.
  1. In the window that opens, enter a name for the report and click **Create**.

- Navigation bar

  1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
  1. In the left-hand panel, select ![image](../../_assets/console-icons/display-pulse.svg) **Reports** and click **Create report**.
  1. [Add pages](#report-pages) to your report.
  1. [Add](#add-widget) the required [widgets](../dashboard/widget.md) to the pages.
  1. [Configure your report](#report-settings) and its individual [pages](#page-settings).
  1. In the top-right corner, click **Save**.
  1. In the window that opens, enter a name for the report and click **Create**.

{% endlist %}





You can [export](#report-export) the report you created.

## Adding, moving, or deleting pages {#report-pages}

You can add multiple pages to a report, reorder, or delete them:

* To add a page, click ![image](../../_assets/console-icons/plus.svg) **Add Page** at the bottom left.
* To duplicate a page, click the ![image](../../_assets/console-icons/ellipsis.svg) icon next to the page in the preview area and select ![icon](../../_assets/console-icons/copy.svg) **Duplicate**.
* To change the order of pages, drag them to a new location using your mouse.
* To delete a page, in the preview area, click the ![image](../../_assets/console-icons/ellipsis.svg) icon next the page and select ![icon](../../_assets/console-icons/trash-bin.svg) **Delete**.

## Configuring widgets {#report-widget-settings}

You can add, copy, or delete widgets in your report. If your widgets overlap, you can move them to the foreground or background.

### Adding a widget {#add-widget}

1. Select the report page you want to add the widget to.
1. Select a widget: [Chart](../concepts/chart/index.md), [Text](../dashboard/widget.md#text), [Title](../dashboard/widget.md#title), or Image. To properly position your widget right away, drag it with the left mouse button held down.
1. Configure your widget:

   {% list tabs group=widgets %}

   - Image {#image}

     * Add a link to an [image](../dashboard/markdown.md#image) from a [{{ objstorage-full-name }}](../../storage/quickstart.md) storage.

       {% note warning %}

       In {{ objstorage-full-name }}, you must configure the [CORS](../../storage/operations/buckets/cors.md) settings for the bucket with the image:

       {% include [datalens-cors-settings-note](../../_includes/datalens/datalens-cors-settings-note.md) %}

       {% endnote %}

     * (Optional) Specify an alternative text to display if the image fails to load.
     * (Optional) Disable maintaining the aspect ratio when resizing the widget. This option is enabled by default.
     * (Optional) Set a background.

   - Chart {#chart}

     * **Name**: Widget name. If the **Show** option is enabled (default), the name is displayed at the top of the widget.
     * **Chart**: Select a chart from the list of items or provide a link to your chart.
     * (Optional) **Description**: Text displayed at the bottom of the widget.
     * (Optional) Under **Parameters**, list [chart parameters](../dashboard/dashboard_parameters.md#params-chart) and set their default values. If no default values are set, the report will display an error.
     * (Optional) Set a background.

   - Text {#text}

     * Enter the text of your link, clarifying caption, etc. The widget supports the [Markdown](../dashboard/markdown.md) markup language.

       {% note warning %}

       If inserting an image from a {{ objstorage-full-name }} storage into your widget, configure the [CORS](../../storage/operations/buckets/cors.md) settings for the bucket containing the image:

       {% include [datalens-cors-settings-note](../../_includes/datalens/datalens-cors-settings-note.md) %}

       {% endnote %}

     * (Optional) Set a background.

   - Title {#header}

     * Enter title text.
     * Select size.
     * (Optional) Set a background.

   {% endlist %}

1. Click **Add**.
1. Resize the widget and move it to a convenient location on the page.
1. In the top-right corner, click **Save**.

You can copy and paste an existing widget onto the page:


* From any page of the current report.
* From the page of another report in the same workbook.
* From any dashboard in the same workbook.



To insert a copied widget onto a page:

1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon next to the widget you want to copy and select ![icon](../../_assets/console-icons/copy.svg) **Copy**. You can copy a widget from a dashboard in edit mode.
1. Select the report page you want to insert the widget onto.
1. On the widget panel at the top, click ![icon](../../_assets/console-icons/copy-plus.svg) **Insert**.
1. Resize the widget and move it to a convenient location on the page.
1. In the top-right corner, click **Save**.

### Deleting a widget {#delete-widget}

1. Select the report page the widget is on.
1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon next to the widget and select ![icon](../../_assets/console-icons/trash-bin.svg) **Delete**.
1. In the top-right corner, click **Save**.

### Moving a widget to the foreground or background {#move-widget-front-or-back}

Widgets are arranged in layers overlapping each other. You can set the order of widgets on the page manually:

1. Select the report page the widget is on.
1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon next to the widget and select:

   * ![icon](../../_assets/console-icons/arrow-up-to-line.svg) **Foreground** to move the widget to the foreground.
   * ![icon](../../_assets/console-icons/arrow-down-to-line.svg) **Background** to move the widget to the background.

1. In the top-right corner, click **Save**.

When you select or move a widget around the page, it is automatically overlaid on top of other widgets. As soon as you stop interacting with the widget, it returns to its layer.

## Configuring a report {#report-settings}

Report settings are valid for all its pages:

1. At the top right, click ![icon](../../_assets/console-icons/gear.svg) **Report settings**.
1. Customize the appearance:

   * **Theme**: Select a page design theme, ![icon](../../_assets/console-icons/sun.svg) light or ![icon](../../_assets/console-icons/moon.svg) dark.
   * **Background color**: Specify a color in hexadecimal format or select one from the color palette.
   * **Format**: `A4` or `A3`.
   * **Orientation**: `Album` or `Portrait`.

1. Configure footer settings:

   * **{{ datalens-short-name }}** standard footer adds a footer: `Built in {{ datalens-full-name }}`.
   * **First page footer**: Repeats the footer on the first page. By default, no footer is displayed on the first page.
   * **Page numbering**: Adds a page number to the footer.

## Configuring pages {#page-settings}

You can use individual settings for each page, different from the general report settings. By default, all pages are subject to [report settings](#report-settings).

{% note info %}

Page settings have a higher priority than the same report settings. If page settings are different from the same report settings, the former will override the latter.

{% endnote %}

1. Select the report page you need to configure.
1. At the top right, click ![icon](../../_assets/console-icons/gear.svg) **Page settings** and configure the settings as needed:

   * **Theme**: Page design theme, ![icon](../../_assets/console-icons/sun.svg) light or ![icon](../../_assets/console-icons/moon.svg) dark.
   * **Background color**: Specify a color in hexadecimal format or select one from the color palette.
   * **Format**: `A4` or `A3`.
   * **Orientation**: `Album` or `Portrait`.

1. In the top-right corner, click **Save**.

## Exporting a report {#report-export}

To export a report, click **Export**. The report will be exported to a `.pdf` file.
