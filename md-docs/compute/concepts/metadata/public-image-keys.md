[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Концепции](../index.md) > Метаданные виртуальных машин > Ключи, обрабатываемые в публичных образах

# Ключи, обрабатываемые в публичных образах Yandex Cloud

Список ключей, которые обрабатываются [сервисом метаданных](../vm-metadata.md) в [публичных образах](../image.md) Yandex Cloud, зависит от операционной системы образа:

{% list tabs group=operating_system %}

- Linux {#linux}

  * `serial-port-enable` — ключ, отвечающий за доступ к [серийной консоли](../serial-console.md) виртуальной машины. Возможные значения:
      * `0` — доступ к серийной консоли выключен. Значение по умолчанию.
      * `1` — доступ к серийной консоли включен.
  * `enable-oslogin` — ключ, отвечающий за доступ к виртуальной машине через [OS Login](../../operations/vm-connect/os-login.md). Возможные значения:
      * `false` — доступ через OS Login выключен. Значение по умолчанию.
      * `true` — доступ через OS Login включен.
  * `user-data` — ключ, содержащий строку с пользовательскими метаданными, которые будут обработаны агентом [cloud-init](https://cloudinit.readthedocs.io/en/latest/index.html), запущенным на ВМ.

      Cloud-init поддерживает разные [форматы](https://cloudinit.readthedocs.io/en/latest/topics/format.html) передачи метаданных, например [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html). В этом формате вы можете передать SSH-ключи и указать, какому пользователю принадлежит каждый ключ. Для этого укажите их в элементе `users/ssh_authorized_keys`:

      ```bash
         #cloud-config
         users:
           - name: <имя_пользователя>
             groups: sudo
             shell: /bin/bash
             sudo: 'ALL=(ALL) NOPASSWD:ALL'
             ssh_authorized_keys:
               - <публичный_SSH-ключ_1>
               - <публичный_SSH-ключ_2>
               - ...
         ```
      
         Где:
      
         * `name` — имя пользователя ВМ.
         * `ssh_authorized_keys` — список публичных SSH-ключей для доступа к ВМ.
            
           Пример ключа: `ssh-ed25519 AAAAB3Nza...Pu00jRN`.

      Чтобы передать эти данные в запросе, замените переносы строки символом `\n`:

      ```json
      "metadata": {
        "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com\n      - ssh-ed25519 AAAAB3Nza...Pu00jRN"
      }
      ```

      В ключе `user-data` также можно описать [скрипты для установки программного обеспечения](../../operations/vm-create/create-with-cloud-init-scripts.md#examples), которые нужно выполнить при создании новой ВМ, а также [передать](../../operations/vm-create/create-with-lockbox-secret.md) в ВМ [секреты Yandex Lockbox](../../../lockbox/concepts/secret.md) и переменные, значения которых позднее можно будет [получить](accessing-metadata.md#internal-access) изнутри ВМ.

  * `ssh-keys` — ключ, отвечающий за доставку публичного SSH-ключа на ВМ Linux через Terraform. Указывается в формате `<имя_пользователя>:<содержимое_SSH-ключа>`, например `user:ssh-ed25519 AAAAB3Nza...Pu00jRN`. Если указать несколько ключей, будет использован только первый из них.

- Windows {#windows}

  `user-data` — ключ, содержащий строку с пользовательскими метаданными, которые будут обработаны агентом [Cloudbase-Init](https://cloudbase.it/cloudbase-init/). Этот агент поддерживает различные [форматы данных](https://cloudbase-init.readthedocs.io/en/latest/userdata.html), например PowerShell-скрипт, задающий пароль администратора:

  ```json
  "metadata": {
    "user-data": "#ps1\nnet user Administrator Passw0rd"
  }
  ```

{% endlist %}

## Примеры использования {#examples}

* [Развертывание Remote Desktop Gateway](../../tutorials/rds-gw.md)
* [Создание ВМ и группы ВМ с Container Optimized Image с помощью Terraform](../../tutorials/coi-with-terraform.md)
* [Автоматическая привязка политики резервного копирования Yandex Cloud Backup к ВМ](../../../tutorials/archive/vm-with-backup-policy/index.md)
* [Настройка сетевого взаимодействия ресурсов из разных каталогов](../../../tutorials/routing/multi-folder-vpc.md)
* [Запуск Docker-образа на виртуальной машине](../../../tutorials/infrastructure-management/run-docker-on-vm/index.md)

#### Полезные ссылки {#see-also}

* [Метаданные виртуальной машины](../vm-metadata.md)
* [Каталоги метаданных](directories.md)
* [Передача метаданных в виртуальные машины](sending-metadata.md)
* [Доступ к метаданным виртуальных машин](accessing-metadata.md)
* [Идентификационный документ](identity-document.md)