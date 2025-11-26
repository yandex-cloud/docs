# Indexes in {{ OS }}

When saving a document to {{ OS }}, it is indexed and placed in a user-specified _index_, making it available for search and analysis. One may think of an index as a data table in a traditional DBMS.

In {{ OS }}, a document is a set of fields where each field is a `key: value` pair. The index stores optimized documents to enable quickly searching documents by field. Such optimization is achieved with each document field having a specific type. This is how the field data is effectively stored in the index. For more information about this type of optimization, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/mappings/).

Unlike a traditional DBMS, to save the document in the index, {{ OS }} does not require the explicit specification of the schema, i.e., links between document fields and their types. Even though it is the recommended approach, you can save documents to the index without explicitly specifying the field types; {{ OS }} will try to determine the type automatically for each field in the document. As a result, you can quickly add documents to {{ OS }} storage and start working with them.

To learn more about how indexes work, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/index-data/).

In multihost clusters, index [sharding and replication](scalability-and-resilience.md) are supported. This makes it easier to scale a cluster and ensures its high availability.

## Index codecs {#codecs}

Index _codecs_ determine how index fields are compressed and stored on disk. For the list of supported codecs for {{ OS }}, see [this {{ OS }} guide]({{ os.docs }}/im-plugin/index-codecs/#supported-codecs).

For {{ mos-name }} clusters, the lzma codec is additionally available, recommended for archive data accessed very rarely.

For all codecs, a compression level from `1` to `6` (inclusive) can be set. Higher levels yield higher compression ratios (smaller file size) at the expense of slower compression and decompression speed. The default compression level is `3`.

### Comparing codecs {#codec-comparison}

The following codecs (with compression levels in parentheses) were selected for a comparison:

* lz4(3)
* zlib(3)
* zstd(5)
* lzma(1)
* lzma(5)

#### Test environment {#test-environment}

We tested a {{ mos-name }} cluster in {{ yandex-cloud }}. The measurements were performed in the following environment:

* {{ mos-name }} cluster configuration:

    * Number of hosts: `1`
    * Host class: `s2.micro`
    * Disk type: `network-ssd`
    * Disk size: `10` GB

* The test tool ([OpenSearch Benchmark]({{ os.docs }}/benchmark/)) settings:

    * Profile: `http_logs`
    * Number of clients: `8`
    * Batch size: `5000` documents

* Configuration of the [VM](../../compute/concepts/vm.md) used to run OpenSearch Benchmark:

    * OS: `Ubuntu 24.04 LTS`
    * vCPU: `8`
    * RAM: `16` GB
    * Disk space: `55` GB

#### Test results {#test-results}

Results of measurements:

| Criterion                                   | lz4(3) | zlib(3) | zstd(5) | lzma(1) | lzma(5) |
|--------------------------------------------|:------:|:-------:|:-------:|:-------:|:-------:|
| Disk space (GB)                        | 17.5   | 13.4    | 13.3    | 12.6    | 12.5    |
| Indexing rate (documents per second) | 81,083  | 96,835   | 97,487   | 97,873   | 89,375   |
| match-all (median time, ms)            | 4.7    | 5.6     | 5.7     | 7.4     | 7.5     |
| term (median time, ms)                 | 17.0   | 17.7    | 18.9    | 45.1    | 43.4    |
| scroll (median time, ms)               | 302.9  | 509.8   | 416.4   | 794.6   | 740.9   |
| hourly_agg (median time, ms)           | 50.6   | 53.3    | 47.1    | 47.4    | 59.5    |
| multi_term_agg (median time, ms)       | 2,730.8 | 2,772.8  | 2,681.1  | 2,901.8  | 2,923.5  |

Variation of results vs. the default lz4 codec:

| Criterion                                    | zlib(3) | zstd(5) | lzma(1) | lzma(5) |
|---------------------------------------------|:-------:|:-------:|:-------:|:-------:|
| Disk space used (less = better)      | -23%    | -24%    | -28%    | -29%    |
| Indexing rate (more = better) | +20%    | +21%    | +21%    | +11%    |
| match-all (less = better)           | +19%    | +20%    | +57%    | +60%    |
| term (less = better)                | +4%     | +11%    | +165%   | +155%   |
| scroll (less = better)              | +68%    | +38%    | +162%   | +145%   |
| hourly_agg (less = better)          | +5%     | -7%     | -6%     | +18%    |
| multi_term_agg (less = better)      | +2%     | -2%     | +6%     | +7%     |

### Changing your codec {#codec-change}

To change the data compression method, you can specify an action to change the codec in the [index policy](index-policy.md). You can do this via an API request or in the [OpenSearch Dashboards](../quickstart.md#dashboards-connect) UI.

Example of the action in an API request:

```json
{
  "repack":{
    "new_codec": "<codec_name>"
  }
}
```

Where `new_codec` is the new codec for the index. For its value use any [codec supported by {{ OS }}]({{ os.docs }}/im-plugin/index-codecs/#supported-codecs) or the `lzma` codec.

The action will briefly close the index to apply the new codec setting. Once the codec is updated, the index will be reopened, and existing data re-compressed with the new codec.

## Use cases {#examples}

* [{#T}](../tutorials/migration-from-mkf.md)
* [{#T}](../tutorials/migration-from-standalone.md)
* [{#T}](../tutorials/migration-to-opensearch.md)
* [{#T}](../tutorials/opensearch-index-policy.md)
* [{#T}](../tutorials/opensearch-to-clickhouse.md)
* [{#T}](../tutorials/opensearch-yandex-lemmer.md)
