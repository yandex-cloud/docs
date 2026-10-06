Роль `datalens.metaReader` позволяет выполнять запросы в [{{ datalens-name }} Public API]({{ link-datalens-docs }}/operations/api-start) из раздела [Audit](https://api.datalens.tech/#/Audit), а также запросы для получения сущностей {{ datalens-name }}.

Доступно получение следующих сущностей:

* подключение — [метод](https://api.datalens.tech/#/Connection/post_rpc_getConnection) `getConnection`;
* датасет — [метод](https://api.datalens.tech/#/Dataset/post_rpc_getDataset) `getDataset`;
* чарт в Wizard — [метод](https://api.datalens.tech/#/Wizard/post_rpc_getWizardChart) `getWizardChart`;
* чарт в Editor — [метод](https://api.datalens.tech/#/Editor/post_rpc_getEditorChart) `getEditorChart`;
* QL-чарт — [метод](https://api.datalens.tech/#/QL/post_rpc_getQLChart) `getQLChart`;
* дашборд — [метод](https://api.datalens.tech/#/Dashboard/post_rpc_getDashboard) `getDashboard`;
* отчет — [метод](https://api.datalens.tech/#/Reports/post_rpc_getReport) `getReport`;
* коллекция — [метод](https://api.datalens.tech/#/Collection/post_rpc_getCollection) `getCollection`;
* информация о коллекции — [метод](https://api.datalens.tech/#/Collection/post_rpc_getCollectionContent) `getCollectionContent`;
* воркбук — [метод](https://api.datalens.tech/#/Workbook/post_rpc_getWorkbook) `getWorkbook`;
* сущности в воркбуке — [метод](https://api.datalens.tech/#/Workbook/post_rpc_getWorkbookEntries) `getWorkbookEntries`;
* сущности — [метод](https://api.datalens.tech/#/Navigation/post_rpc_getEntries) `getEntries`;
* связи между сущностями — [метод](https://api.datalens.tech/#/Entries/post_rpc_getEntriesRelations) `getEntriesRelations`.

{% note warning %}

Получение сущностей работает, только если в запросе передан заголовок `x-dl-audit-mode` со значением `true`.

{% endnote %}

