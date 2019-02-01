# View service usage details

Go to the **Usage Details** page to see graphs and tables showing information about usage of Yandex.Cloud services.

By default, data is displayed as of the current day from the beginning of the month. Data may be updated with a slight delay (up to several hours).

## Choose the period {#period}

You can view details for any period: in the calendar, select the start and end dates in the **From** and **To** sections.

## Group the data {#grouping}

You can group data by cloud, service, or product. For example, group by product so you can see usage data for each product separately.

To choose the data segment:

1. Select the desired option in the **Group by** section.
1. Do one of the following:

- If you are grouping by service, select services from the list in that section.
- If you are grouping by product, click **Selected** under **Products**. Then select the products and click **Add**.

## Interpret the chart{#graph}

The chart shows how the data has changed over time.
The number of details and their values depend on the selected grouping, chart type, and filters:

- **Total cost**: shows the cost of consumed services before the discount, including VAT.
- **Total**: shows the cost of consumed services after the discount, including VAT.

Point the cursor at a line on the chart to see a popup. Each cloud, service, and product has its own color. The data is described in the following table.

| Chart | Usage data |
| ----- | ----- |
| ![image](../_assets/graph-icon.png) | - The date that the value at the current point is valid for.<br/>- The cost of consumption within the cloud, product, or service (in rubles, including VAT).<br/>- The name of the product, cloud, or service. |
| ![image](../_assets/gistogram-icon.png) | - The date that the value at the current point is valid for.<br/>- The cost of consumption within the cloud, product, or service (in rubles, including VAT).<br/>- The name of the product, cloud, or service.<br/>- The total cost of consumption (in rubles, including VAT). |
| ![image](../_assets/norm-gistogram-icon.png) | - The date that the value at the current point is valid for.<br/>- The percentage (%) of consumption within the cloud, product, or service relative to the total consumption.<br/>- The cost of consumption within the cloud, product, or service (in rubles, including VAT).<br/>- The name of the product, cloud, or service.<br/>- The total cost of consumption (in rubles, including VAT). |
| ![image](../_assets/diagram-icon.png) | - The date that the value at the current point is valid for.<br/>- The cost of consumption within the cloud, product, or service (in rubles, including VAT).<br/>- The name of the product, cloud, or service.<br/>- The total cost of consumption (in rubles, including VAT). |
| ![image](../_assets/norm-diagram-icon.png) | - The date that the value at the current point is valid for.<br/>- The percentage (%) of consumption within the cloud, product, or service relative to the total consumption.<br/>- The cost of consumption within the cloud, product, or service (in rubles, including VAT).<br/>- The name of the product, cloud, or service.<br/>- The total cost of consumption (in rubles, including VAT). |

## Interpret the table {#tab}

In the table, all data is presented as the total amount for the specified period (without splitting by date).
The number of columns in the table depends on the selected grouping. Columns are described in the table below.

| Name | Description |
| ----- | ----- |
| Cloud | The name of the cloud that resources were used for. <br/>Only shown when grouping by cloud. |
| Service | The name of the service within which the resources were used. <br/>Only shown when grouping by service or product. |
| Product | Product name. <br/>Only shown when grouping by product. |
| Unit | Units and amount of resources consumed. <br/>Only shown when grouping by product. |
| Total cost | The pre-discount amount for the volume of resources consumed. In rubles, including VAT. |
| Discount | The discount amount in rubles, including VAT. |
| Total | The total amount after the discount for the amount of resources consumed. In rubles, including VAT. |

