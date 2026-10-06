The `datalens.metaReader` role enables executing requests from the [Audit](https://api.datalens.tech/#/Audit) section in the [{{ datalens-name }} Public API]({{ link-datalens-docs }}/operations/api-start), as well as requests to get {{ datalens-name }} entities.

You can get the following entities:

* Connection: `getConnection` [method](https://api.datalens.tech/#/Connection/post_rpc_getConnection)
* Dataset: `getDataset` [method](https://api.datalens.tech/#/Dataset/post_rpc_getDataset)
* Wizard chart: `getWizardChart` [method](https://api.datalens.tech/#/Wizard/post_rpc_getWizardChart)
* Editor chart: `getEditorChart` [method](https://api.datalens.tech/#/Editor/post_rpc_getEditorChart)
* QL chart: `getQLChart` [method](https://api.datalens.tech/#/QL/post_rpc_getQLChart)
* Dashboard: `getDashboard` [method](https://api.datalens.tech/#/Dashboard/post_rpc_getDashboard)
* Report: `getReport` [method](https://api.datalens.tech/#/Reports/post_rpc_getReport)
* Collection: `getCollection` [method](https://api.datalens.tech/#/Collection/post_rpc_getCollection)
* Collection information: `getCollectionContent` [method](https://api.datalens.tech/#/Collection/post_rpc_getCollectionContent)
* Workbook: `getWorkbook` [method](https://api.datalens.tech/#/Workbook/post_rpc_getWorkbook)
* Workbook entries: `getWorkbookEntries` [method](https://api.datalens.tech/#/Workbook/post_rpc_getWorkbookEntries)
* Entries: `getEntries` [method](https://api.datalens.tech/#/Navigation/post_rpc_getEntries)
* Entry relations: `getEntriesRelations` [method](https://api.datalens.tech/#/Entries/post_rpc_getEntriesRelations)

{% note warning %}

Getting entities will only work if the request includes the `x-dl-audit-mode` heading with the `true` value.

{% endnote %}

