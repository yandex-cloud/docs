# View service usage details

You can view graphs and tables with information about {{ yandex-cloud }} service usage. To do this:

1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
1. In the upper-left corner, click ![image](../../_assets/main-menu.svg) **All services**.
1. Select ![image](../../_assets/billing.svg) [**Billing**]({{ link-console-billing }}).
1. Select an account on the **List of accounts** page.
1. Go to the **Usage details** page.
1. Select the [clouds](#clouds) and [period](#period), as well as [configure service and product data grouping](#grouping).

By default, data is displayed from the start of the month to the current day. Data may be updated with a slight delay (up to several hours).

{% include [currency](../_includes/currency.md) %}

## Select clouds {#clouds}
You can view usage details for one or more clouds.
By default, all linked clouds are selected (a check mark is displayed next to the name of the cloud). To view usage details for only some clouds, open the list and click the names of the clouds that you don't want to view data for (the check mark will disappear next to their names).

{% note info %}

If a cloud was previously linked to another billing account, consider the period when viewing usage details: details are available to the current billing account for the time starting when the new account was linked. For usage prior to the link, details are available to the previous account.

{% endnote %}

## Select a period {#period}
You can view details for any period: in the calendar, select the start and end dates in the **From** and **To** sections.

## Configure data grouping {#grouping}
You can group data by cloud, service, or product. For example, group by product so you can see usage data for each product separately.

To choose the data segment:
1. Select the desired option in the **Group by**.
1. Do one of the following:
- If you are grouping by service, select services from the list in that section.
- If you are grouping by product, click **Selected** under **Products**. Then select the products and click **Add**.

## Interpret the chart{#graph}

The chart shows how data changed over time.
The number of details and their values depend on the selected grouping, chart type, and filters:
- **Total cost**: Shows the cost of services consumed before the discount.
- **Total**: Shows the cost of services consumed after the discount.

Point the cursor to a line on the chart to see a popup. Each cloud, service, and product has its own color. The data is described in the following table.

| Chart | Measures |
----- | -----
| ![image](../../_assets/billing/graph-icon.png) | - The date that the value at the current point is valid for.<br/>- The cost of services consumed within the cloud, product, or service. <br/>-The name of the product, cloud, or service. |
| ![image](../../_assets/billing/gistogram-icon.png) | - The date that the value at the current point is valid for.<br/>- The cost of services consumed within the cloud, product, or service.<br/>- The name of the product, cloud, or service.<br/>-The total cost of consumption. |
| ![image](../../_assets/billing/norm-gistogram-icon.png) | - The date that the value at the current point is valid for.<br/>- The percentage (%) of consumption within the cloud, product, or service relative to the total consumption.<br/>- The cost of services consumed within the cloud, product, or service. <br/>- The name of the product, cloud, or service.<br/>- The total cost of consumption. |
| ![image](../../_assets/billing/diagram-icon.png) | - The date that the value at the current point is valid for.<br/>- The cost of services consumed within the cloud, product, or service.<br/>- The name of the product, cloud, or service.<br/>-The total cost of consumption. |
| ![image](../../_assets/billing/norm-diagram-icon.png) | - The date that the value at the current point is valid for.<br/>- The percentage (%) of consumption within the cloud, product, or service relative to the total consumption.<br/>- The cost of services consumed within the cloud, product, or service.<br/>- The name of the product, cloud, or service.<br/>- The total cost of consumption. |



## Interpret the table {#tab}

In the table, all data is presented as the total amount for the specified period (without splitting by date or cloud).
The number of columns in the table depends on the selected grouping. They are described in the table below.

| Name | Description |
----- | -----
| Cloud | The name of the cloud that resources were used for. <br/>Only shown when grouping by cloud. |
| Service | The name of the service that resources were used in. <br/>Only shown when grouping by service or product. |
| Product | Product name <br/>Only shown when grouping by product. |
| Consumption unit | Units and amount of resources consumed. <br/>Only shown when grouping by product. |
| Total cost | The amount for the volume of resources consumed before applying discounts. |
| Discount | The discount amount in the currency of the agreement (excluding VAT or other taxes and fees). |
| Total | The total amount for resources consumed after applying discounts. |
