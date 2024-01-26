# Configuring AWS CloudTrail source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to AWS. For more information, see the [Airbyte® documentation](https://docs.airbyte.com/integrations/sources/aws-cloudtrail).

## Settings {#settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_key_id.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_secret_key.title }}**: Specify the [AWS key ID and contents](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.aws_region_name.title }}**: Enter the AWS [region](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-installing-specifying-region.html) name.
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.aws_cloud_trail_source.endpoint.airbyte.aws_cloud_trail_source.AWSCloudTrailSource.start_date.title }}**: Specify the date in `YYYY-MM-DD` format. Log entries for this and future dates will be transferred to the target. If no value is specified, log entries are copied for the maximum period of 90 days.

{% endlist %}

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}
