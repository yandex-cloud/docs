---
title: "How to configure an {{ KF }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up an {{ KF }} source endpoint in {{ data-transfer-full-name }}."
---

# Transferring data from an {{ KF }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from an {{ KF }} queue and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ KF }}](#prepare) database for the transfer.
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](../../../../data-transfer/troubleshooting/index.md) to resolve them.

## Scenarios for transferring data from {{ KF }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

   Mirroring data across queues is a separate migration task.

   * [{{ KF }} mirroring](../../../tutorials/mkf-to-mkf.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}

   * [{{ KF }} to {{ CH }}](../../../tutorials/mkf-to-mch.md).
   * [{{ KF }} to {{ PG }}](../../../tutorials/mkf-to-mpg.md).
   * [{{ KF }} to {{ GP }}](../../../tutorials/managed-kafka-to-greenplum.md).
   * [{{ KF }} to {{ ES }}](../../../tutorials/mkf-to-mes.md).
   * [{{ KF }} to {{ MG }}](../../../tutorials/mkf-to-mmg.md).
   * [{{ KF }} to {{ MY }}](../../../tutorials/mkf-to-mmy.md).
   * [{{ KF }} to {{ OS }}](../../../tutorials/mkf-to-mos.md).
   * [{{ KF }} to {{ ydb-short-name }}](../../../tutorials/mkf-to-ydb.md).
   * [{{ KF }} to {{ DS }}](../../../tutorials/mkf-to-yds.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/kafka.md) %}

## Configuring the {{ KF }} source endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mkf-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional settings](#additional-settings).

### {{ mkf-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mkf.viewer }}` role](../../../../managed-kafka/security/index.md#mkf-viewer) or the [`viewer` primitive role](../../../../iam/concepts/access-control/roles.md#viewer) assigned to the folder where this managed database cluster resides.

{% endnote %}


Connection with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connection with the {{ KF }} cluster with explicitly specified network addresses and broker host ports.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka.md) %}

{% endlist %}

### Advanced settings {#additional-settings}


{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}


{% list tabs group=instructions %}

- Management console {#console}

   
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.transformer.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.cloud_function.title }}**: Select one of the functions created in {{ sf-name }}.

         
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.service_account_id.title }}**: Select or [create](../../../../iam/operations/sa/create.md) a service account that the processing function will start under.


      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.number_of_retries.title }}**: Set the number of attempts to invoke the processing function.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_size.title }}**: Set the size of the buffer (in bytes) which when full data will be transferred to the processing function.

         The maximum buffer size is 3.5 MB. For more information about restrictions that apply when working with functions in {{ sf-name }}, see the [corresponding section](../../../../functions/concepts/limits.md).

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}**: Set the duration of the interval (in seconds) after the expiration of which the data from the stream should be transferred to the processing function.

         {% note info %}

         If the buffer becomes full or the sending interval expires, the data is transferred to the processing function.

         {% endnote %}

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}**: Set the allowed timeout of the response from the processing function (in seconds).

      {% note warning %}

      Values in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** fields are specified with the `s` postfix, for example, `10s`.

      {% endnote %}


   * {% include [conversion-rules](../../../../_includes/data-transfer/fields/yds/ui/conversion-rules.md) %}

{% endlist %}

## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ PG }}](../target/postgresql.md).
* [{{ MY }}](../target/mysql.md).
* [{{ MG }}](../target/mongodb.md)
* [{{ CH }}](../target/clickhouse.md).
* [{{ GP }}](../target/greenplum.md).
* [{{ ydb-full-name }}](../target/yandex-database.md).
* [{{ objstorage-full-name }}](../target/object-storage.md).
* [{{ KF }}](../target/kafka.md).
* [{{ DS }}](../target/data-streams.md).
* [{{ ES }}](../target/elasticsearch.md).
* [{{ OS }}](../target/opensearch.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).