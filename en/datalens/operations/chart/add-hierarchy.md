# Adding a hierarchy

To add a hierarchy:
1. {% if product == "yandex-cloud" %}On the {{ datalens-full-name }} [homepage]({{ link-datalens-main }}), click **Create chart**.{% endif %}{% if product == "cloud-il" %}Open the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).{% endif%}
1. {% if product == "yandex-cloud" %}Under **Dataset**, select a dataset for visualization. If you don't have a dataset, [create it](../dataset/create.md).{% endif %}{% if product == "cloud-il" %}Go to the [workbook](../../concepts/index.md#workbooks-and-collections) in which you want to create a chart with a hierarchy.{% endif %}
{% if product == "cloud-il" %}1. On the workbook page, click **Create** → **Wizard chart** in the upper-right corner.{% endif %}
{% if product == "cloud-il" %}1. In the **Select dataset** field, select a dataset from the list. If you don't have a dataset, [create one](../dataset/create.md).{% endif %}
1. Select any chart type except **Map**, **Indicator**, **Tree chart**, and **Pivot table**.
1. To the left of the wizard interface, click **![image](../../../_assets/plus-sign.svg)** and select **Add hierarchy**.
1. Enter the hierarchy name, select dimensions, and arrange them however you'd like.
1. In the lower-right corner, click **Save**.
1. Drag the created hierarchy to any available section. For example, for the **Table** chart type, the **Columns** section is available.
1. Drag other dimensions and measures to the desired sections.

{% note info %}

You can add only one hierarchy to a visualization.

{% endnote %}

##### See also

* [{#T}](../../concepts/data-types.md#how-to-create-tree).
