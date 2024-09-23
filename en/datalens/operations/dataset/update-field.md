# Updating fields in datasets

You need to update fields if you changed the schema of a table (or tables) in a data source or manually deleted fields from a dataset.

To update fields in a dataset:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/circles-intersection.svg) **Datasets** and select the dataset you need.
1. In the top-left corner, select the **Fields** tab.
1. At the top of the screen, click **Update fields**:

   * If the field is missing in the dataset but present in the data source, it will show up in the list.
   * If the field is present in both the dataset and the data source, it will be updated, e.g., its type will change.
   * If the field is present in the dataset but missing in the data source, it will be marked red. Delete it from the dataset or [replace](#replace-field) it with a different field from the data source.

1. In the top-right corner, click **Save**.

## Replace a field {#replace-field}

If a field has been removed from a data source, it will not be updated when a dataset is updated. Charts featuring this field will show the [`ERR.DS_API.FORMULA.UNKNOWN_SOURCE_COLUMN`](../../troubleshooting/errors/ERR-DS_API-FORMULA-UNKNOWN_SOURCE_COLUMN.md) error. You can delete this field from the chart or replace its source in the dataset.

To replace the field source in the dataset:

1. In the left-hand panel, click ![image](../../../_assets/console-icons/circles-intersection.svg) **Datasets** and select the dataset you need.
1. In the top-left corner, select the **Fields** tab.
1. In the dataset, select the field you want to replace.
1. Go to the **Field source** column.
1. In the field settings, select the field you wish to replace the deleted field with from the **Field from source** list.
1. In the top-right corner, click **Save**.
