# Some fields are not displayed in datasets built on {{ metrika }}



## Issue description {#issue-description}

Some fields are not displayed in datasets built on {{ metrika }}.

## Solution {#issue-resolution}

You can see the exported fields on the [Yandex Metrica Live demo dashboard](https://yandex.cloud/en/marketplace/products/yandex/metrica-live-demo). Once you add the demo dashboard, you will see two new datasets in the **{{ ui-key.datalens.component.aside-header.view.switch_datasets }}** menu:

* `Yandex Metrica Sessions`, *** fields.
* `Yandex Metrica Impressions`, *** fields.

## If the issue persists {#if-issue-still-persists}

If you cannot find the fields you need among these fields, you may want to data from the [{{ metrika }} Logs API](https://yandex.ru/dev/metrika/en/logs/) to the [cloud-based {{ CH }}](../../../managed-clickhouse/) and connecting {{ datalens-name }} to this database. This will enable full-fledged data operations.

