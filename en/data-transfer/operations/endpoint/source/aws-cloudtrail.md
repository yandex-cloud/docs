# Transferring data from an AWS CloudTrail source endpoint

{{ data-transfer-full-name }} enables you to upload audit logs the AWS CloudTrail database to {{ yandex-cloud }} managed databases and implement various data processing and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the AWS CloudTrail database](#prepare) for the transfer.
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. In case of any issues, [use ready-made solutions](../../../../data-transfer/troubleshooting/index.md) to resolve them.

## Scenarios for transferring data from AWS CloudTrail {#scenarios}

You can upload logs to various databases for further storage in the cloud, processing and loading into data marts for further visualization.

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the AWS CloudTrail database {#prepare}

{% include [prepare aws cloud trail db](../../../../_includes/data-transfer/endpoints/sources/aws-cloudtrail-prepare.md) %}

## Configuring an AWS CloudTrail source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to AWS. For more information, see the [Airbyte® documentation](https://docs.airbyte.com/integrations/sources/aws-cloudtrail).

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_key_id.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_secret_key.title }}**: Specify the [AWS key ID and contents](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_region_name.title }}**: Enter the AWS [region](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-installing-specifying-region.html) name.
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.start_date.title }}**: Specify the date in `YYYY-MM-DD` format. Log entries for this and future dates will be transferred to the target. If no value is specified, log entries are copied for the maximum period of 90 days.

{% endlist %}

## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ MY }}](../target/mysql.md).
* [{{ MG }}](../target/mongodb.md).
* [{{ CH }}](../target/clickhouse.md).
* [{{ GP }}](../target/greenplum.md).
* [{{ ydb-full-name }}](../target/yandex-database.md).
* [{{ KF }}](../target/kafka.md).
* [{{ DS }}](../target/data-streams.md).
* [{{ PG }}](../target/postgresql.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

{% include [Internet access](../../../../_includes/data-transfer/notes/internet-access.md) %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}