---
title: '{{ TF }} reference for {{ mspqr-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources supported for {{ mspqr-name }}.
---

# {{ TF }} reference for {{ mspqr-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mspqr-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource**                                                                                        | **{{ yandex-cloud }} resource**                        |
|------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [yandex_mdb_sharded_postgresql_cluster]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster)   | [{{ SPQR }}](./operations/cluster-create.md) cluster |
| [yandex_mdb_sharded_postgresql_database]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_database) | [{{ SPQR }} database](operations/connect.md)      |
| [yandex_mdb_sharded_postgresql_shard]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_shard)       | [{{ SPQR }} shard](./concepts/index.md#shard)         |
| [yandex_mdb_sharded_postgresql_user]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_user)         | {{ SPQR }} user                              |

