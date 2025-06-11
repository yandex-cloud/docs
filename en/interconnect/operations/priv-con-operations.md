---
title: How to get a list of operations for a private connection in {{ interconnect-name }}
description: Follow this guide to get a list of private connection operations in {{ interconnect-name }}.
---

# Getting a list of operations for a private connection

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command to get a list of [private connection](../concepts/priv-con.md) operations:

      ```bash
      yc cic private-connection list-operations --help
      ```

  1. Getting a list of operations for a private connection:

      ```bash
      yc cic private-connection list-operations cca59**********dvjir
      ```

      Result:

      ```text
     +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
     |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  |       DESCRIPTION         |
     +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
     | cca59**********dvjir | 2025-03-24 10:50:43 | bfbud**********v7dfn | 2025-03-24 11:18:15 | DONE    | private connection update |
     |                      |                     |                      |                     |         |                           |
     | cca59**********dvjir | 2025-03-24 10:18:32 | bfbud**********v7dfn | 2025-03-24 10:39:32 | DONE    | private connection create |
     +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      ```

      Where:
      * `ID`: ID of operation in progress or completed operation.
      * `CREATED AT`: Date and time the operation was created.
      * `CREATED BY`: ID of the user who created the operation.
      * `MODIFIED AT`: Date and time the operation was last modified at.
      * `STATUS`: Current operation status (`RUNNING`: in progress, `DONE`: completed).
      * `DESCRIPTION`: Description of the command type performed in the operation. 

  1. If you need more details about the operation, get them by its ID:

    ```bash
    yc operation get cca59**********dvjir
    ```
  
{% endlist %}

