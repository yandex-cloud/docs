---
title: Getting access rules in {{ mtr-name }}
description: You can learn what access rules are assigned for a {{ mtr-name }} cluster.
---

# Getting access rules in {{ mtr-name }}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To learn what access rules are assigned for a {{ mtr-name }} cluster, run this command:

  ```bash
  {{ yc-mdb-tr }} cluster get-access-control <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

  To learn what access rules are assigned for a {{ mtr-name }} cluster, [get detailed info](cluster-list.md#get-cluster) on this cluster.

{% endlist %}
