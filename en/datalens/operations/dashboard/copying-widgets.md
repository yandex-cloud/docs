---
title: Copying widgets on a dashboard in {{ datalens-full-name }}
description: Follow this guide to copy and paste widgets on a dashboard in {{ datalens-name }}.
---

# Copying widgets on a dashboard in {{ datalens-full-name }}

You can [copy](#copy-widget) and [paste](#paste-widget) an existing widget onto your dashboard.

## Copying a widget {#copy-widget}


Note the following considerations when copying widgets from a dashboard or report:

{% list tabs %}

- From a dashboard

  * You can copy widgets from any dashboard tab you have access to.
  * Copying is available for these widget types: [title](../../dashboard/widget.md#title), [text](../../dashboard/widget.md#text), [chart](../../concepts/chart/index.md), [selector](../../dashboard/selector.md), or [selector (JS)](../../charts/editor/widgets/controls.md).
  * To copy a widget from a dashboard:

    1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need.
    1. At the top of the page, click **Edit**.
    1. On the dashboard, next to the widget, click ![image](../../../_assets/console-icons/ellipsis.svg) → ![image](../../../_assets/console-icons/copy.svg) **Copy**.

- From a report

  * You can copy widgets from any report page you have access to.
  * Copying is available for these widget types: [title](../../dashboard/widget.md#title), [text](../../dashboard/widget.md#text), [chart](../../concepts/chart/index.md), [selector](../../dashboard/selector.md), or [selector (JS)](../../charts/editor/widgets/controls.md).
  * You cannot copy [images](../../dashboard/markdown.md#image) from a report to a dashboard.
  * To copy a title, text, or chart from a report:
    
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/display-pulse.svg) **Reports** and select the report.
    1. On the dashboard, next to the widget, click ![image](../../../_assets/console-icons/ellipsis.svg) → ![image](../../../_assets/console-icons/copy.svg) **Copy**.
  
  * To copy a selector from a report:
  
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/display-pulse.svg) **Reports** and select the report.
    1. At the top right, click ![icon](../../../_assets/console-icons/funnel.svg).
    1. On the right, in the **Selectors** window, click ![icon](../../../_assets/console-icons/pencil.svg).
    1. Next to the selector, click ![image](../../../_assets/console-icons/ellipsis.svg) → ![image](../../../_assets/console-icons/copy.svg) **Copy**.
  
{% endlist %}



{% note info %}

* Widgets with links to objects from another workbook cannot be pasted.
* To use an object in a different workbook, copy all linked objects from the source workbook into the target workbook.

{% endnote %}


## Pasting a widget {#paste-widget}

To paste a copied widget onto your dashboard:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need. If you do not have a dashboard, [create one](create.md).
1. At the top of the page, click **Edit**.
1. Select the dashboard tab you want to paste the widget onto.
1. In the panel at the bottom of the page, hold down ![image](../../../_assets/console-icons/copy-plus.svg) **Paste** and drag the widget to the target area.
1. Resize the widget and move it to a convenient location on the page.
1. In the top-right corner of the dashboard, click **Save**.
