---
title: Getting a list of trunk operations in {{ interconnect-name }}
description: Follow this guide to get a list of trunk operations in {{ interconnect-name }}.
---

# Getting a list of trunk operations

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}** and in the list of trunks that opens, click the one you need.
  1. In the trunk info window that opens, select ![list-check](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** in the left-hand menu to view a list of [operations](../../api-design-guide/concepts/about-async.md) with the selected trunk.

- CLI {#cli}

  1. See the description of the CLI command to get a list of [trunk](../concepts/trunk.md) operations:

      ```bash
      yc cic trunk-connection list-operations --help
      ```

  1. Get a list of trunk operations:

      ```bash
      yc cic trunk-connection list-operations cf3dcodot14p********
      ```

      Result:

      ```text
      +----------------------+---------------------+----------------------+---------------------+---------+--------------+
      |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  | DESCRIPTION  |
      +----------------------+---------------------+----------------------+---------------------+---------+--------------+
      | bd6a0267a1vf******** | 2025-03-24 15:24:15 | ajeol2afu1js******** | 2025-03-24 15:24:15 | RUNNING | trunk update |
      |                      |                     |                      |                     |         |              |
      | bd6rbsr1gaj9******** | 2025-03-24 08:53:16 | ajeol2afu1js******** | 2025-03-24 09:13:11 | DONE    | trunk create |
      +----------------------+---------------------+----------------------+---------------------+---------+--------------+
      ```

      Where:

      * `ID`: ID of operation in progress or completed operation.
      * `CREATED AT`: Date and time the operation was created.
      * `CREATED BY`: ID of the user who created the operation.
      * `MODIFIED AT`: Date and time the operation was last modified at.
      * `STATUS`: Current operation status (`RUNNING`: in progress, `DONE`: completed).
      * `DESCRIPTION`: Description of the command type performed in the operation. 

  1. If you need additional information about the operation, get it by its ID:

      ```text
      yc operation get bd6rbsr1gaj9********
      ```

{% endlist %}
