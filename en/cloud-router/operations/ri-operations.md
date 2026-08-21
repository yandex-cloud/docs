---
title: How to get a list of operations for a virtual router
description: Follow this guide to get a list of operations performed on a virtual router in {{ cr-name }}.
---

# Getting a list of operations with a virtual router

{% note info %}

You need the [cloud-router.viewer](../security/index.md#cloudrouter-viewer) role for this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [virtual router](../concepts/routing-instance.md).
  1. [Navigate]({{ link-console-main }}/link/cloud-router) to **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. Select the virtual router.
  1. Navigate to the **{{ ui-key.yacloud_org.common.operations }}** tab. Optionally, filter the operations by their ID or status.

- CLI {#cli}

  1. See the description of the CLI command to get a list of [virtual router](../concepts/routing-instance.md) operations:

      ```bash
      yc cloudrouter routing-instance list-operations --help
      ```

  1. Get a list of operations for a virtual router:

      ```bash
      yc cloudrouter routing-instance list-operations cca5e**********vie8c
      ```

      Result:

      ```text
      +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  |       DESCRIPTION         |
      +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      | al49a**********ft8lq | 2025-03-23 07:34:27 | bfbud**********v7dfn | 2025-03-23 07:52:59 | DONE | routing instance add |
      |                      |                     |                      |                     |         | private connection        |
      | al4f3**********koifj | 2025-03-19 13:35:56 | bfbud**********v7dfn | 2025-03-19 15:24:58 | DONE | routing instance create |
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
    yc operation get al49a**********ft8lq
    ```
  
{% endlist %}
