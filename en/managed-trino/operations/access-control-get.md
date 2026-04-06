---
title: Getting access rules in {{ mtr-name }}
description: You can learn what access rules are assigned for a {{ mtr-name }} cluster.
---

# Getting access rules in {{ mtr-name }}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.common.overview }}** tab.

     Access permissions are described under **{{ ui-key.yacloud.trino.ClusterView.RBACView.label_rbac-settings_o2F64 }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To learn what access rules are assigned for a {{ mtr-name }} cluster, run this command:

  ```bash
  {{ yc-mdb-tr }} cluster get-access-control <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  To learn what access rules are assigned for a {{ mtr-name }} cluster, [get detailed info](cluster-list.md#get-cluster) on this cluster. Access permissions are described under `accessControl`.

- gRPC API {#grpc-api}

  To learn what access rules are assigned for a {{ mtr-name }} cluster, [get detailed info](cluster-list.md#get-cluster) on this cluster. Access permissions are described under `access_control`.

{% endlist %}
