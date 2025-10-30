---
title: Справочник {{ TF }} для {{ mspqr-full-name }}
description: На этой странице приведен справочник ресурсов провайдера {{ TF }}, которые поддерживаются для сервиса {{ mspqr-name }}.
---

# Справочник {{ TF }} для {{ mspqr-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mspqr-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}**                                                                                        | **Ресурс {{ yandex-cloud }}**                        |
|------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [yandex_mdb_sharded_postgresql_cluster]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster)   | [Кластер {{ SPQR }}](./operations/cluster-create.md) |
| [yandex_mdb_sharded_postgresql_database]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_database) | [База данных {{ SPQR }}](https://pg-sharding.tech/)  |
| [yandex_mdb_sharded_postgresql_shard]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_shard)       | [Шард {{ SPQR }}](./concepts/index.md#shard)         |
| [yandex_mdb_sharded_postgresql_user]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_user)         | Пользователь {{ SPQR }}                              |

