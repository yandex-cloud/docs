# Справочник {{ TF }} для {{ mpg-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mpg-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_postgresql_cluster]({{ tf-provider-resources-link }}/mdb_postgresql_cluster) | [Кластер {{ PG }}](./concepts/index.md) |
| [yandex_mdb_postgresql_database]({{ tf-provider-resources-link }}/mdb_postgresql_database) | База данных {{ PG }} |
| [yandex_mdb_postgresql_user]({{ tf-provider-resources-link }}/mdb_postgresql_user) | Пользователь {{ PG }} |

## Источники данных {#data-sources}

Для {{ mpg-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_postgresql_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_postgresql_cluster) | Информация о [кластере {{ PG }}](./concepts/index.md) |
| [yandex_mdb_postgresql_database]({{ tf-provider-datasources-link }}/datasource_mdb_postgresql_database) | Информация о базе данных {{ PG }} |
| [yandex_mdb_postgresql_user]({{ tf-provider-datasources-link }}/datasource_mdb_postgresql_user) | Информация о пользователе {{ PG }} |