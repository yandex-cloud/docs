Make sure the data from the source has been moved to the {{ yds-name }} stream:

  {% list tabs group=instructions %}

  - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
      1. Select the target stream from the list and go to ![image](../../_assets/console-icons/bars.svg) **{{ ui-key.yacloud.data-streams.label_data-introspection }}**.
      1. Make sure `shard-000000` contains messages with the source table rows. To view message details, click ![image](../../_assets/console-icons/eye.svg).

  - AWS CLI {#cli}

      1. [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
      1. [Configure the environment](../../data-streams/quickstart/index.md) for {{ yds-name }}.
      1. Read the stream data using:

          * [AWS CLI](../../data-streams/operations/aws-cli/get-records.md).
          * [AWS SDK](../../data-streams/operations/aws-sdk/get-records.md).

  {% endlist %}
