---
title: Getting information about catalogs in a {{ mtr-name }} cluster
description: Follow this guide to get a list of catalogs in a {{ mtr-name }} cluster and detailed information about each of them.
---

# Getting information about catalogs in a {{ mtr-name }} cluster

## Getting a list of catalogs in a cluster {#list-catalogs}

{% list tabs group=instructions %}

- Management console {#console}

    1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click the cluster name.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of {{ TR }} catalogs in a {{ mtr-name }} cluster, run this command:

    ```bash
    {{ yc-mdb-tr }} catalog list \
        --cluster-id <cluster_ID>
    ```

    You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

    Result:

    ```bash
    +----------------------+---------+----------------+---------------+
    |          ID          |  NAME   | CONNECTOR TYPE |  DESCRIPTION  |
    +----------------------+---------+----------------+---------------+
    | c9qimrjgi9os******** | catalog |   postgresql   | Trino catalog |
    +----------------------+---------+----------------+---------------+
    ```

{% endlist %}

## Getting detailed information about a catalog {#get-catalog}

{% list tabs group=instructions %}

- Management console {#console}

    1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click the cluster name.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
    1. Click the {{ TR }} catalog name.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get detailed information about a {{ TR }} catalog, run this command:

    ```bash
    {{ yc-mdb-tr }} catalog get <{{ TR }}_catalog_name_or_ID> \
        --cluster-id <cluster_ID>
    ```

    You can get the {{ TR }} catalog ID and name together with the [list of {{ TR }} catalogs in the cluster](#list-catalogs.md).

    You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

    Result:

    ```yml
    id: c9qimrjgi9os********
    name: my-catalog
    connector:
      postgresql:
        connection:
          connection_manager:
            connection_id: a5968k5e1cpn********
            database: my-db
    ```

{% endlist %}