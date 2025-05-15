---
title: How to update a {{ baremetal-full-name }} server connection to {{ backup-full-name }}
description: Follow this guide to update a {{ baremetal-name }} server connection to {{ backup-name }}.
---

# Reconnecting a {{ baremetal-full-name }} server to {{ backup-name }}

{% note info %}

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

{% endnote %}

If you deploy a backup of one server to another, the original server's connection to {{ backup-name }} becomes outdated. To continue backing up the original server and avoid conflicts with the new one, upgrade the source server connection to {{ backup-name }}:

1. To connect a {{ baremetal-name }} server to {{ backup-name }}, you need a [service account](../../../iam/concepts/users/service-accounts.md) with at least the `backup.editor` and `baremetal.editor` [roles](../../../iam/concepts/access-control/roles.md). [Create](backup-baremetal.md#prepare-service-account) one or assign the required roles to an existing service account.
1. Get an [IAM token](../../../iam/operations/index.md#authentication).
1. Reconnect to {{ backup-name }} from the outdated server:

    {% list tabs group=operating_system %}

    - Linux {#linux}

      1. [Connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the server over SSH.
      1. On your server, install [curl](https://curl.se/), [wget](https://www.gnu.org/software/wget/), [gawk](https://www.gnu.org/software/gawk/), [uuid-dev](https://{{ lang }}.wikipedia.org/wiki/UUID), and [uuidgen](https://uuidgen.org/).

          {% note info %}

          If you use a distribution other than Ubuntu, install the specified utilities using your package manager commands.

          {% endnote %}

          ```bash
          sudo apt install curl
          sudo apt install wget
          sudo apt install gawk
          sudo apt install uuid-dev
          sudo apt install uuid-runtime
          ```

      1. Update your connection to {{ backup-name }}:

          ```bash
          wget https://storage.yandexcloud.net/backup-distributions/agent_reinit_bms.sh
          sudo bash agent_reinit_bms.sh -t=<IAM_token>
          ```

          Where `-t` is the IAM token you got earlier.

          Result:

          ```text
          ...
          Deleting old resource bound for instance_id epdoe4g6dbq4******** and resource_id: F07543A1-BDC1-415A-A143-C18E********
          Updating ids in {{ backup-name }}
          Finished
          ```

    {% endlist %}

1. Make sure the server is connected to {{ backup-name }}:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Get a list of {{ baremetal-name }} servers connected to {{ backup-name }}:

      ```bash
      yc backup resource list --type bms
      ```

      Where `--type` is the resource type.

      Result:

      ```text
      compute_instance_id: epd5sk4auijm********
      created_at: "2024-11-17T10:29:40.436155166Z"
      updated_at: "2024-11-17T10:32:54.580592713Z"
      online: true
      enabled: true
      status: IDLE
      next_backup_time: "2024-11-24T00:00:00Z"
      resource_id: ad216376-a8d7-4c28-9a8d-b4ad********
      is_active: true
      init_status: REGISTRED
      metadata: "null"
      type: BMS
      ```

    {% endlist %}

1. [Link](../policy-vm/attach-and-detach-vm.md) the server to a backup policy.