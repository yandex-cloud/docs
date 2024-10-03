---
title: How to view service usage details in {{ billing-name }}
description: Follow this guide to view service usage details.
---

# View service usage details

You can view charts and tables with information about {{ yandex-cloud }} service usage. To do this:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select the account you want to get details for.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/chart-area-stacked.svg) **{{ ui-key.yacloud_billing.billing.account.switch_detail }}**.
   1. Select the detail depth.

{% endlist %}

Depending on the selected detail depth, you will be able to view different data:

{% note info %}

By default, usage details show the cost of consumed resources. Details in consumption units are available on the **{{ ui-key.yacloud_billing.billing.account.detail.tab_product }}** tab.

{% endnote %}

{% list tabs group=details %}

- For clouds {#clouds}

   You can view usage details for one or more clouds. The selected clouds have a mark next to their name. By default, all the linked clouds are marked. To only view usage details for some of them, in the **{{ ui-key.yacloud_billing.billing.accounts.column_cloud }}** list, deselect the clouds you need no information about. To exclude {{ datalens-full-name }}, {{ tracker-full-name }}, or {{ ml-platform-name }} usage info from details, deselect **Consumption outside cloud** at the bottom of the cloud list. To get details for selected clouds by specific product or label, click **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_all-filters }}** and specify the products and labels to include in the report.

   {% note info %}

   If a cloud was previously linked to another billing account, consider the period when viewing usage details: details are available to the current billing account for the time starting when the new account was linked. For usage prior to the link, details are available to the previous account.

   {% endnote %}

- For folders {#folders}

   You can view usage details for one or more folders. The selected folders have a mark next to their name. By default, all the folders of the selected cloud are marked. To only view usage details for some of them, in the **{{ ui-key.yacloud_billing.billing.account.detail.value_folders }}** list, deselect the folders you need no information about. To get details for selected folders by specific product or label, click **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_all-filters }}** and specify the products and labels to include in the report.

- For services {#services}

   You can view usage details for one or more services in different clouds. You can also view usage details for one or more services in different folders of the selected cloud. By default, all services in all clouds are selected. The selected elements have a mark next to their name. To only view usage details for some of them, in the **{{ ui-key.yacloud_billing.billing.account.detail.label_service }}**, **{{ ui-key.yacloud_billing.billing.account.detail.value_folders }}**, or **{{ ui-key.yacloud_billing.billing.accounts.column_cloud }}** list, deselect the elements you need no information about. To get details for selected services by specific cloud, folder, or label, click **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_all-filters }}** and specify the objects to include in the report.

- For products {#products}

   You can view usage details for one or more products in different clouds. You can also view usage details for one or more products in different folders of the selected cloud. By default, all products in all clouds are selected. The selected elements have a mark next to their name. To only view usage details for some of them, click **{{ ui-key.yacloud_billing.billing.account.detail.label_product }}** and deselect the products and services you need no information about. Click **{{ ui-key.yacloud_billing.billing.account.overview.button_bind-card-apply }}**. To get details for selected products by specific cloud, folder, or label, click **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_all-filters }}** and specify the objects to include in the report.

- For labels {#labels}

   You can view usage details for [service resource labels](../../resource-manager/concepts/labels.md). You can [add a label](../../resource-manager/operations/manage-labels.md) to a resource and then specify the label name in the **Label key** list. Any details available for the selected label in the cloud will be displayed in the chart, and the table below it will specify all the values corresponding to the selected label.
   You can also view details by a specific value of the label you select for one or more products in different folders of the selected cloud:
   1. Click **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_all-filters }}** (by default, all products in all clouds and available folders are selected). The selected elements have a mark next to their name.
   1. Specify the criteria for details:
      * Click **{{ ui-key.yacloud_billing.billing.account.detail.label_product }}** and deselect the products and services you need no information about. Click **{{ ui-key.yacloud_billing.billing.account.overview.button_bind-card-apply }}**.
      * In the **{{ ui-key.yacloud_billing.billing.account.detail.value_folders }}** or **{{ ui-key.yacloud_billing.billing.accounts.column_cloud }}** list, deselect the elements you need no information about.
      * In the **{{ ui-key.yacloud.common.labels }}** list, set a specific label value to view details for it. This filter value applies to the label selected in the **Label key** field.

{% endlist %}

By default, you get data for the current month. To change this period, click ![image](../../_assets/console-icons/calendar.svg) and set the **{{ ui-key.yacloud_billing.billing.account.detail.label_from }}** and **{{ ui-key.yacloud_billing.billing.account.detail.label_to }}** dates or select a time interval, e.g., three days. A date is defined as an interval from 0:00 to 23:59 (UTC+3). Data may be updated with a slight delay (up to several hours).

You can configure the charts to display the following:

* `{{ ui-key.yacloud_billing.billing.account.detail.value_cost }}`: Amount before discount representing the resources consumed.
* `{{ ui-key.yacloud_billing.billing.account.detail.column_expense }}`: Total amount after discount representing the resources consumed.

{% include [currency](../_includes/currency.md) %}


## Interpret the chart {#graph}

The chart shows how data changed over time.
The number of details and their values depend on the selected detail depth, chart type, and filters:
- **{{ ui-key.yacloud_billing.billing.account.detail.label_top-cost }}**: Shows the cost of services consumed before discount.
- **{{ ui-key.yacloud_billing.billing.account.detail.label_top-total }}**: Shows the cost of services consumed after discount.

Hover over a chart lines to bring up the tooltip. Each cloud, service, and product has its own color. See a description of measures below.

| Chart | Measures |
:-----: | -----
| ![image](../../_assets/billing/graph-icon.svg) | - Date that the value at the current point is valid for<br/>- Cost of services consumed within the cloud, service, or product <br/>- Cloud, service, or product name<br/>- Total cost of consumed services |
| ![image](../../_assets/billing/gistogram-icon.svg) | - Date that the value at the current point is valid for<br/>- Cost of services consumed within the cloud, service, or product<br/>- Cloud, service, or product name<br/>- Total cost of consumed services |
| ![image](../../_assets/billing/norm-gistogram-icon.svg) | - Date that the value at the current point is valid for<br/>- Percentage (%) of consumption within the cloud, service, or product relative to the total consumption<br/>- Cost of services consumed within the cloud, service, or product <br/>- Cloud, service, or product name<br/>- Total cost of consumed services<br/>- Visualization type: Chart |
| ![image](../../_assets/billing/diagram-icon.svg) | - Date that the value at the current point is valid for<br/>- Cost of services consumed within the cloud, service, or product<br/>- Cloud, service, or product name<br/>- Total cost of consumed services |
| ![image](../../_assets/billing/norm-diagram-icon.svg) | - Date that the value at the current point is valid for<br/>- Percentage (%) of consumption within the cloud, service, or product relative to the total consumption<br/>- Cost of services consumed within the cloud, service, or product<br/>- Cloud, service, or product name<br/>- Total cost of consumed services<br/>- Visualization type: Diagram |


## Interpret the table {#tab}

In the table, all data is presented as the total amount for the specified period (without splitting by date or cloud).

The number of columns in the table depends on the selected detail depth. See a description of columns below.

| Name | Description |
----- | -----
| {{ ui-key.yacloud_billing.billing.account.detail.column_cloud-name }} | Name of cloud within which the resources were consumed. <br/>Only shown when by cloud usage details are selected. |
| {{ ui-key.yacloud_billing.billing.account.detail.column_service }} | Name of service within which the resources were consumed. <br/>Only shown when by service/product usage details are selected. |
| {{ ui-key.yacloud_billing.billing.account.detail.column_product }} | Product name <br/>Only shown when usage details for products are selected. |
| {{ ui-key.yacloud_billing.billing.account.detail.column_unit }} | Units and amount of resources consumed. <br/>Only shown when usage details for products are selected. |
| {{ ui-key.yacloud_billing.billing.account.detail.column_cost }} | Cost of consumed resources before discount. |
| {{ ui-key.yacloud_billing.billing.account.detail.column_credit }} | Discount amount in the contract currency (excluding VAT or other taxes and fees). |
| {{ ui-key.yacloud_billing.billing.account.detail.column_expense }} | Total cost of consumed resources after discount. |
