---
title: How to delete a private connection from a {{ interconnect-name }} trunk
description: Follow this guide to delete a private connection from a {{ interconnect-name }} trunk.
---

# Deleting a private connection

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for deleting a [private connection](../concepts/priv-con.md):

      ```bash
      yc cic private-connection delete --help
      ```

  1. Delete a private connection:

      ```bash
      yc cic private-connection delete cf3td**********nufvr --async
      ```

{% endlist %}

