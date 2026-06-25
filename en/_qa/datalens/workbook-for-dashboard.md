### I used a single connection for multiple dashboards. {{ datalens-short-name }} prompts to place all of them in the same workbook. How can I get a separate workbook for each dashboard? {#workbook-for-dashboard}

We recommend placing objects in different [workbooks](../../datalens/workbooks-collections/index.md) if you have different [access permissions](../../datalens/workbooks-collections/workbooks-operations.md#security) for them.

To get a separate workbook for each dashboard, use one of the following methods:

* First, [copy](../../datalens/workbooks-collections/migrations.md#migration-copy) all the dashboards from different workbooks. Then, remove the original objects from the folder structure.
* First, migrate all objects to a single workbook. Then, [create copies of the workbook](../../datalens/workbooks-collections/migrations.md#copy-workbook) and delete the objects you do not need from each copy, only leaving the ones required for the relevant dashboard.