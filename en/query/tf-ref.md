---
title: '{{ TF }} reference for {{ yq-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources supported for {{ yq-name }}.
---

# {{ TF }} reference for {{ yq-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ yq-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_yq_ydb_connection]({{ tf-provider-resources-link }}/yq_ydb_connection) | [{{ ydb-name }} connection](./concepts/glossary.md#connection) |
| [yandex_yq_yds_connection]({{ tf-provider-resources-link }}/yq_yds_connection) | [{{ yds-name }} connection](./concepts/glossary.md#connection) |
| [yandex_yq_yds_binding]({{ tf-provider-resources-link }}/yq_yds_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a [{{ yds-name }} connection](./concepts/glossary.md#connection) |
| [yandex_yq_monitoring_connection]({{ tf-provider-resources-link }}/yq_monitoring_connection) | [{{ monitoring-full-name }} connection](./concepts/glossary.md#connection) |
| [yandex_yq_object_storage_connection]({{ tf-provider-resources-link }}/yq_object_storage_connection) | [{{ objstorage-name }} connection](./concepts/glossary.md#connection) |
| [yandex_yq_object_storage_binding]({{ tf-provider-resources-link }}/yq_object_storage_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a [{{ objstorage-name }} connection](./concepts/glossary.md#connection) |