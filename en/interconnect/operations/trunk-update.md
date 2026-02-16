---
title: How to update a trunk in {{ interconnect-name }}
description: Follow this guide to update parameters in a trunk in {{ interconnect-name }}.
---

# Updating trunk parameters

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

Currently, users can perform limited operations when updating a trunk:
* Update the trunk name in `new-name`.
* Update the trunk description in `description`.
* Set or remove the trunk deletion protection flag, `deletion-protection`.

To update other trunk parameters, e.g., [change the trunk capacity](../tutorials/trunk-capacity-change.md), you still need to contact support.

For example, to change the trunk name, follow these steps:

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for updating [trunk](../concepts/trunk.md) parameters:

      ```bash
      yc cic trunk-connection update  --help
      ```

  1. Change the trunk name:

      ```bash
      yc cic trunk-connection update cf3td**********nufvr \
        --new-name my-new-trunk-name \
        --async
      ```

      Result:



{% endlist %}

