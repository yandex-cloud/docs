---
title: Deleting a {{ TR }} catalog
description: Follow this guide to delete a catalog from a {{ mtr-name }} cluster.
---

# Deleting a {{ TR }} catalog

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. Next to the {{ TR }} catalog, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete the {{ TR }} catalog, run this command:

    ```bash
    {{ yc-mdb-tr }} catalog delete <{{ TR }}_catalog_name_or_ID> \
      --cluster-id <cluster_ID>
    ```

	You can get the {{ TR }} catalog ID and name together with the [list of {{ TR }} catalogs in the cluster](catalog-list.md#list-catalogs).

  You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

{% endlist %}