# Dataset materialization

{% if audience != "internal" %}

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

{% else %}

Materialization in datasets is [disabled](https://clubs.at.yandex-team.ru/datalens/132) beginning from May 23, 2022:

* The **Materialization** tab is no longer available in the interface, except for the datasets where it was set up previously.
* Beginning from July 1, all the materialized datasets will be transferred to the direct access mode.

{% note warning %}

If you have some data that have only been saved in a materialized dataset, create a bug ticket to request data export.

{% endnote %}

To accelerate the dataset processing without resorting to materialization, optimize the amount and structure of your stored data.

* [{#T}](../connection/chyt/chyt-recommendations.md)
* [CHYT performance](https://yt.yandex-team.ru/docs/description/chyt/reference/performance)

{% endif %}
