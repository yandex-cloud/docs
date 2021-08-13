---
title: Viewing Elasticsearch cluster Logs
description: 'Managed Service for Elasticsearch allows you to retrieve cluster logs for viewing and exploring.'
keywords:
  - Elasticsearch logs
  - Elasticsearch cluster logs
  - Elasticsearch
---

# Viewing cluster logs

{{ mes-name }} allows you to get cluster logs for viewing and analysis.

You can get:

* [A simple log snippet](#get-log).
* [Log stream](#get-log-stream) from the server in the cluster (`tail -f` command semantics are supported).

## Getting a cluster log {#get-log}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mes-name }}**.
  1. Click on the name of the cluster and select the **Logs** tab.
  1. Specify the time period for which you want to display logs: enter it manually or select it in the calendar by clicking on the date field.
  1. Select the `ELASTICSEARCH` component from the drop-down list next to the date field.

  A list of log entries for the selected time period will be displayed.
  To view detailed information about the event associated with a record, click on the record in the log.

  If there are too many records and only some of them are displayed, click the **Load more** link at the end of the list.

{% if audience != "draft" %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    1. View a description of the CLI command to view cluster logs:

    ```bash
    {{ yc-mdb-es }} cluster list-logs --help
    ```
    1. Run the command to get cluster logs (the example does not contain a complete list of parameters):

    ```bash
    {{ yc-mdb-es }} cluster list-logs <cluster ID or name> \
       --limit <record number limit> \
       --columns <list of columns to display information> \
       --filter <record filter settings> \
       --since <left boundary of time range> \
       --until <right boundary of time range>
    ```

    You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endif %}

- API

  Use the `listLogs` API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting a cluster log stream {#get-log-stream}

This way of working with logs is different from [getting a simple log snippet](#get-log) by the fact that the server can send more logs as they appear. This behavior is the same as the semantics of the `tail -f` command for working with logs.

{% list tabs %}

{% if audience != "draft" %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view cluster logs as they become available, run the command:

    ```bash
    {{ yc-mdb-es }} cluster list-logs <cluster ID or name> --follow
    ```

    You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endif %}

- API

  Use the `streamLogs` API method: pass the ID of the required cluster in the `clusterId` request parameter.

{% endlist %}

