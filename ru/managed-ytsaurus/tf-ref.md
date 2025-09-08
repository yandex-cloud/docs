# Справочник {{ TF }} для {{ myt-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ myt-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_ytsaurus_cluster]({{ tf-provider-resources-link }}/ytsaurus_cluster) | Кластер |

## Источники данных {#data-sources}

Для {{ myt-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_ytsaurus_cluster]({{ tf-provider-datasources-link }}/ytsaurus_cluster) | Информация о кластере {{ ytsaurus-name }} |
