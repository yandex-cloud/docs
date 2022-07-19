# Настройка эндпоинта-источника BigQuery

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к BigQuery.

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    * **Project ID** — укажите идентификатор [проекта Google Cloud](https://cloud.google.com/resource-manager/docs/creating-managing-projects).
    * (Опционально) **Default Dataset ID** — если задано значение в этом поле, будут перенесены данные только из указанной [схемы](https://cloud.google.com/bigquery/docs/datasets-intro).
    * **Credentials JSON** — укажите содержимое JSON-файла [ключа учетной записи](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

{% endlist %}
