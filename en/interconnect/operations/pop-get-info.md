---
title: How to get information about {{ interconnect-name }} points of presence
description: In this tutorial, we will get information about {{ interconnect-name }} points of presence.
---

# Getting information about points of presence

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}** and, in the window that opens, click **{{ ui-key.yacloud.interconnect.trunk-connection.TrunkConnectionListScreen.create-trunk-connection_oUuYo }}**.
  1. Expand the list of available points of presence in the **{{ ui-key.yacloud.interconnect.trunk-connection.point-of-presence_265QN }}** field.
  1. Click **{{ ui-key.yacloud.common.cancel }}** to skip creating a trunk this time.

- CLI {#cli}

  1. Get information about the {{ interconnect-name }} [points of presence](../concepts/pops.md):

      ```bash
      yc cic point-of-presence list
      ```

      Result:



      Where:

      * `ID`: Point of presence ID.
      * `REGION ID`: Cloud region containing the point of presence.

{% endlist %}

