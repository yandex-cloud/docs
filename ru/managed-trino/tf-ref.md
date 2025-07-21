# Справочник {{ TF }} для {{ mtr-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mtr-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_trino_cluster]({{ tf-provider-resources-link }}/trino_cluster) | Кластер |
| [yandex_trino_catalog]({{ tf-provider-resources-link }}/trino_catalog) | Каталог |

## Источники данных {#data-sources}

Для {{ mtr-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_trino_cluster]({{ tf-provider-datasources-link }}/trino_cluster) | Информация о [кластере {{ TR }}](./concepts/index.md#cluster-architecture) |
| [yandex_trino_catalog]({{ tf-provider-datasources-link }}/trino_catalog) | Информация о [каталоге {{ TR }}](./concepts/index.md#catalog) |
