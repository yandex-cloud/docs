# Not all fields are displayed in datasets built on Yandex Metrica



## Issue description {#issue-description}

Some fields are not displayed in datasets built on Yandex Metrica.

## Solution {#issue-resolution}

You can see the exported fields on the [Yandex Metrica Live demo dashboard](https://cloud.yandex.ru/marketplace/products/yandex/metrica-live-demo).

Once you add the demo dashboard, you will see two new datasets in the Datasets menu:
* `Yandex Metrica Sessions`, XXX field
* `Yandex Metrica Impressions`, XXX fields.

## If the issue persists {#if-issue-still-persists}

If you cannot find the fields needed for your scenario among these fields, then to enable full-fledged data operations, post-processing, etc., we recommend exporting data from the [Yandex Metrica Logs API](https://yandex.ru/dev/metrika/doc/api2/logs/intro.html)  to the [cloud-based ClickHouse](../../../managed-clickhouse/) and connecting {{ datalens-full-name }} to this database.
