---
title: "How to get information about a GPU cluster in {{ compute-full-name }}"
---

# Getting information about a GPU cluster

To get information about a GPU cluster:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to get information about a GPU cluster:

      ```bash
      yc compute gpu-cluster get --help
      ```

   1. Get information about your GPU cluster by specifying its name or ID:

      ```bash
      yc compute gpu-cluster get <GPU_cluster_name>
      ```

      Result:

      ```bash
      ...
      ```

{% endlist %}
