# Managing {{ ES }} plugins

When creating or updating a cluster in {{ mes-short-name }}, you can specify the desired list of plugins, and they will be automatically installed in the cluster. A full list of available plugins is [given below](#elasticsearch).

## Getting a list of installed plugins {#list}

{% list tabs %}

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of cluster plugins, run the command:

    ```bash
    {{ yc-mdb-es }} cluster get <cluster ID or name>
    ```

    The enabled plugins will be listed in the `plugins` list.

    You can get the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

* API

    Use the [list](../api-ref/Extension/list.md) API method and pass the cluster ID in the `clusterId` parameter in the request.

    You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Editing the list of installed plugins {#update}

{% list tabs %}

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the cluster plugins, pass their list in the `--plugins` parameter of the CLI command. In this case, plugins that are not included in the list will be disabled.

    ```bash
    {{ yc-mdb-es }} cluster update <cluster name or ID> \
       --plugins=<name of plugin 1>,...,<name of plugin N>
    ```

    You can get the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

* Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mes-name }} cluster description, in the `config` section, add the `plugins` field listing the plugins:

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

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mes }}).

    {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

* API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    * Plugin list in the `configSpec.elasticsearchSpec.plugins` parameter. The plugins omitted in the list will be disabled.
    * The list of cluster configuration fields to be edited (`configSpec.elasticsearchSpec.plugins` in this case) in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

## Supported {{ ES }} plugins {#elasticsearch}

All supported plugins are listed here:

* [analysis-icu](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-icu.html)

    It integrates the Lucene ICU module offering extended Unicode support using ICU libraries. The module enables better analysis of Asian languages, Unicode normalization, Unicode-aware case folding, collation support, and transliteration.

* [analysis-kuromoji](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-kuromoji.html)

    It integrates the Lucene kuromoji analysis module for the Japanese language.

* [analysis-nori](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-nori.html)

    It integrates the Lucene nori analysis module for the Korean language.

* [analysis-phonetic](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-phonetic.html)

    It provides lexeme filters that convert expressions into their phonetic representation using Soundex, Metaphone, and other algorithms.

* [analysis-smartcn](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-smartcn.html)

    It integrates the Lucene's Smart Chinese analysis module for the Chinese or mixed Chinese-English text.

* [analysis-stempel](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-stempel.html)

    It integrates the Lucene's Stempel module for Polish language analysis.

* [analysis-ukrainian](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-ukrainian.html)

    It integrates the Lucene's UkrainianMorfologikAnalyzer module to enable morphological analysis for the Ukrainian language.

* [ingest-attachment](https://www.elastic.co/guide/en/elasticsearch/plugins/current/ingest-attachment.html)

    It extracts file attachments in common formats (such as PPT, XLS, or PDF) using the Apache Tika Text Extraction library.

* [mapper-annotated-text](https://www.elastic.co/guide/en/elasticsearch/plugins/current/mapper-annotated-text.html)

    It indexes text that combines plain text and special markup. Such combinations are used to identify objects, for example, humans or organizations.

* [mapper-murmur3](https://www.elastic.co/guide/en/elasticsearch/plugins/current/mapper-murmur3.html)

    It calculates hashes from field values using the index time and saves them to the index.

* [mapper-size](https://www.elastic.co/guide/en/elasticsearch/plugins/current/mapper-size.html)

    It provides the `_size` metadata field that indexes the size in bytes for the source field (`_source`).

* [repository-azure](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-azure.html)

    Adds support for Azure Blob storage as a snapshot repository.

* [repository-gcs](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-gcs.html)

    Adds support for Google Cloud Storage as a snapshot repository.

* [repository-hdfs](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-hdfs.html)

    Adds support for the HDFS file system as a snapshot repository.

* [repository-s3](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-s3.html)

    Adds support for AWS S3 as a snapshot repository.

* [store-smb](https://www.elastic.co/guide/en/elasticsearch/plugins/current/store-smb.html)

    Fixes errors in Windows SMB and Java on Windows.

* transport-nio

    A server-client non-blocking network library created with Netty.

For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/plugins/current/index.html).

