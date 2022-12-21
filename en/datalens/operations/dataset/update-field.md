# Updating fields in datasets

You need to update fields if you changed the schema of a table (or tables) in a data source or manually deleted fields from a dataset.

To update fields in a dataset:
1. Open the dataset.
1. In the upper-left corner, select the **Fields** tab.
1. At the top of the screen, click **Update fields**.

## Replace a field {#replace-field}

If a field has been removed from a data source, it will not be updated when a dataset is updated. A chart based on this dataset will display the `ERR.DS_API.DB.COLUMN_DOES_NOT_EXIST` error.

To fix the error, replace the field in the dataset:
1. Open the dataset.
1. In the upper-left corner, select the **Fields** tab.
1. In the dataset, select the field you wish to replace.
1. Go to the **Field source** column.
1. In the field settings, select the field you wish to replace the deleted field with from the **Field from source** list.
