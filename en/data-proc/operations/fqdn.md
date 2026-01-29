---
title: How to get an FQDN of a {{ dataproc-full-name }} host
description: Follow this guide to get an FQDN of a {{ dataproc-name }} host.
---

# Getting an FQDN of a {{ dataproc-name }} host

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), open the folder containing your cluster.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Select your cluster.
    1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of {{ dataproc-name }} cluster hosts, run this command:

    ```bash
    {{ yc-dp }} cluster list-hosts <cluster_name_or_ID>
    ```

    You can get the cluster name and ID with the [list of clusters](cluster-list.md#list) in the folder.

    The `Name` column in the command output contains the host FQDN.

{% endlist %}