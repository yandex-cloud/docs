---
title: "How to manage {{ ES }} plugins"
description: "This guide describes how you can manage {{ ES }} plugins."
---

# Managing {{ ES }} plugins

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

When creating or updating a cluster in {{ mes-short-name }}, you can specify a list of necessary plugins and they will be installed in the cluster automatically. A full list of available plugins is [given below](#elasticsearch).

## Retrieving a list of installed plugins {#list}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster plugins, run the following command:

   ```bash
   {{ yc-mdb-es }} cluster get <cluster ID or name>
   ```

   Enabled plugins will be shown in the `plugins` list.

   You can get the cluster ID and name [with a list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of installed plugins, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   Enabled plugins will be shown in the `plugins` list.

   {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Editing a list of installed plugins {#update}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit cluster plugins, pass the plugin list in the CLI `--plugins` parameter. Plugins that are not included in the list will be disabled.

   ```bash
   {{ yc-mdb-es }} cluster update <cluster ID or name> \
      --plugins=<plugin 1 name>,...,<plugin N name>
   ```

   You can get the cluster ID and name [with a list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mes-name }} cluster description, add the `plugins` field with a list of plugins to the `config` block:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        config {
          ...
          plugins = [ "<list of plugin names>" ]
          ...
        }
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

- API

   To update the list of installed plugins, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * List of plugins in the `configSpec.elasticsearchSpec.plugins` parameter. Plugins that are not included in the list will be disabled.
   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Supported {{ ES }} plugins {#elasticsearch}

All supported plugins are listed here:

* [analysis-icu](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-icu.html)

   Adds the Lucene ICU module with extended Unicode support using the ICU libraries. It enables better analysis of Asian languages, Unicode normalization, Unicode-aware case folding, collation support, and transliteration.

* [analysis-kuromoji](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-kuromoji.html)

   Adds the Lucene kuromoji analysis module for Japanese.

* [analysis-nori](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-nori.html)

   Adds the Lucene nori analysis module for Korean.

* [analysis-phonetic](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-phonetic.html)

   Provides lexeme filters that convert expressions to their phonetic representation using Soundex, Metaphone, and other algorithms.

* [analysis-smartcn](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-smartcn.html)

   Adds the Lucene's Smart Chinese analysis module for Chinese or mixed Chinese-English text.

* [analysis-stempel](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-stempel.html)

   Adds the Lucene's Stempel analysis module for Polish.

* [analysis-ukrainian](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-ukrainian.html)

   Adds the Lucene's UkrainianMorfologikAnalyzer analysis module providing stemming for Ukrainian.

* [ingest-attachment](https://www.elastic.co/guide/en/elasticsearch/plugins/current/ingest-attachment.html)

   Extracts file attachments in common formats (such as PPT, XLS, and PDF) using the Apache text extraction library Tika™.

* [mapper-annotated-text](https://www.elastic.co/guide/en/elasticsearch/plugins/current/mapper-annotated-text.html)

   Indexes text that is a combination of free-text and special markup. Such combinations are typically used to identify items of interest such as people or organizations.

* [mapper-murmur3](https://www.elastic.co/guide/en/elasticsearch/plugins/current/mapper-murmur3.html)

   Computes hashes of field values at index-time and stores them in the index.

* [mapper-size](https://www.elastic.co/guide/en/elasticsearch/plugins/current/mapper-size.html)

   Provides the `_size` metadata field, which indexes the size in bytes of the original `_source` field.

* [repository-azure](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-azure.html)

   Adds support for Azure Blob storage as a repository for snapshots.

* [repository-gcs](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-gcs.html)

   Adds support for Google Cloud Storage as a repository for snapshots.

* [repository-hdfs](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-hdfs.html)

   Adds support for the HDFS file system as a repository for snapshots.

* [repository-s3](https://www.elastic.co/guide/en/elasticsearch/reference/current/repository-s3.html)

   Adds support for AWS S3 as a repository for snapshots.

* [store-smb](https://www.elastic.co/guide/en/elasticsearch/plugins/current/store-smb.html)

   Fixes bugs in Windows SMB and Java on Windows.

* transport-nio

   Server/client non-blocking networking library built with Netty.

For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/plugins/current/index.html).
