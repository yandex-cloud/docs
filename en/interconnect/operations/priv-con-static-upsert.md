---
title: How to add static routes to a private connection in {{ interconnect-name }}
description: Follow this guide to add static routes to a private connection in {{ interconnect-name }}.
---

# Adding static routes to a private connection (VPC stitching)

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for adding static routes to a [private connection](../concepts/priv-con.md):

      ```bash
      yc cic private-connection upsert-static-routes --help
      ```

  1. Add static routes to a private connection:

      ```bash
      yc cic private-connection upsert-static-routes cf3td**********nufvr \ 
        --ipv4-static-routes=10.0.0.0/8,10.0.1.0/8" \
        --async
      ```

{% endlist %}

