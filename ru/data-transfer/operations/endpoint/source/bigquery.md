# Настройка эндпоинта-источника BigQuery

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к BigQuery.

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.project_id.title }}** — укажите идентификатор [проекта Google Cloud](https://cloud.google.com/resource-manager/docs/creating-managing-projects), содержащего набор данных приемника BigQuery.
    * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.dataset_id.title }}** — идентификатор набора данных для поиска таблиц и форм просмотра. Если задано значение в этом поле, будут перенесены данные только из указанной [схемы](https://cloud.google.com/bigquery/docs/datasets-intro), что может привести к более быстрому обнаружению схемы.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.credentials_json.title }}** — укажите содержимое JSON-файла [ключа учетной записи](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

{% endlist %}
