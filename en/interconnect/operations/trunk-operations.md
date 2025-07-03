---
title: Getting a list of trunk operations in {{ interconnect-name }}
description: Follow this guide to get a list of trunk operations in {{ interconnect-name }}.
---

# Getting a list of trunk operations

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command to get a list of [trunk](../concepts/trunk.md) operations:

      ```bash
      yc cic trunk-connection list-operations --help
      ```

  1. Get a list of trunk operations:

      ```bash
      yc cic trunk-connection list-operations cf3td**********nufvr
      ```

      Result:

      ```text
     +----------------------+---------------------+----------------------+---------------------+---------+--------------+
     |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  | DESCRIPTION  |
     +----------------------+---------------------+----------------------+---------------------+---------+--------------+
     | al457**********njn6p | 2025-03-24 15:24:15 | bfbud**********v7dfn | 2025-03-24 15:24:15 | RUNNING | trunk update |
     |                      |                     |                      |                     |         |              |
     | al4cq**********3fdh9 | 2025-03-24 08:53:16 | bfbud**********v7dfn | 2025-03-24 09:13:11 | DONE    | trunk create |
     +----------------------+---------------------+----------------------+---------------------+---------+--------------+
      ```

      Where:
      * `ID`: ID of operation in progress or completed operation.
      * `CREATED AT`: Date and time the operation was created.
      * `CREATED BY`: ID of the user who created the operation.
      * `MODIFIED AT`: Date and time the operation was last modified at.
      * `STATUS`: Current operation status (`RUNNING`: in progress, `DONE`: completed).
      * `DESCRIPTION`: Description of the command type performed in the operation. 

  1. If you need more details about the operation, get them by its ID:
  
    ```text
    yc operation get al457**********njn6p
    ```
  
{% endlist %}

