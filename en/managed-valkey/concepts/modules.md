---
title: '{{ VLK }} modules'
description: 'In {{ mrd-name }}, you can use modules ({{ VLK }} kernel extensions). Modules provide functionality to address modern-day needs through the use of high-load services and AI platforms: vector search, efficiently stored JSON data structures, and scalable probability filters. Read this article to learn more about modules and their features.'
---

# {{ VLK }} modules

{{ mrd-name }} clusters support connecting modules that add more features to the {{ VLK }} kernel. The following modules are available:

* [Valkey-Search](#valkey-search)
* [Valkey-JSON](#valkey-json)
* [Valkey-Bloom](#valkey-bloom)

You can connect all or some of these modules when [creating](../operations/cluster-create.md) or [updating](../operations/modules.md) a cluster.

{% include [modules-warn](../../_includes/mdb/mvk/enable-modules-note.md) %}

## Valkey-Search {#valkey-search}

This module is a high-performance Vector Similarity Search engine optimized for AI solutions. The module ensures millisecond delays when handling requests and can process billions of vectors. The module uses the [HNSW](https://en.wikipedia.org/wiki/Hierarchical_navigable_small_world) and [KNN](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm) search algorithms. You can index data using the `Valkey Hash` or `Valkey-JSON` types and use indexed attributes for filtering.

You can use the module in personalized recommendation systems, for multimedia and semantic search, data anomaly search, and for development of chat bots and AI scenarios.

The module is linearly scalable to accommodate growing number of CPUs in the cluster.

A cluster with this module installed will have the following index commands available: `FT.CREATE`, `FT.DROPINDEX`, `FT.INFO`, `FT._LIST`, and `FT.SEARCH`.

For more information about the command syntax and the module itself, see [this official guide](https://valkey.io/topics/search/).

## Valkey-JSON {#valkey-json}

This module provides full-scale support for JSON structures in a {{ VLK }} cluster. Valkey-JSON complies with the [RFC7159](https://www.ietf.org/rfc/rfc7159.txt) specification for seamless operation with all standard JSON data types.

Module features:

* Storing, requesting, and modifying nested JSON objects.
* Support for `JSONPath` requests: selections based on filters, slices, wildcards, and recursive paths.
* Partial data updates without overwriting the whole object.
* Quick filtering and searching through the nested structure.
* Integration with ACL and support of permissions at the JSON command level.

Examples of commands available in a cluster with the Valkey-JSON module installed: `JSON.SET`, `JSON.GET`, `JSON.ARRINSERT`, `JSON.ARRLEN`. See the [full list of available commands](https://valkey.io/commands/#json).

For more information about the module, see [this official guide](https://valkey.io/topics/valkey-json/).

## Valkey-Bloom {#valkey-bloom}

This module implements a compact probabilistic data structure of the [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter). This data type is suitable for large-scale element membership checks (e.g., data stream deduplication or uniqueness check).

Advantages:

* During a membership check, only false positives are possible, false negatives are not.
* The module can operate both in fixed capacity mode and scalable mode.
* You can save over 90% of memory when processing big data streams compared to traditional set membership checks.

The module is compatible with {{ VLK }} client libraries and {{ RD }} equivalents. You can use it to prevent ad repetitions, detect fraud, filter spam, etc.

For more information about the module, see [this official guide](https://valkey.io/topics/bloomfilters/).
