# Apache Kafka<sup>®</sup> settings

For {{ mkf-name }} clusters, you can configure settings that relate to {{ KF }}. Some of the settings are set [at the cluster level](#cluster-settings) and others [at the topic level](#topic-settings).

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, API, or Terraform. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented differently, for example, **Compression type** has the following counterparts in the management console:

* `--compression-type` in the CLI.
* `compression_type` in the gRPC API and Terraform.
* `compressionType` in the REST API.

## Cluster-level settings {#cluster-settings}

You can use the following settings:

{% include [kafka-settings](../../_includes/mdb/mkf/kafka-settings.md) %}

## Settings for individual topics {#topic-settings}

You can use the following settings:

{% include [topic-settings](../../_includes/mdb/mkf/topic-settings.md) %}

