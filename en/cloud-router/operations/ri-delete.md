---
title: How to delete a routing instance in {{ cr-name }}
description: Follow this guide to delete a routing instance in {{ cr-name }}.
---

# Deleting a routing instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cloud-router.editor](../security/index.md#cloudrouter-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Make sure that the routing instance you want to delete has no other child objects, e.g., private connections:

      ```bash
      yc cloudrouter routing-instance get c3l87**********1dpin
      ```

  1. See the description of the CLI command for deleting a [routing instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance delete --help
      ```

  1. Delete the routing instance:

      ```bash
      yc cloudrouter routing-instance delete c3l87**********1dpin --async
      ```

{% endlist %}

