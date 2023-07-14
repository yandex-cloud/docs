# View service usage details

You can view charts and tables with information about {{ yandex-cloud }} service usage. To do this:

1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
1. In the top-left corner, click ![image](../../_assets/main-menu.svg) **All services**.
1. Select ![image](../../_assets/billing.svg) [**Billing**]({{ link-console-billing }}).
1. Click on the name of the appropriate account and select ![image](../../_assets/billing/detalization.svg) **Usage details**.
1. Select the detail depth:

{% list tabs %}

- For clouds

   You can view usage details for one or more clouds. The selected clouds have a mark next to their name. By default, all the linked clouds are marked. To only view usage details for some of them, in the **Clouds** list, deselect the clouds that you don't need information about.

   {% note info %}

   If a cloud was previously linked to another billing account, consider the period when viewing usage details: details are available to the current billing account for the time starting when the new account was linked. For usage prior to the link, details are available to the previous account.

   {% endnote %}

- For folders

   You can view usage details for one or more folders. The selected folders have a mark next to their name. By default, all the folders of the selected cloud are marked. To only view usage details for some of them, in the **Folders** list, deselect the folders that you don't need information about.

- For services

   You can view usage details for one or more services in different clouds. You can also view usage details for one or more services in different folders of the selected cloud. By default, all services in all clouds are selected. The selected elements have a mark next to their name. To only view usage details for some of them, in the **Services**, **Folders**, or **Clouds** list, deselect the elements that you don't need information about.

- For products

   You can view usage details for one or more products in different clouds. You can also view usage details for one or more products in different folders of the selected cloud. By default, all products in all clouds are selected. The selected elements have a mark next to their name. To only view usage details for some of them:
   * Click **Products** and deselect the products and services that you don't need information about. Click **Add**.
   * In the **Folders** or **Clouds** list, deselect the elements that you don't need information about.

{% endlist %}

By default, data is uploaded for the last 30 days. To change the period to view usage details for, click ![image](../../_assets/billing/calendar.svg) and set the **From** and **To** dates or select a time interval, such as three days. Dates are set as a range from 0:00 to 23:59 (UTC+3). Data may be updated with a slight delay (up to several hours).

You can select the following to display on charts:

* `Consumption`: Amount for resources consumed before applying discounts.
* `Due and payable`: The total amount for resources consumed after applying discounts.

{% include [currency](../_includes/currency.md) %}


## Interpret the chart {#graph}

The chart shows how data changed over time.
The number of details and their values depend on the selected detail depth, chart type, and filters:
- **Total cost**: Shows the cost of services consumed before the discount.
- **Total**: Shows the cost of services consumed after the discount.

Point the cursor to a line on the chart to see a popup. Each cloud, service, and product has its own color. See a description of measures below.

| Chart | Measures |
:-----: | -----
| ![image](../../_assets/billing/graph-icon.svg) | - The date that the value at the current point is valid for.<br/>- The cost of services consumed within the cloud, service, or product. <br/>- The name of the cloud, service, or product. |
| ![image](../../_assets/billing/gistogram-icon.svg) | - The date that the value at the current point is valid for.<br/>- The cost of services consumed within the cloud, service, or product.<br/>- The name of the cloud, service, or product.<br/>-The total cost of consumption. |
| ![image](../../_assets/billing/norm-gistogram-icon.svg) | - The date that the value at the current point is valid for.<br/>- The percentage (%) of consumption within the cloud, service, or product relative to the total consumption.<br/>- The cost of services consumed within the cloud, service, or product. <br/>- The name of the cloud, service, or product.<br/>- The total cost of consumption.<br/>- Form of representation: Chart. |
| ![image](../../_assets/billing/diagram-icon.svg) | - The date that the value at the current point is valid for.<br/>- The cost of services consumed within the cloud, service, or product.<br/>- The name of the cloud, service, or product.<br/>-The total cost of consumption. |
| ![image](../../_assets/billing/norm-diagram-icon.svg) | - The date that the value at the current point is valid for.<br/>- The percentage (%) of consumption within the cloud, service, or product relative to the total consumption.<br/>- The cost of services consumed within the cloud, service, or product.<br/>- The name of the cloud, service, or product.<br/>- The total cost of consumption.<br/>- Form of representation: Diagram. |


## Interpret the table {#tab}

In the table, all data is presented as the total amount for the specified period (without splitting by date or cloud).

The number of columns in the table depends on the selected detail depth. See a description of columns below.

| Name | Description |
----- | -----
| Cloud | The name of the cloud that resources were used for. <br/>Only shown when usage details for clouds are selected. |
| Service | The name of the service that resources were used in. <br/>Only shown when usage details for services or products are selected. |
| Product | Product name <br/>Only shown when usage details for products are selected. |
| Consumption unit | Units and amount of resources consumed. <br/>Only shown when usage details for products are selected. |
| Consumption cost | The amount for the volume of resources consumed before applying discounts. |
| Discount | The discount amount in the currency of the agreement (excluding VAT or other taxes and fees). |
| Due and payable | The total amount for resources consumed after applying discounts. |
