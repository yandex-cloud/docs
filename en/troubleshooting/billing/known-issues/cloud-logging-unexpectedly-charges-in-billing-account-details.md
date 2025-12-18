# My billing account usage details show {{ cloud-logging-name }} consumption


## Issue description {#issue-description}

The {{ yandex-cloud }} usage details include {{ cloud-logging-name }}, although you have not created any log groups explicitly.

## Solution {#issue-resolution}

Starting November 1, 2022, {{ cloud-logging-name }} charges you for the amount of written data and its storage time. Logs for {{ sf-name }}, {{ api-gw-full-name }}, and {{ serverless-containers-name }} are automatically written to the log group created for each folder by default.

{% note info %}

The default log group is created automatically, even if you delete it manually. You cannot disable or delete it.

{% endnote %}

If you do not need to keep logs for {{ sf-name }}, {{ api-gw-full-name }}, and {{ serverless-containers-name }} in your cloud, you can set a [minimum record retention period to one hour](../../../logging/operations/retention-period.md).

To do this, run this YC CLI command:

```
yc logging group update --name=<group name> --retention-period=1h
```
Install and configure the CLI using [this guide](../../../cli/quickstart.md).

Check the {{ cloud-logging-name }} pricing on [this page](../../../logging/pricing.md).