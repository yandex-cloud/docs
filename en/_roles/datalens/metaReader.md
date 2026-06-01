The `datalens.metaReader` role enables executing requests from the [Audit](https://api.datalens.tech/#/Audit) section in the [{{ datalens-name }} Public API](../../datalens/operations/api-start.md), as well as requests to get {{ datalens-name }} entities.

You can get the following entities:

* Connection: `getConnection` [method](https://api.datalens.tech/#/Connection/post_rpc_getConnection)
* Dataset: `getDataset` [method](https://api.datalens.tech/#/Dataset/post_rpc_getDataset)
* Wizard chart: `getWizardChart` [method](https://api.datalens.tech/#/Wizard/post_rpc_getWizardChart)
* Editor chart: `getEditorChart` [method](https://api.datalens.tech/#/Editor/post_rpc_getEditorChart)
* QL chart: `getQLChart` [method](https://api.datalens.tech/#/QL/post_rpc_getQLChart)
* Dashboard: `getDashboard` [method](https://api.datalens.tech/#/Dashboard/post_rpc_getDashboard)
* Report: `getReport` [method](https://api.datalens.tech/#/Reports/post_rpc_getReport)

{% note warning %}

Getting entities will only work if the request includes the `x-dl-audit-mode` heading with the `true` value.

{% endnote %}

