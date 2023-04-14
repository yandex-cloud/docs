Make sure the data from the source has been moved to the {{ yds-name }} stream:

  {% list tabs %}

  * Management console

     1. In the [management console]({{ link-console-main }}), select **{{ yds-name }}**.
     1. Select the target stream from the list and go to ![image](../../_assets/data-introspection.svg) **Data viewer**.
     1. Make sure `shard-000000` contains messages with the source table rows. To view message details, click ![image](../../_assets/eye.svg).

  * AWS

     1. [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
     1. [Configure the environment](../../data-streams/quickstart/index.md) for {{ yds-name }}.
     1. Read the stream data using:

        * [AWS CLI](../../data-streams/operations/aws-cli/get-records.md).
        * [AWS SDK](../../data-streams/operations/aws-sdk/get-records.md).

  {% endlist %}
