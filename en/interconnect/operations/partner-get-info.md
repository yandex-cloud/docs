---
title: How to get information about {{ interconnect-name }} partners
description: Follow this guide to get information about {{ interconnect-name }} partners.
---

# Getting information about {{ interconnect-name }} partners

{% list tabs group=instructions %}

- CLI {#cli}

  1. Get information about {{ yandex-cloud }} partners providing {{ interconnect-name }}:

      ```bash
      yc cic partner list
      ```

      Result:

      ```text
      +-----------+-------------+--------+
      |    ID     |  REGION ID  | STATUS |
      +-----------+-------------+--------+
      | dwdm.ru   | ru-central1 | DOWN   |
      | ertelecom | ru-central1 | UP     |
      | mastertel | ru-central1 | UP     |
      | msk_ix    | ru-central1 | UP     |
      | obit      | ru-central1 | UP     |
      | retn      | ru-central1 | UP     |
      | tnsplus   | ru-central1 | UP     |
      | vimpelkom | ru-central1 | UP     |
      +-----------+-------------+--------+
      ```

      Where:
      * `ID`: Partner ID.
      * `REGION ID`: Cloud region where partner connection is available.
      * `STATUS`: Partnership status. `DOWN` means this partner is not available for connection.

{% endlist %}

