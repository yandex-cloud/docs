### I used a single connection for multiple dashboards, {{ datalens-short-name }} prompts to place all of them in the same workbook. How can I get a separate workbook for each dashboard? {#workbook-for-dashboard}

We recommend placing objects in different [workbooks](../../datalens/workbooks-collections/index.md) if they have different [access rights](../../datalens/workbooks-collections/security.md).

To get a separate workbook for each dashboard, use one of the following methods:

* First, migrate all object to one large workbook. Then, [create copies of the workbook](../../datalens/workbooks-collections/migrations.md#copy-workbook) and clear each copy of unwanted objects, only leaving the objects required for the corresponding dashboard.
* First, create copies and object replacements in the folder structure. Then, migrate everything to workbooks. For more information, see [{#T}](../../datalens/workbooks-collections/migrations.md#partial-migration).