---
title: How to add a header to a dashboard in {{ datalens-full-name }}
description: Follow this guide to add a header to a dashboard in {{ datalens-full-name }}.
---

# Adding a header to a dashboard in {{ datalens-full-name }}

To add a [header](../../dashboard/widget.md#title) to a dashboard:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need. If you do not have a dashboard, [create one](create.md).
1. At the top of the page, click **Edit**.
1. In the panel at the bottom of the page, drag ![image](../../../_assets/console-icons/heading.svg) **Header** where you need.

   ![image](../../../_assets/datalens/operations/widget-select.png =500x118)

1. Configure your widget:

   * Enter the header text.
   * Select the text size from the preset options: `XS`, `S`, `M`, `L`, or `XL`.
   * Optionally, set a text color by selecting one from the palette.
   * Optionally, set a background.
   * Optionally, enable **Tooltip** and enter the tooltip text. The input field supports [Markdown](../../dashboard/markdown.md).
   * Optionally, enable **Auto height**.
   * Optionally, enable **Display in contents**.

1. Click **Add**. The widget will appear on the dashboard. A hash for the header is created automatically, and you can see the `#` icon when hovering over the header.

## Adding to the table of contents {#dashboard-content}

To add a header with an anchor link to the table of contents, enable the **Display in table of contents** option in the widget editing window. When you click the header in the table of contents, the dashboard page automatically scrolls to this section and its hash is added to the address bar.
