---
title: Reports in {{ datalens-full-name }}
description: In this tutorial, you will learn about reports in {{ datalens-full-name }} and discover some features of report widgets.
---

# Reports in {{ datalens-name }}


{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}


A _report_ is a multi-page document in a specified format that you can export to PDF and print. You can add [charts](../concepts/chart/index.md), [text blocks](../dashboard/widget.md#text), [headers](../dashboard/widget.md#title), and images to report pages.

The report builder has these structural elements:

1. Report page preview area. Here you can manage the report pages: [add, move, or delete them](./report-operations.md#report-pages). To collapse the preview area, click ![image](../../_assets/console-icons/arrow-left-from-line.svg). Instead of pages, their sequence numbers will be displayed. Click ![image](../../_assets/console-icons/arrow-right-to-line.svg) to expand the preview area and display the pages.
1. Panel for [adding widgets](./report-operations.md#add-widget) to the report.
1. Basic controls:

   * **Report settings**: Opens the [report settings](./report-operations.md#report-settings) window.
   * **Page settings**: Opens the [current page settings](./report-operations.md#page-settings) window.
   * **Export**: Exports the report in `.pdf`.
   * **Save**: Saves the report.

1. Area for working with the contents of the current report page.

   ![report-page](../../_assets/datalens/report/report-page.png)

## Report widget features {#report-widget-features}

The behavior and settings of report widgets are different compared to [dashboard](../dashboard/widget.md) widgets:

* Widget height is set in the report editing window. Auto height adjustment is not supported.
* You can overlap widgets, [move them to the foreground or background](./report-operations.md#move-widget-front-or-back).
* You can set a background for any widget.
* When you paste a widget copied from a dashboard, it gets the default settings.
* Charts do not support tabs and filtering.

#### What's next {#see-also}

* [{#T}](./report-operations.md)
