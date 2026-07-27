---
title: '{{ monium-name }} object configuration'
description: To logically separate telemetry data, {{ monium-name }} uses various configuration objects, such as a project, cluster, service, and shard.
---

# {{ monium-name }} object configuration

To logically separate telemetry data, {{ monium-name }} uses configuration objects: project, cluster, service, and shard.

{% include [config-model](../../_mermaid/other/monium/config-model.md) %}

{% include [configuration-model](../../_includes/monium/configuration-model.md) %}

## Data model mapping {#relation-to-data-model}

Configuration objects map to the required telemetry attributes in the [data model](data-model.md):

* `project`
* `cluster`
* `service`

These attributes are included in every query in the [query language](querying.md) and help narrow down the search scope. The more precisely the project, cluster, and service are specified, the faster the query runs.

#### See also {#see-also}

* [{#T}](data-model.md)
* [{#T}](querying.md)
* [{#T}](visualization/query-string.md)
