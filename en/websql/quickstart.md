# Getting started with {{ websql-full-name }}

{% include notitle [preview](../_includes/note-preview.md) %}

In this section, you will learn how to connect to clusters of managed databases using {{ websql-full-name }}.

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or [create an account](https://yandex.com/support/id/authorization/registration.html) if you do not have one yet.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account, [create one](../billing/quickstart/index.md).
1. Select the organization to work with {{ websql-full-name }} in or [create a new one](../organization/operations/enable-org).

## Connecting to a database {#connect-to-db}

Create your first connection to the database.

{% include notitle [connect-db](../_includes/websql/connect-to-db.md) %}

If you have a [{{ PG }}](../managed-postgresql/operations/cluster-list.md), [{{ CH }}](../managed-clickhouse/operations/cluster-list.md), or [{{ MY }}](../managed-mysql/operations/cluster-list.md) cluster set up in {{ yandex-cloud }}, you can connect directly to it:

{% include notitle [connect-cluster](../_includes/websql/connect-to-cluster.md) %}

If the connection is successful, the structure of the cluster or database will show up in the connection manager tree. Hosts of the same cluster will appear in the _connection group_.

## What's next {#what-is-next}

* [Execute SQL queries](operations/query-executor.md)
* [Create query templates](operations/templates.md)
* [View query history](operations/history.md)

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}