---
title: How to get information about {{ interconnect-name }} points of presence
---

# Getting information about points of presence

{% include [cic-api-access](../../_includes/interconnect/cic-api-access.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
      * `REGION ID`: Cloud region the point of presence belongs to.

{% endlist %}
