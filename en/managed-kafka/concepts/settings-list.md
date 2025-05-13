# Apache Kafka® settings

For {{ mkf-name }} clusters, you can configure {{ KF }} settings. Some settings are configured at the [cluster level](#cluster-settings), while others, at the [topic level](#topic-settings).

The label next to the setting name shows which interface can be used to configure this setting: the management console, CLI, API, or {{ TF }}. The {{ tag-all }} label means that all of the above interfaces are supported.

Depending on the selected interface, the same setting will be represented differently. For example, **Compression type** in the management console is the same as:

* `--compression-type` in the CLI
* `compression_type` in the gRPC API and {{ TF }}
* `compressionType` in the REST API

## Cluster-level settings {#cluster-settings}

The following settings are available:

{% include [kafka-settings](../../_includes/mdb/mkf/kafka-settings.md) %}

## Settings for individual topics {#topic-settings}

The following settings are available:

{% include [topic-settings](../../_includes/mdb/mkf/topic-settings.md) %}