---
title: 'Ключи, обрабатываемые в публичных образах {{ yandex-cloud }} '
description: Из этой статьи вы узнаете, какие ключи обрабатываются сервисом метаданных в публичных образах виртуальных машин в {{ yandex-cloud }} .
---

# Ключи, обрабатываемые в публичных образах {{ yandex-cloud }}

Список ключей, которые обрабатываются [сервисом метаданных](../vm-metadata.md) в [публичных образах](../image.md) {{ yandex-cloud }}, зависит от операционной системы образа:

{% list tabs group=operating_system %}

- Linux {#linux}

  * `serial-port-enable` — ключ, отвечающий за доступ к [серийной консоли](../../operations/serial-console/index.md) виртуальной машины. Возможные значения:
      * `0` — доступ к серийной консоли выключен. Значение по умолчанию.
      * `1` — доступ к серийной консоли включен.
  * `enable-oslogin` — ключ, отвечающий за доступ к виртуальной машине через [{{ oslogin }}](../../operations/vm-connect/os-login.md). Возможные значения:
      * `false` — доступ через {{ oslogin }} выключен. Значение по умолчанию.
      * `true` — доступ через {{ oslogin }} включен.
  * `user-data` — ключ, содержащий строку с пользовательскими метаданными, которые будут обработаны агентом [cloud-init](https://cloudinit.readthedocs.io/en/latest/index.html), запущенным на ВМ.

      Cloud-init поддерживает разные [форматы](https://cloudinit.readthedocs.io/en/latest/topics/format.html) передачи метаданных, например [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html). В этом формате вы можете передать SSH-ключи и указать, какому пользователю принадлежит каждый ключ. Для этого укажите их в элементе `users/ssh_authorized_keys`:

      {% include [user-data](../../../_includes/compute/user-data.md) %}

      Чтобы передать эти данные в запросе, замените переносы строки символом `\n`:

      ```json
      "metadata": {
        "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com\n      - ssh-ed25519 AAAAB3Nza...Pu00jRN"
      }
      ```

      В ключе `user-data` также можно описать [скрипты для установки программного обеспечения](../../operations/vm-create/create-with-cloud-init-scripts.md#examples), которые нужно выполнить при создании новой ВМ, а также [передать](../../operations/vm-create/create-with-lockbox-secret.md) в ВМ [секреты {{ lockbox-full-name }}](../../../lockbox/concepts/secret.md) и переменные, значения которых позднее можно будет [получить](../metadata/accessing-metadata.md#internal-access) изнутри ВМ.

  * `ssh-keys` — ключ, отвечающий за доставку публичного SSH-ключа на ВМ Linux через {{ TF }}. Указывается в формате `<имя_пользователя>:<содержимое_SSH-ключа>`, например `user:ssh-ed25519 AAAAB3Nza...Pu00jRN`. Если указать несколько ключей, будет использован только первый из них.

- Windows {#windows}

  `user-data` — ключ, содержащий строку с пользовательскими метаданными, которые будут обработаны агентом [Cloudbase-Init](https://cloudbase.it/cloudbase-init/). Этот агент поддерживает различные [форматы данных](https://cloudbase-init.readthedocs.io/en/latest/userdata.html), например PowerShell-скрипт, задающий пароль администратора:

  ```json
  "metadata": {
    "user-data": "#ps1\nnet user Administrator Passw0rd"
  }
  ```

{% endlist %}

## Примеры использования {#examples}

* [{#T}](../../tutorials/rds-gw.md)
* [{#T}](../../tutorials/coi-with-terraform.md)
* [{#T}](../../../tutorials/archive/vm-with-backup-policy/index.md)
* [{#T}](../../../tutorials/routing/multi-folder-vpc.md)
* [{#T}](../../../tutorials/infrastructure-management/run-docker-on-vm/index.md)

#### См. также {#see-also}

* [{#T}](../vm-metadata.md)
* [{#T}](./directories.md)
* [{#T}](./sending-metadata.md)
* [{#T}](./accessing-metadata.md)
* [{#T}](./identity-document.md)