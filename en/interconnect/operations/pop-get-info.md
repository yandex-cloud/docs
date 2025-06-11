---
title: How to get information about {{ interconnect-name }} points of presence
description: In this tutorial, we will get information about {{ interconnect-name }} points of presence.
---

# Getting information about points of presence

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Get information about the {{ interconnect-name }} [points of presence](../concepts/pops.md):

      ```bash
      yc cic point-of-presence list
      ```

      Result:

      ```text
      +----------------+-------------+
      |       ID       |  REGION ID  |
      +----------------+-------------+
      | ru-msk-m9-0    | ru-central1 |
      | ru-msk-nord-0  | ru-central1 |
      | ru-msk-ost-0   | ru-central1 |
      | ru-msk-std-0   | ru-central1 |
      | ru-msk-tehno-0 | ru-central1 |
      +----------------+-------------+
      ```

      Where:
      * `ID`: Point of presence ID.
      * `REGION ID`: Cloud region containing the point of presence.

{% endlist %}

