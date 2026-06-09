# Настроить доступ по OS Login на существующей ВМ

Если вам необходимо настроить подключение по OS Login к уже развернутой виртуальной машине, вы можете самостоятельно установить на нее агент OS Login.


## Включить доступ по OS Login {#enable-os-login}

{% note tip %}

Чтобы иметь возможность создавать виртуальные машины с доступом по OS Login и [подключаться](os-login.md) к таким ВМ, [включите](../../../organization/operations/os-login-access.md) OS Login на уровне [организации](../../../organization/quickstart.md) Yandex Cloud.

{% endnote %}

Чтобы настроить доступ по OS Login к существующей виртуальной машине:

1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

1. [Подключитесь](ssh.md#vm-connect) к ВМ по SSH.

1. Установите на виртуальную машину агент OS Login. Выполните команду в зависимости от операционной системы ВМ:

    {% note info %}

    В публичном образе [Ubuntu 24.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin) агент OS Login уже установлен, устанавливать его самостоятельно не требуется.

    {% endnote %}

    {% list tabs %}

    - Ubuntu

      * Ubuntu 24.04

        ```bash
        curl https://storage.yandexcloud.net/oslogin-configs/ubuntu-24.04/config_oslogin.sh | bash
        ```

      * Ubuntu 22.04

        ```bash
        curl https://storage.yandexcloud.net/oslogin-configs/ubuntu-22.04/config_oslogin.sh | bash
        ```

      * Ubuntu 20.04

        ```bash
        curl https://storage.yandexcloud.net/oslogin-configs/ubuntu-20.04/config_oslogin.sh | bash
        ```

      * Ubuntu 18.04

        ```bash
        curl https://storage.yandexcloud.net/oslogin-configs/ubuntu-18.04/config_oslogin.sh | bash
        ```

    - CentOS 7

      ```bash
      curl https://storage.yandexcloud.net/oslogin-configs/centos-7/config_oslogin.sh | bash
      ```

    - Debian 11

      ```bash
      curl https://storage.yandexcloud.net/oslogin-configs/debian-11/config_oslogin.sh | bash
      ```

    - AlmaLinux 9

      ```bash
      curl https://storage.yandexcloud.net/oslogin-configs/almalinux-9/config_oslogin.sh | bash
      ```

    {% endlist %}

1. [Включите](../vm-control/vm-update.md#enable-oslogin-access) на виртуальной машине доступ по OS Login.

Теперь вы можете подключиться к виртуальной машине по OS Login как [с помощью CLI](os-login.md#connect-with-yc-cli), так и [с помощью стандартного SSH-клиента](os-login.md#connect-with-ssh-client). При подключении можно использовать SSH-сертификат или SSH-ключ, предварительно [добавленный](../../../organization/operations/add-ssh.md) в профиль пользователя или сервисного аккаунта в организации Yandex Identity Hub.


## Отключить доступ по OS Login {#disable-os-login}

Для доступа к ВМ без OS Login на стороне ВМ должна храниться публичная часть SSH-ключа. Если ВМ была [создана](../vm-create/create-linux-vm.md) без SSH-ключа или ключ был утерян, [добавьте](recovery-access.md#ssh-recovery) SSH-ключ и локального пользователя на ВМ вручную, прежде чем отключать доступ по OS Login.

Чтобы вернуть возможность [подключаться](ssh.md) к ВМ по SSH без использования OS Login:

1. Выключите доступ по OS Login.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит ВМ.
        1. Перейдите в сервис **Compute Cloud**.
        1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите на имя нужной ВМ.
        1. В правом верхнем углу экрана нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **Изменить ВМ**.
        1. В блоке **Доступ** выберите вариант **SSH-ключ**.
        1. Нажмите **Сохранить изменения**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc compute instance update
        --name <имя_ВМ> \
        --folder-id <идентификатор_каталога> \
        --metadata enable-oslogin=false
      ```

      Убедитесь, что доступ по OS Login выключен:

      ```bash
      yc compute ssh
        --name <имя_ВМ> \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      ```text
      ...
      username@12.345.***.***: Permission denied (publickey).
      ...
      ```

    {% endlist %}

1. [Подключитесь](ssh.md#vm-connect) к ВМ по SSH.

1. Выполните команду для удаления пакетов OS Login:

    {% list tabs %}

    - Linux {#linux}

      ```bash
      curl https://storage.yandexcloud.net/oslogin-configs/common/remove_oslogin.sh | bash
      ```

      В процессе удаления потребуется подтверждение для удаления пакетов `cron` и `unscd` — введите `y` и нажмите **Enter**.

    {% endlist %}

{% note alert %}

Если у пользователя есть права [суперпользователя](https://ru.wikipedia.org/wiki/Root) на ВМ, то он может сохранить доступ к ней даже при [отзыве ролей](../../../organization/security/index.md#revoke). Чтобы пользователь не смог зайти на ВМ с прежними правами, [создайте](../images-with-pre-installed-software/create.md) новую ВМ из чистого образа.

{% endnote %}