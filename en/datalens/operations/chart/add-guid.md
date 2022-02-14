# Adding guid as a parameter

To pass a filter to a chart as a parameter:

1. Open the dataset. If you don't have a dataset, [create one](../dataset/create.md).
1. In the upper-left corner, select the **Fields** tab.
1. To the right of the row with the required field, click ![image](../../../_assets/datalens/horizontal-ellipsis.svg) and select **Copy guid**.
1. Paste the guid into the chart URL as a request parameter. You should get a link looking like this: `https://datalens.yandex.ru/wizard/yfn1k6yxud7yr-example-chart?17ecb9a1-c8a5-4811-b53e-c8229f88fcba=<value>`, where:

   * `17ecb9a1-c8a5-4811-b53e-c8229f88fcba` is the field guid.
   * `<value>` is one of the field values used as a filter.

