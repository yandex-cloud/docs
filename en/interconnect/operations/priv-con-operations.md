---
title: How to get a list of operations for a private connection in {{ interconnect-name }}
description: Follow this guide to get a list of private connection operations in {{ interconnect-name }}.
---

# Getting a list of operations for a private connection

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}**. In the list of private connections that opens, select the connection at hand.
  1. In the connection info window that opens, select ![list-check](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** in the left-hand menu to view a list of [operations](../../api-design-guide/concepts/about-async.md) with the selected private connection.

- CLI {#cli}

  1. See the description of the CLI command to get a list of [private connection](../concepts/priv-con.md) operations:

      ```bash
      yc cic private-connection list-operations --help
      ```

  1. Getting a list of operations for a private connection:

      ```bash
      yc cic private-connection list-operations cf3r5ke20fo0********
      ```

      Result:

      ```text
      +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  |       DESCRIPTION         |
      +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      | bd6kg6j1ni92******** | 2025-03-24 10:50:43 | ajeol2afu1js******** | 2025-03-24 11:18:15 | DONE    | private connection update |
      |                      |                     |                      |                     |         |                           |
      | bd6i7jqgtaq1******** | 2025-03-24 10:18:32 | ajeol2afu1js******** | 2025-03-24 10:39:32 | DONE    | private connection create |
      +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      ```

      Where:

      * `ID`: ID of operation in progress or completed operation.
      * `CREATED AT`: Date and time the operation was created.
      * `CREATED BY`: ID of the user who created the operation.
      * `MODIFIED AT`: Date and time the operation was last modified at.
      * `STATUS`: Current operation status (`RUNNING`: in progress, `DONE`: completed).
      * `DESCRIPTION`: Description of the command type performed in the operation. 

  1. If you need additional information about the operation, get it by its ID:

      ```bash
      yc operation get bd6i7jqgtaq1********
      ```

{% endlist %}
