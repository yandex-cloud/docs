# Adding parameters to a chart

{% note info %}

* Parameters added at the chart level are only available in this chart.
* If a dataset has a parameter with the same name, the parameter from the chart is ignored.

{% endnote %}

To add a [parameter](../../concepts/parameters.md) to a chart:

1. On the navigation page, find the chart to add the parameter to.
1. On the left of the screen, click ![image](../../../_assets/plus-sign.svg) under the dataset and select **Parameter**.
1. In the **Add parameter** window, specify:

   * **Name**. Sets the parameter name.
   * **Type**. Defines the parameter data type: **Date**, **Date and time**, **Fractional number**, **Logical**, **String**, or **Integer**.
   * **Default value**. Required. Used when no parameter value is set in the dashboard, chart URL, or chart settings.

1. Click **Add**.

## Changing the default value {#change-value}

You can change the default value of a dataset parameter at the chart level:

1. Click the icon to the left of the parameter name.
1. In the **Edit parameter** window, set a new parameter value.
1. Click **Save**.

## Resetting the default value {#to-default}

To reset the default parameter value to its original value from the dataset:

1. Click the icon to the left of the parameter name.
1. In the **Edit parameter** window, click **Initial value**. The default parameter value will be reset to its original value from the dataset.
1. Click **Save**.

You can also create parameters [at the dataset level](../dataset/add-parameter-dataset.md).
