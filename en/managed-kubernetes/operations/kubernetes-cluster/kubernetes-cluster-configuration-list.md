---
title: Getting a list of available master configurations in a {{ k8s }} cluster
description: Follow this guide to get a list of available master configurations in a {{ k8s }} cluster.
---

# Getting a list of available master configurations in a {{ k8s }} cluster

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top-right corner of the page. This will open the cluster editing page.  
    1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**, expand the **{{ ui-key.yacloud.k8s.clusters.create.label_master-computing-resources }}** section.

       You will see the available configurations on these tabs:

          * **{{ ui-key.yacloud.k8s.clusters.create.label_master-preset-group-standard }}**
          * **{{ ui-key.yacloud.k8s.clusters.create.label_master-preset-group-cpu-optimized }}**
          * **{{ ui-key.yacloud.k8s.clusters.create.label_master-preset-group-memory-optimized }}**

- CLI {#cli}

  Run this command:

  ```bash
  yc managed-kubernetes resource-preset list
  ```

  Result:

  ```text
  +------------+-------+----------+---------------+
  |     ID     | CORES |  MEMORY  | CORE FRACTION |
  +------------+-------+----------+---------------+
  | s-c2-m8    |     2 | 8.0 GB   |           100 |
  | m-c2-m16   |     2 | 16.0 GB  |           100 |
  | c-c4-m8    |     4 | 8.0 GB   |           100 |
  | s-c4-m16   |     4 | 16.0 GB  |           100 |
  | m-c4-m32   |     4 | 32.0 GB  |           100 |
  | c-c8-m16   |     8 | 16.0 GB  |           100 |
  | s-c8-m32   |     8 | 32.0 GB  |           100 |
  | m-c8-m64   |     8 | 64.0 GB  |           100 |
  | c-c16-m32  |    16 | 32.0 GB  |           100 |
  | s-c16-m64  |    16 | 64.0 GB  |           100 |
  | m-c16-m128 |    16 | 128.0 GB |           100 |
  | c-c32-m64  |    32 | 64.0 GB  |           100 |
  | s-c32-m128 |    32 | 128.0 GB |           100 |
  | m-c32-m256 |    32 | 256.0 GB |           100 |
  | s-c64-m256 |    64 | 256.0 GB |           100 |
  | s-c80-m320 |    80 | 320.0 GB |           100 |
  +------------+-------+----------+---------------+  
    ```

- API {#api}

  To get the list of available master configurations in the cluster, use the [list](../../managed-kubernetes/api-ref/grpc/ResourcePreset/list.md) method for the [ResourcePreset](../../managed-kubernetes/api-ref/grpc/ResourcePreset/) resource.

{% endlist %}

[Learn more about master computing resources](../../concepts/index.md#master-resources)
