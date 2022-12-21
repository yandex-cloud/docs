# Dataset materialization


{% include [datalens-materialization-off-unavailable](../../../_includes/datalens/datalens-materialization-off-unavailable.md) %}

To materialize a dataset:

1. On the navigation page, find the dataset and open it.
1. Click the ![image](../../../_assets/datalens/horizontal-ellipsis.svg) icon at the top of the screen and select ![image](../../../_assets/datalens/materialize.svg) **Materialization**.
1. In the window that appears, select:

   * **Direct access**: All data requests are executed on the source. Data is not uploaded to the materialization DB.
   * **One-time materialization**: Data is uploaded to the materialization DB once.
   * **Periodic materialization**: Data is uploaded to the materialization DB on schedule.

1. Specify the materialization settings and click **Save**.

#### See also {#see-also}
- [{#T}](../../concepts/dataset/settings.md#mode)

