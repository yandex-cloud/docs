---
title: Getting a list of routing instance operations
---

# Getting a list of operations in a routing instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cloud-router.viewer](../security/index.md#cloudrouter-viewer) role for this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command to get a list of operations in a [routing instance (RI)](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance list-operations --help
      ```

  1. Get a list of operations in the routing instance:

      ```bash
      yc cloudrouter routing-instance list-operations cca5e**********vie8c
      ```

      Result:

      ```text
     +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
     |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  |       DESCRIPTION         |
     +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
     | al49a**********ft8lq | 2025-03-23 07:34:27 | bfbud**********v7dfn | 2025-03-23 07:52:59 | DONE    | routing instance add      |
     |                      |                     |                      |                     |         | private connection        |
     | al4f3**********koifj | 2025-03-19 13:35:56 | bfbud**********v7dfn | 2025-03-19 15:24:58 | DONE    | routing instance create   |
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
    yc operation get al49a**********ft8lq
    ```
  
{% endlist %}

