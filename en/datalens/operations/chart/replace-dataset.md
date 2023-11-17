# Replacing a dataset in a chart

To replace a dataset in a chart:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/datalens/chart.svg) **Charts** and select the chart you need.
1. On the left side of the screen, click ![image](../../../_assets/datalens/horizontal-ellipsis.svg) next to the dataset and select **Replace dataset**.
1. Select another dataset.

   {% note info %}

   Make sure the new dataset contains fields with the same names as the old one. If, after replacing the dataset, the chart shows an error saying `ERR.DS_API.DB.COLUMN_DOES_NOT_EXIST`, follow the [{#T}](../dataset/update-field.md#replace-field) guide.

   {% endnote %}

1. In the top-right corner, click **Save**.
