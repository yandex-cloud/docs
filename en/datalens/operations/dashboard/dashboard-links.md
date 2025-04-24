---
title: How to configure widget links on the dashboard in {{ datalens-full-name }}
description: Follow this guide to configure widget links on the dashboard in {{ datalens-name }}.
---

# Configuring links on the dashboard


To configure [links](../../dashboard/link.md#alias) between widgets:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need.
1. In the upper-right corner, click **Edit**.
1. In the top-right corner of the edit window, click **Links**.

   {% note info %}

   To open the link settings window for a widget, click ![image](../../../_assets/datalens/links.svg) to the right of the widget.

   {% endnote %}

1. At the top of the window that opens, select the widget you want to set up links for. A list of other widgets will appear below.
   
   1. Select link type for each widget you want to link:

      * **Two-way**: Two-way influence between the widgets.
      * **Incoming**: Incoming influence.
      * **Outgoing**: Outgoing influence.
      * **Not linked**: Widgets are not linked together and have no mutual influence.

      To unlink several widgets in one go, click **Disable** at the bottom left and select:
      
      * `All`: All widgets
      * `Charts`: All charts
      * `Selectors`: All selectors

      ![image](../../../_assets/datalens/release-notes/dashboard-link.png)

   1. Click **Apply** below.

1. In the top-right corner of the dashboard, click **Save**.