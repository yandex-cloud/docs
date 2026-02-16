---
title: Viewing usage details for subaccounts
description: Follow this guide to view detailed information on how the customers are using the services.
---

# Viewing usage details for subaccounts

You can [view](#get-client-stat) detailed information on how the customers are using {{ yandex-cloud }} services, presented as [charts](#graph).


## Viewing usage details on the partner portal {#get-client-stat}

1. Go to the [partner portal]({{ link-cloud-partners }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/scales-balanced.svg) **Finance**.
1. Go to the ![image](../../_assets/console-icons/chart-column.svg) **Subaccount details** tab. View the usage details:

    {% note info %}

    By default, usage details show the cost of consumed resources. Usage details in consumption units are available on the **By product** tab.

    {% endnote %}

    {% list tabs group=details %}

    - For clouds {#clouds}

      You can view usage details for one or more clouds. By default, the details cover all the linked clouds.

      1. In the **Clouds** list, select a cloud.
      1. Set up data filtering:
         * **Grouping**: By days, weeks, or months.
         * **Products**: By specific products.
         * **Labels**: By specific labels.
         * **Subaccounts**: By specific subaccounts.

      {% note info %}

      If a cloud was previously linked to another billing account, consider the period when viewing usage details: details are available to the current billing account for the time starting when the new account was linked. For usage prior to the link, details are available to the previous account.

      {% endnote %}

    - For folders {#folders}

      You can view usage details for one or more folders. By default, the details cover all the selected cloud's folders.

      1. In the **Clouds** list, select a cloud.
      1. In the **Folders** list, select a folder.
      1. Set up data filtering:
         * **Grouping**: By days, weeks, or months.
         * **Products**: By specific products.
         * **Labels**: By specific labels.
         * **Subaccounts**: By specific subaccounts.

    - For services {#services}

      You can view usage details for one or more services in different clouds. You can also view usage details for one or more services in different folders of the selected cloud. By default, the details cover all services across all clouds and folders.

      1. In the **Clouds** list, select a cloud.
      1. In the **Folders** list, select a folder. 
      1. In the **Services** list, select a service.
      1. Set up data filtering:
         * **Grouping**: By days, weeks, or months.
         * **Labels**: By specific labels.
         * **Subaccounts**: By specific subaccounts.

    - For products {#products}

      You can view usage details for one or more products in different clouds. You can also view usage details for one or more products in different folders of the selected cloud. By default, the details cover all products across all clouds.

      1. In the **Clouds** list, select a cloud.
      1. In the **Folders** list, select a folder.
      1. In the **Products** list, select a product.
      1. Set up data filtering:
         * **Grouping**: By days, weeks, or months.
         * **Labels**: By specific labels.
         * **Subaccounts**: By specific subaccounts.

    - By labels {#labels}

      You can view usage details by [service resource labels](../../resource-manager/concepts/labels.md). You can [add a label](../../resource-manager/operations/manage-labels.md) to any resource. If there are details available for the selected label, the info will be displayed in the chart, and the table below it will list all the values corresponding to the selected label.

      1. In the **Clouds** list, select a cloud.
      1. In the **Folders** list, select a folder.
      1. In the **Label key** list, select a label.
      1. Set up data filtering:
         * **Grouping**: By days, weeks, or months.
         * **Products**: By specific products.
         * **Labels**: By specific labels.
         * **Subaccounts**: By specific subaccounts.

    - By subaccounts {#subacc}

      You can view usage details for one or more subaccounts in different clouds. By default, the details cover all subaccounts across all clouds and folders.

      1. In the **Clouds** list, select a cloud.
      1. In the **Folders** list, select a folder. 
      1. In the **Subaccounts** list, select a subaccount.
      1. Set up data filtering:
         * **Grouping**: By days, weeks, or months.
         * **Products**: By specific products.
         * **Labels**: By specific labels.

    {% endlist %}

    By default, you get data for the current month. To change this period, click ![image](../../_assets/console-icons/calendar.svg) and set the **From** and **To** dates or select a time period from the list. A date is set as an interval from 0:00 to 23:59 (UTC+3). Data may be updated with a slight delay (up to several hours).


## Interpreting a chart {#graph}

Charts show how tracked metrics change over time. The number of details and their values depend on the selected detail depth, chart type, and filters:

  * **Consumption**: Cost of consumed services before discount.
  * **Due and payable**: Cost of consumed services after discount.

The columns below the chart represent:

  * **Consumption cost**: Cost of services consumed by subaccounts before discount.
  * **Discount**: Customer-specific discount for services consumed by subaccounts.
  * **To be paid by client**: Cost of services consumed by subaccounts after discount.
  * **Reward**: Partner bonus for services consumed by subaccounts after the customer-specific discount (excluding the rebate).
  * **Adjustment**: Adjustment of the final cost of services consumed by subaccounts after the customer-specific discount and partner bonus.
  * **To be paid by partner**: Cost of services consumed by subaccounts after the customer-specific discount, partner bonus, and adjustment.

{% include [currency](../../billing/_includes/currency.md) %}

Hover over a chart lines to bring up the tooltip. Each cloud, service, and product has its own color. See a description of measures below.

Chart | Measures
:-----: | -----
![image](../../_assets/billing/graph-icon.svg) |- Date for which the current point's value is valid.<br/>- Cost of services consumed within cloud/folder/service/product/subaccount.<br/>- Name of cloud/folder/service/product/subaccount.<br/>- Total cost of consumed services.
![image](../../_assets/billing/gistogram-icon.svg) |- Date for which the current point's value is valid.<br/>- Cost of services consumed within cloud/folder/service/product/subaccount.<br/>- Name of cloud/folder/service/product/subaccount.<br/>- Total cost of consumed services.
![image](../../_assets/billing/norm-gistogram-icon.svg) |- Date for which the current point's value is valid.<br/>- Percentage (%) of services consumed within cloud/folder/service/product/subaccount versus total consumption.<br/>- Cost of services consumed within cloud/folder/service/product/subaccount.<br/>- Name of cloud/folder/service/product/subaccount.<br/>- Total cost of consumed services.<br/>- View type: chart.
![image](../../_assets/billing/diagram-icon.svg) |- Date for which the current point's value is valid.<br/>- Cost of services consumed within cloud/folder/service/product/subaccount.<br/>- Name of cloud/folder/service/product/subaccount.<br/>- Total cost of consumed services.
![image](../../_assets/billing/norm-diagram-icon.svg) |- Date for which the current point's value is valid.<br/>- Percentage (%) of services consumed within cloud/folder/service/product/subaccount versus total consumption.<br/>- Cost of services consumed within cloud/folder/service/product/subaccount.<br/>- Name of cloud/folder/service/product/subaccount.<br/>- Total cost of consumed services.<br/>- View type: diagram.