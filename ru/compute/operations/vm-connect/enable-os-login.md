---
title: "Как настроить доступ по OS Login на существующей ВМ"
description: "Следуя данной инструкции, вы сможете настроить доступ к существующей виртуальной машине по OS Login."
---

# Настроить доступ по OS Login на существующей ВМ

Если вам необходимо настроить подключение по OS Login к уже развернутой виртуальной машине, вы можете самостоятельно установить на нее агента OS Login.

Чтобы настроить доступ по OS Login к существующей виртуальной машине:

1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

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

1. [Включите](../vm-control/vm-update.md#enable-oslogin-access) на виртуальной машине доступ по OS Login.

Теперь вы можете подключиться к виртуальной машине по OS Login c SSH-сертификатом [через YC CLI](os-login.md#connect-via-cli) или [через стандартный SSH-клиент](os-login.md#connect-via-exported-certificate), а также через YC CLI [с SSH-ключом](os-login.md#connect-via-key), предварительно добавленным в профиль пользователя организации в {{ org-full-name }}.

Чтобы вернуть возможность [подключаться](./ssh.md#vm-connect) к ВМ по SSH без использования OS Login, [измените](../vm-control/vm-update.md) настройки ВМ, отключив опцию **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}**.