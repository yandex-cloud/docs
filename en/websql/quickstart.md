# Getting started with {{ websql-full-name }}

You can connect to managed database clusters from clouds and folders that belong to your {{ yandex-cloud }} [organization](../organization/concepts/organization.md). If you [switch to a different organization](../organization/operations/manage-organizations.md#switch-to-another-org), you will have access to clusters from other clouds and folders. The connections you added will be available while you are in the current {{ yandex-cloud }} organization.

Once connected to a database, you will be able to view DB schemas, tables, and views, as well as run queries. It is a web-based tool that simplifies writing queries by suggesting prompts and commands.

{{ websql-full-name }} supports the following DB versions:

* {{ PG }}: 12 and higher
* {{ MY }}: 5 and higher
* {{ CH }}: 23 and higher
* {{ RD }}/{{ VLK }} (non-sharded clusters only): 6 and higher
* {{ SD }}: 6 and higher
* [{{ mtr-full-name }}](../managed-trino/) (currently at the [Preview](../overview/concepts/launch-stages.md) stage): 454 and higher
* {{ GP }}: 6 and higher

In this section, you will learn how to connect to:

* [Managed database clusters](#connect-cluster) within {{ yandex-cloud }}
* [Public databases](#connect-db) via the internet

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or [sign up](https://yandex.com/support/id/authorization/registration.html) if not signed up yet.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account, [create one](../billing/quickstart/index.md).
1. Select the organization to work with {{ websql-full-name }} in or [create a new one](../organization/operations/enable-org).

## How to connect to a managed database cluster within {{ yandex-cloud }} {#connect-cluster}

{% include notitle [connect-cluster](../_includes/websql/connect-to-cluster.md) %}

If the connection is successful, you will see the cluster structure in the connection tree. Connections to databases within a cluster are grouped into an expandable list under the name of that cluster.

## How to connect to a public database {#connect-db}

To connect to a public database via the internet:

{% include notitle [connect-db](../_includes/websql/connect-to-db.md) %}

If the connection is successful, you will see the database structure in the connection tree.

## What's next {#what-is-next}

* [Manage connections](operations/connect.md)
* [Run queries](operations/query-executor.md)
* [Create query templates](operations/templates.md)
* [View query history](operations/history.md)

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
