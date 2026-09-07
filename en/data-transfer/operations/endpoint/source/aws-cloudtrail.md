---
title: Transferring data from an AWS CloudTrail endpoint
description: In this tutorial, you will learn how to set up data transfer from an AWS CloudTrail endpoint.
---

# Transferring data from an AWS CloudTrail endpoint

{{ data-transfer-full-name }} enables you to export audit logs from AWS CloudTrail to {{ yandex-cloud }} managed databases and implement various data processing and transformation scenarios. To set up a transfer:

1. [Review the available data transfer scenarios](#scenarios).
1. [Prepare your AWS CloudTrail database](#prepare) for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. If you run into any problems, [check the available solutions](../../../../data-transfer/troubleshooting/index.md) for troubleshooting.

## AWS CloudTrail transfer scenarios {#scenarios}

You can export logs to various databases for cloud storage, processing, and further loading into data marts for visualization.

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the AWS CloudTrail database {#prepare}

{% include [prepare aws cloud trail db](../../../../_includes/data-transfer/endpoints/sources/aws-cloudtrail-prepare.md) %}

## Configuring an AWS CloudTrail source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, make sure to configure AWS access. For more information, see [this {{ AB }} guide](https://docs.airbyte.com/integrations/sources/aws-cloudtrail).

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_key_id.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_secret_key.title }}**: Specify the [AWS key ID and secret key](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_region_name.title }}**: Specify the AWS [region](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-installing-specifying-region.html).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.start_date.title }}**: Specify the date in `YYYY-MM-DD` format. Log entries from this date onward will be transferred to the target. If left blank, the system will copy log entries for the maximum period of 90 days.

{% endlist %}

## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ MY }}](../target/mysql.md)
* [{{ MG }}](../target/mongodb.md)
* [{{ CH }}](../target/clickhouse.md)
* [{{ GP }}](../target/greenplum.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)
* [{{ KF }}](../target/kafka.md)
* [{{ DS }}](../target/data-streams.md)
* [{{ PG }}](../target/postgresql.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

{% include [Internet access](../../../../_includes/data-transfer/notes/internet-access.md) %}

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}
