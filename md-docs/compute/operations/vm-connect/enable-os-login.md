# Настроить доступ по {{ oslogin }} на существующей ВМ

Если вам необходимо настроить подключение по {{ oslogin }} к уже развернутой виртуальной машине, вы можете самостоятельно установить на нее агент {{ oslogin }}.


## Включить доступ по {{ oslogin }} {#enable-os-login}

{% note tip %}

Чтобы иметь возможность создавать виртуальные машины с доступом по {{ oslogin }} и [подключаться](os-login.md) к таким ВМ, [включите](../../../organization/operations/os-login-access.md) {{ oslogin }} на уровне [организации](../../../organization/quickstart.md) {{ yandex-cloud }}.

{% endnote %}

Чтобы настроить доступ по {{ oslogin }} к существующей виртуальной машине:

1. Включите [доступ по {{ oslogin }}](../../../organization/operations/os-login-access.md) на уровне организации.

1. [Подключитесь](ssh.md#vm-connect) к ВМ по SSH.

1. Установите на виртуальную машину агент {{ oslogin }}. Выполните команду в зависимости от операционной системы ВМ:

    {% note info %}

    В публичном образе [Ubuntu 24.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin) агент {{ oslogin }} уже установлен, устанавливать его самостоятельно не требуется.

    {% endnote %}

    {% list tabs %}

    - Ubuntu

      * Ubuntu 24.04

        ```bash
        curl {{ link-oslogin-configs }}/ubuntu-24.04/config_oslogin.sh | bash
        ```

      * Ubuntu 22.04

        ```bash
        curl {{ link-oslogin-configs }}/ubuntu-22.04/config_oslogin.sh | bash
        ```

      * Ubuntu 20.04

        ```bash
        curl {{ link-oslogin-configs }}/ubuntu-20.04/config_oslogin.sh | bash
        ```

      * Ubuntu 18.04

        ```bash
        curl {{ link-oslogin-configs }}/ubuntu-18.04/config_oslogin.sh | bash
        ```

    - CentOS 7

      ```bash
      curl {{ link-oslogin-configs }}/centos-7/config_oslogin.sh | bash
      ```

    - Debian 11

      ```bash
      curl {{ link-oslogin-configs }}/debian-11/config_oslogin.sh | bash
      ```

    - AlmaLinux 9

      ```bash
      curl {{ link-oslogin-configs }}/almalinux-9/config_oslogin.sh | bash
      ```

    {% endlist %}

1. [Включите](../vm-control/vm-update.md#enable-oslogin-access) на виртуальной машине доступ по {{ oslogin }}.

Теперь вы можете подключиться к виртуальной машине по {{ oslogin }} как [с помощью CLI](os-login.md#connect-with-yc-cli), так и [с помощью стандартного SSH-клиента](os-login.md#connect-with-ssh-client). При подключении можно использовать SSH-сертификат или SSH-ключ, предварительно [добавленный](../../../organization/operations/add-ssh.md) в профиль пользователя или сервисного аккаунта в организации {{ org-full-name }}.


## Отключить доступ по {{ oslogin }} {#disable-os-login}

Для доступа к ВМ без {{ oslogin }} на стороне ВМ должна храниться публичная часть SSH-ключа. Если ВМ была [создана](../vm-create/create-linux-vm.md) без SSH-ключа или ключ был утерян, [добавьте](recovery-access.md#ssh-recovery) SSH-ключ и локального пользователя на ВМ вручную, прежде чем отключать доступ по {{ oslogin }}.

Чтобы вернуть возможность [подключаться](ssh.md) к ВМ по SSH без использования {{ oslogin }}:

1. Выключите доступ по {{ oslogin }}.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
        1. Перейдите в сервис **{{ compute-name }}**.
        1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите на имя нужной ВМ.
        1. В правом верхнем углу экрана нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
        1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}**.
        1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc compute instance update
        --name <имя_ВМ> \
        --folder-id <идентификатор_каталога> \
        --metadata enable-oslogin=false
      ```

      Убедитесь, что доступ по {{ oslogin }} выключен:

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

1. Выполните команду для удаления пакетов {{ oslogin }}:

    {% list tabs %}

    - Linux {#linux}

      ```bash
      curl {{ link-oslogin-configs }}/common/remove_oslogin.sh | bash
      ```

      В процессе удаления потребуется подтверждение для удаления пакетов `cron` и `unscd` — введите `y` и нажмите **Enter**.

    {% endlist %}

{% note alert %}

Если у пользователя есть права [суперпользователя](https://ru.wikipedia.org/wiki/Root) на ВМ, то он может сохранить доступ к ней даже при [отзыве ролей](../../../organization/security/index.md#revoke). Чтобы пользователь не смог зайти на ВМ с прежними правами, [создайте](../images-with-pre-installed-software/create.md) новую ВМ из чистого образа.

{% endnote %}