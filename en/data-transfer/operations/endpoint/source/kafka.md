---
title: How to set up a {{ KF }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to create and configure an {{ KF }} source endpoint in {{ data-transfer-full-name }}.
alternate:
  - href: en/data-transfer/operations/endpoint/source/kafka.md
    type: text/markdown
    title: Markdown version
---

# Transferring data from a {{ KF }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from an {{ KF }} queue and implement various data transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Prepare the {{ KF }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. Perform the required database tasks while [monitoring the transfer status](../../monitoring.md).
1. If you run into any problems, [check the available solutions](../../../../data-transfer/troubleshooting/index.md) for troubleshooting.

## {{ KF }} data transfer scenarios {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

   Mirroring data across queues is a separate migration task.

    * [{{ KF }}](../../../tutorials/mkf-to-mkf.md) mirroring.

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}

    * [{{ KF }} to {{ CH }}](../../../tutorials/mkf-to-mch.md).
    * [{{ KF }} to {{ PG }}](../../../tutorials/mkf-to-mpg.md).
    * [{{ KF }} to {{ GP }}](../../../tutorials/managed-kafka-to-greenplum.md).
    * [{{ KF }} to {{ MG }}](../../../tutorials/mkf-to-mmg.md).
    * [{{ KF }} to {{ MY }}](../../../tutorials/mkf-to-mmy.md).
    * [{{ KF }} to {{ OS }}](../../../tutorials/mkf-to-mos.md).
    * [{{ KF }} to {{ ydb-short-name }}](../../../tutorials/mkf-to-ydb.md).

    
    * [{{ KF }} in {{ DS }}](../../../tutorials/mkf-to-yds.md).



For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/kafka.md) %}

## Configuring the {{ KF }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can configure:

* Connection settings for a [{{ mkf-full-name }} cluster](#managed-service) or a [custom deployment](#on-premise), including those running on {{ compute-full-name }} VMs. These settings are required.
* [Advanced settings](#additional-settings).

### {{ mkf-name }} cluster {#managed-service}


{% note warning %}

To create or edit a managed database endpoint, you will need the [`{{ roles.mkf.viewer }}`](../../../../managed-kafka/security/index.md#managed-kafka-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder where its cluster resides.

{% endnote %}


Connection with the cluster specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `kafka_source`.

    {% include [Managed Kafka Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-kafka-source.md) %}

    Configuration file structure example:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        kafka_source {
          security_groups = ["<list_of_security_group_IDs>"]
          connection {
            cluster_id = "<cluster_ID>"
          }
          auth {
            <authentication_method>
          }
          topic_names = ["<topic_name_list>"]
          <endpoint_advanced_settings>
        }
      }
    }
    ```


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed Kafka API](../../../../_includes/data-transfer/necessary-settings/api/managed-kafka-source.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connection to the {{ KF }} cluster with explicitly specified network addresses and broker host ports.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `kafka_source`.

    {% include [On-premise Kafka Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-kafka-source.md) %}

    Configuration file structure example:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        kafka_source {
          security_groups = ["<list_of_security_group_IDs>"]
          connection {
            on_premise {
              broker_urls = ["<list_of_IP_addresses_or_broker_host_FQDNs>"]
              subnet_id  = "<ID_of_subnet_with_broker_hosts>"
            }
          }
          auth = {
            <authentication_method>
          }
          topic_names = ["<topic_name_list>"]
          <endpoint_advanced_settings>
        }
      }
    }
    ```


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On-premise Kafka API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-kafka-source.md) %}

{% endlist %}

### Advanced settings {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.transformer.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.cloud_function.title }}**: Select one of the functions created in {{ sf-name }}.

        
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.service_account_id.title }}**: Select or [create](../../../../iam/operations/sa/create.md) a service account you are going to use to start the processing function.


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.number_of_retries.title }}**: Set the number of attempts to invoke the processing function.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_size.title }}**: Set the size of the buffer (in bytes) which when full data will be transferred to the processing function.

            The maximum buffer size is 3.5 MB. For more information about restrictions that apply to functions in {{ sf-name }}, see the [relevant section](../../../../functions/concepts/limits.md).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}**: Set the interval (in seconds) to wait before transferring stream data to the processing function.

            {% note info %}

            If the buffer is full or the sending interval expires, data will be transferred to the processing function.

            {% endnote %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}**: Set the allowed timeout of the response from the processing function (in seconds).

        {% note warning %}

        Values in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** fields are specified with the `s` postfix, e.g., `10s`.

        {% endnote %}
    

    * {% include [conversion-rules](../../../../_includes/data-transfer/fields/yds/ui/conversion-rules.md) %}

- {{ TF }} {#tf}

    
    * {% include [transformers](../../../../_includes/data-transfer/fields/transformers-and-parsers/terraform/transformers.md) %}


    * {% include [parsers](../../../../_includes/data-transfer/fields/transformers-and-parsers/terraform/parsers.md) %}

- API {#api}

    
    * {% include [transformers](../../../../_includes/data-transfer/fields/transformers-and-parsers/api/transformers.md) %}


    * {% include [parsers](../../../../_includes/data-transfer/fields/transformers-and-parsers/api/parsers.md) %}

{% endlist %}

## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ PG }}](../target/postgresql.md)
* [{{ MY }}](../target/mysql.md)
* [{{ MG }}](../target/mongodb.md)
* [{{ CH }}](../target/clickhouse.md)
* [{{ GP }}](../target/greenplum.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)
* [{{ objstorage-full-name }}](../target/object-storage.md)
* [{{ KF }}](../target/kafka.md)
* [{{ DS }}](../target/data-streams.md)
* [{{ ytsaurus-name }}](../source/yt.md)
* [{{ OS }}](../target/opensearch.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).
