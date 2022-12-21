### Materialization fails, how do I fix it? {#fix-materialization-error}

If the original table structure changed (columns were renamed or deleted, new columns were added), materialization won't work because the new table structure wasn't loaded into the dataset yet.

To correct this behavior:
1. Open the dataset interface and click **Update fields**. For more see the [documentation](../../datalens/operations/dataset/update-field.md). This will update the information about the table and automatically add new fields. Some of the existing fields might become invalid (highlighted in red) if they were removed from the table or their type changed. In this case, fix or delete them yourself. You might also have a preview error. This is expected now, but it will be fixed in the future.
1. Save the dataset. Shortly after that, the preview is back, and your materialization starts with the updated table schema.

After saving the dataset, the charts that depend on the changed fields might fail until materialization is complete.
