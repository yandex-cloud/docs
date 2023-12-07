---
title: "Как настроить доступ через OS Login на существующей ВМ"
description: "Следуя данной инструкции, вы сможете настроить доступ к существующей виртуальной машине через OS Login."
---

# Настроить доступ через OS Login на существующей ВМ

{% include notitle [preview](../../../_includes/note-preview-by-request.md) %}

Если вам необходимо настроить подключение через OS Login к уже развернутой виртуальной машине, вы можете самостоятельно установить на нее агента OS Login.

Чтобы настроить доступ через OS Login к существующей виртуальной машине:

1. Включите [доступ через OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

1. [Подключитесь](./ssh.md#vm-connect) к ВМ по SSH.

1. Установите на виртуальную машину агента OS Login. Выполните команду в зависимости от операционной системы ВМ:

    {% list tabs %}

    - Ubuntu 22.04

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/ubuntu-22.04/config_oslogin.sh | bash
      ```

    - Ubuntu 20.04

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/ubuntu-20.04/config_oslogin.sh | bash
      ```

    - Ubuntu 18.04

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/ubuntu-18.04/config_oslogin.sh | bash
      ```

    - CentOS 7

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/centos-7/config_oslogin.sh | bash
      ```

    - Debian 11

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/debian-11/config_oslogin.sh | bash
      ```

    {% endlist %}

1. [Включите](../vm-control/vm-update.md#enable-oslogin-access) на виртуальной машине доступ через OS Login.

Теперь вы можете [подключиться](./os-login.md) к виртуальной машине через OS Login. При этом [подключиться к ВМ по SSH](./ssh.md#vm-connect) стало невозможно.

Чтобы вернуть возможность подключаться к ВМ по SSH, нужно отключить для нее доступ через OS Login. Для этого [измените](../vm-control/vm-update.md) настройки ВМ, отключив опцию **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}**.