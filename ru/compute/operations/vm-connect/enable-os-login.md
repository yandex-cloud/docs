---
title: Как настроить доступ по OS Login на существующей ВМ
description: Следуя данной инструкции, вы сможете настроить доступ к существующей виртуальной машине по OS Login.
---

# Настроить доступ по OS Login на существующей ВМ

Если вам необходимо настроить подключение по OS Login к уже развернутой виртуальной машине, вы можете самостоятельно установить на нее агент OS Login.

## Включить доступ по OS Login {#enable-os-login}

Чтобы настроить доступ по OS Login к существующей виртуальной машине:

1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

1. [Подключитесь](./ssh.md#vm-connect) к ВМ по SSH.

1. Установите на виртуальную машину агент OS Login. Выполните команду в зависимости от операционной системы ВМ:

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

    - AlmaLinux 9

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/almalinux-9/config_oslogin.sh | bash
      ```

    {% endlist %}

1. [Включите](../vm-control/vm-update.md#enable-oslogin-access) на виртуальной машине доступ по OS Login.

Теперь вы можете подключиться к виртуальной машине по OS Login как [с помощью YC CLI](os-login.md#connect-with-yc-cli), так и [с помощью стандартного SSH-клиента](os-login.md#connect-with-ssh-client). При подключении можно использовать SSH-сертификат или SSH-ключ, предварительно [добавленный](../../../organization/operations/add-ssh.md) в профиль OS Login пользователя или сервисного аккаунта в {{ org-full-name }}.

## Отключить доступ по OS Login {#disable-os-login}

Для доступа без OS Login на стороне ВМ должна храниться публичная часть SSH-ключа. Если ВМ была [создана](../../../compute/operations/vm-create/create-linux-vm.md) без SSH-ключа или ключ был утерян, [добавьте](../../../compute/operations/vm-connect/recovery-access.md#ssh-recovery) ключ и пользователя вручную перед отключением доступа по OS Login.

Чтобы вернуть возможность [подключаться](ssh.md) к ВМ по SSH без использования OS Login:

1. Выключите доступ по OS Login.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
        1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
        1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** и нажмите на имя нужной ВМ.
        1. В правом верхнем углу экрана нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
        1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** отключите опцию **Доступ через OS Login**.
        1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

    - CLI {#cli}

      Выполните команду:

      ```bash
      yc compute instance update --name <имя_ВМ> \
      --folder-id <идентификатор_каталога> \
      --metadata enable-oslogin=false
      ```

      Убедитесь, что доступ по OS Login выключен:

      ```bash
      yc compute ssh --name <имя_ВМ> --folder-id <идентификатор_каталога>
      ```

      Результат:

      ```text
      ...
      username@12.345.***.***: Permission denied (publickey).
      ...
      ```

    {% endlist %}

1. [Подключитесь](./ssh.md#vm-connect) к ВМ по SSH.

1. Выполните команду для удаления пакетов OS Login:

    {% list tabs %}

    - Linux {#linux}

      ```bash
      curl https://storage.yandexcloud.net/oslogin-configs/common/remove_oslogin.sh | bash
      ```

      В процессе удаления потребуется подтверждение для удаления пакетов `cron` и `unscd` — введите `y` и нажмите **Enter**.

    {% endlist %}