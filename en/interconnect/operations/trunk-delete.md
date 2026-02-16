---
title: How to delete a trunk in {{ interconnect-name }}
description: Follow this guide to delete a trunk in {{ interconnect-name }}.
---

# Deleting a trunk

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for deleting a [trunk](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection delete --help
      ```

  1. Delete a trunk:

      ```bash
      yc cic trunk-connection delete cf3td**********nufvr --async
      ```

{% endlist %}
