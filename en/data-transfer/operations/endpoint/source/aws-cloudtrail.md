# Configuring AWS CloudTrail source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to AWS. For more information, see the [Airbyte® documentation](https://docs.airbyte.com/integrations/sources/aws-cloudtrail).

## {#settings} settings

{% list tabs %}

- Management console

   * **Key ID** and **Secret Key**: Specify the [ID and contents of the AWS key](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).
   * **Region Name**: Enter the AWS [region](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-installing-specifying-region.html) name.
   * **Start date**: Date in `YYYY-MM-DD` format. Log entries for this and future dates will be transferred to the target. If no value is specified, log entries are copied for the maximum period of 90 days.

{% endlist %}

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}
