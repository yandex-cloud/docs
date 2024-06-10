# Getting started with {{ websql-full-name }}

{% include notitle [preview](../_includes/note-preview.md) %}

{{ websql-full-name }} is a {{ yandex-cloud }} service that allows you to connect to clusters of managed and public databases. You can view database tables and schemas, and run SQL queries. It is a web-based tool that simplifies writing SQL queries by suggesting prompts and commands.

In this section, you will learn how to connect to:

* [Managed database clusters](#connect-cluster) within {{ yandex-cloud }}
* [Public databases](#connect-db) via the internet

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or [sign up](https://yandex.com/support/id/authorization/registration.html) if not signed up yet.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account, [create one](../billing/quickstart/index.md).
1. Select the organization to work with {{ websql-full-name }} in or [create a new one](../organization/operations/enable-org).

## Connecting to a managed database cluster within {{ yandex-cloud }} {#connect-cluster}

{% include [clickhouse-warning](../_includes/websql/clickhouse-warning.md) %}

{% include notitle [connect-cluster](../_includes/websql/connect-to-cluster.md) %}

If the connection is successful, you will see the cluster structure in the connection manager tree. Hosts of the same cluster will appear in the _connection group_.

## Connecting to a public database {#connect-db}

To connect to a public database via the internet:

{% include notitle [connect-db](../_includes/websql/connect-to-db.md) %}

If the connection is successful, you will see the database structure in the connection manager tree.

## What's next {#what-is-next}

* [Execute SQL queries](operations/query-executor.md)
* [Create query templates](operations/templates.md)
* [View query history](operations/history.md)

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}