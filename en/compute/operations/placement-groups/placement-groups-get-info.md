---
title: "How to get information about a placement group in {{ compute-full-name }}"
---

# Getting information about a placement group

To get information about a placement group:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to get information about a placement group:

      ```bash
      yc compute placement-group get --help
      ```

   1. Get information about your placement group by specifying its name or ID:

      ```bash
      yc compute placement-group get <placement_group_name>
      ```

      Result:

      ```bash
      id: fd8j3mm3229m********
      folder_id: b1g86q4m5vej********
      created_at: "2023-10-19T10:36:38Z"
      name: test-group
      spread_placement_strategy: {}
      ```

{% endlist %}
