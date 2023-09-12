# Cloud Logging consumption started showing up in your billing account itemization

## Issue description {#issue-description}

You started seeing Cloud Logging in your Yandex Cloud itemization. However, you didn't create any log groups explicitly.

## Solution {#issue-resolution}
Starting from November 1, 2022, Cloud Logging charges you for the amount of data written and its storage time. Logs for Cloud Functions, API Gateway, and Serverless Containers are automatically written to the log group created for each folder by default.

{% note info %}

The default log group is created automatically, even if you delete it manually. You can't disable or delete it.

{% endnote %}

If you don't need to keep logs for Cloud Functions, API Gateway, and Serverless Containers in your cloud, you can set a [minimum record storage period of 1 hour](../../../logging/operations/retention-period.md).

For this, run the following command using YC CLI:

```
yc logging group update --name=<group name> --retention-period=1h
```
Install and configure the AWS CLI using this [guide](../../../cli/quickstart.md).

You can view Cloud Logging pricing plans on this [page](../../../logging/pricing.md).