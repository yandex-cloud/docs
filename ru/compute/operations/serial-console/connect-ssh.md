---
title: Подключение к серийной консоли ВМ с операционной системой Linux
description: Следуя данной инструкции, вы научитесь подключаться к серийной консоли виртуальной машины {{ compute-full-name }} под управлением операционной системы Linux.
---

# Подключиться к серийной консоли виртуальной машины с ОС Linux

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

Чтобы подключиться к [серийной консоли](../../concepts/serial-console.md) ВМ, для этой виртуальной машины необходимо предварительно [разрешить доступ](./index.md#enable) к серийной консоли.

Вы можете подключиться к серийной консоли с помощью [консоли управления]({{ link-console-main }}), а также с использованием стандартного [SSH](../../../glossary/ssh-keygen.md)-клиента или через [{{ oslogin }}](../../../organization/concepts/os-login.md).

Перед подключением к серийной консоли внимательно ознакомьтесь с разделом [{#T}](../../concepts/serial-console.md#security).

## Перед началом работы {#before-you-begin}

Некоторые операционные системы для доступа на ВМ через серийную консоль могут запрашивать данные локального пользователя. Поэтому перед подключением к серийной консоли необходимо задать локальный пароль пользователя.

В примере ниже вы создадите учетную запись нового локального пользователя Linux с парольной защитой:

1. Подключитесь к виртуальной машине [по SSH](../vm-connect/ssh.md) или [по {{ oslogin }}](../vm-connect/os-login.md).
1. Создайте учетную запись нового локального пользователя, защищенную паролем:

    ```bash
    export NEW_USERNAME=<имя_нового_пользователя>
    sudo useradd -m -d /home/$NEW_USERNAME -s /bin/bash $NEW_USERNAME \
    && sudo passwd $NEW_USERNAME
    ```

    В результате система запросит ввести и подтвердить пароль нового пользователя:

    ```text
    New password:
    Retype new password:
    passwd: password updated successfully
    ```

{% include [serial-console-os-dependency-warn](../../../_includes/compute/serial-console-os-dependency-warn.md) %}

## Подключиться с помощью консоли управления {#connect-via-console}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится виртуальная машина.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и в открывшемся списке выберите нужную виртуальную машину.
  1. В меню слева выберите **{{ ui-key.yacloud.compute.instance.switch_console }}**.
  1. В верхней части экрана в раскрывающемся списке выберите [последовательный порт](../../concepts/serial-console.md#serial-ports), используемый серийной консолью для подключения к ВМ.

      {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

  1. В открывшемся окне серийной консоли введите имя пользователя и пароль, заданные [ранее](#before-you-begin).

{% endlist %}

{% note warning %}

{% include [disable-serial-console-tip](../../../_includes/compute/disable-serial-console-tip.md) %}

{% endnote %}

## Подключиться с помощью стандартного SSH-клиента {#connect-with-ssh-client}

{% note alert %}

{% include [key-without-password-alert](../../../_includes/compute/key-without-password-alert.md) %}

{% endnote %}

Убедитесь, что на вашем компьютере установлен и настроен интерфейс [{{ yandex-cloud }} CLI](../../../cli/index.yaml).

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

Дальнейший порядок действий по подключению зависит от того, включен ли для ВМ доступ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Если для ВМ [включен](../vm-connect/enable-os-login.md) доступ по {{ oslogin }}, подключиться к серийной консоли можно с использованием экспортированного SSH-сертификата. Для подключения к ВМ с выключенным доступом по {{ oslogin }} используются [SSH-ключи](../../../glossary/ssh-keygen.md).

{% list tabs group=os_login_type %}

- По SSH-ключу {#ssh-key}

  1. {% include [enable-metadata-serial-console-auth](../../../_includes/compute/enable-metadata-serial-console-auth.md) %}
  1. Подключитесь к серийной консоли виртуальной машины:

      ```bash
      ssh -t \
        -p 9600 \
        -o IdentitiesOnly=yes \
        -i <путь_к_закрытому_SSH-ключу> \
        <идентификатор_ВМ>.<имя_пользователя>.port=1@{{ serial-ssh-host }}
      ```

      Где:

      * `путь_к_закрытому_SSH-ключу` — путь к закрытой части [SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), который вы используете для подключения к ВМ.
      * `идентификатор_ВМ` — идентификатор виртуальной машины.
      * `имя_пользователя` — имя пользователя для подключения по SSH, указанное в метаданных ВМ.
      * `port=1` — номер [последовательного порта](../../concepts/serial-console.md#serial-ports), используемого серийной консолью для подключения к ВМ.

          {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные [ранее](#before-you-begin) логин и пароль, после чего вы получите доступ к виртуальной машине.
  1. {% include [serial-console-endgame](../../../_includes/compute/serial-console-endgame.md) %}

- По сертификату через {{ oslogin }} {#ssh-cert}

  1. {% include [enable-os-login-serial-console-auth](../../../_includes/compute/enable-os-login-serial-console-auth.md) %}
  1. [Экспортируйте](../vm-connect/os-login-export-certificate.md) сертификат {{ oslogin }}, указав [идентификатор](../../../organization/operations/organization-get-id.md) вашей организации:

      ```bash
      yc compute ssh certificate export \
        --organization-id <идентификатор_организации>
      ```

      Результат:

      ```text
      Identity: /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername
      Certificate: /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername-cert.pub
      ```

      Экспортированный сертификат действителен один час.
  1. Подключитесь к серийной консоли виртуальной машины:

      ```bash
      ssh -t \
        -p 9600 \
        -i <путь_к_SSH-сертификату> \
        <идентификатор_ВМ>.<логин_пользователя_OS_Login>.port=1@{{ serial-ssh-host }}
      ```

      Где:
      * `<путь_к_SSH-сертификату>` — путь к экспортированному ранее SSH-сертификату (`Identity`).
      * `<идентификатор_ВМ>` — идентификатор виртуальной машины.
      * `<имя_пользователя_OS_Login>` — логин пользователя {{ oslogin }} в организации. Логин пользователя {{ oslogin }} указан в конце имени экспортированного сертификата после [идентификатора](../../../organization/operations/organization-get-id.md) организации.

          Также логин пользователя можно получить с помощью команды `yc organization-manager os-login profile list` [{{ yandex-cloud }} CLI](../../../cli/cli-ref/organization-manager/cli-ref/oslogin/profile/list.md) или в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) в профиле пользователя на вкладке **{{ ui-key.yacloud_org.user.title_oslogin-profiles }}**.

          {% note info %}
          
          {% include [os-login-profile-tab-access-notice](../../../_includes/organization/os-login-profile-tab-access-notice.md) %}

          {% endnote %}

      * `port=1` — номер [последовательного порта](../../concepts/serial-console.md#serial-ports), используемого серийной консолью для подключения к ВМ.

          {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные [ранее](#before-you-begin) логин и пароль, после чего вы получите доступ к виртуальной машине.
  1. {% include [serial-console-endgame](../../../_includes/compute/serial-console-endgame.md) %}

{% endlist %}

{% note warning %}

{% include [disable-serial-console-tip](../../../_includes/compute/disable-serial-console-tip.md) %}

{% endnote %}

## Подключиться с помощью {{ yandex-cloud }} CLI {#connect-with-yc-cli}

{% note alert %}

{% include [key-without-password-alert](../../../_includes/compute/key-without-password-alert.md) %}

{% endnote %}

Убедитесь, что на вашем компьютере установлен и настроен интерфейс [{{ yandex-cloud }} CLI](../../../cli/index.yaml).

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

Дальнейший порядок действий по подключению зависит от того, включен ли для ВМ доступ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Если для ВМ [включен](../vm-connect/enable-os-login.md) доступ по {{ oslogin }}, подключение к серийной консоли происходит с использованием короткоживущих SSH-сертификатов. Для подключения к ВМ с выключенным доступом по {{ oslogin }} используются [SSH-ключи](../../../glossary/ssh-keygen.md).

{% list tabs group=os_login_type %}

- По SSH-ключу {#ssh-key}

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```
  1. {% include [enable-metadata-serial-console-auth](../../../_includes/compute/enable-metadata-serial-console-auth.md) %}
  1. Подключитесь к серийной консоли виртуальной машины:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ> \
        --ssh-key <путь_к_закрытому_SSH-ключу> \
        --port 1
      ```

      Где:
      * `--instance-name` — имя виртуальной машины. Вместо имени ВМ вы можете передать ее идентификатор в параметре `--instance-id`.
      * `--ssh-key` — путь к закрытому ключу для [SSH-доступа](../../../glossary/ssh-keygen.md) к ВМ, например `~/.ssh/id_ed25519`.
      * `--port` — номер [последовательного порта](../../concepts/serial-console.md#serial-ports), используемого серийной консолью для подключения к ВМ.

          {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к виртуальной машине.

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).
  1. {% include [serial-console-endgame](../../../_includes/compute/serial-console-endgame.md) %}

- По сертификату через {{ oslogin }} {#ssh-cert}

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```
  1. {% include [enable-os-login-serial-console-auth](../../../_includes/compute/enable-os-login-serial-console-auth.md) %}
  1. Подключитесь к серийной консоли виртуальной машины:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ> \
        --port 1
      ```

      Где:
      
      * `--instance-name` — имя виртуальной машины. Вместо имени ВМ можно передать ее идентификатор в параметре `--instance-id`.
      * `--port` — номер [последовательного порта](../../concepts/serial-console.md#serial-ports), используемого серийной консолью для подключения к ВМ.

          {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к виртуальной машине.

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).
  1. {% include [serial-console-endgame](../../../_includes/compute/serial-console-endgame.md) %}

{% endlist %}

{% note warning %}

{% include [disable-serial-console-tip](../../../_includes/compute/disable-serial-console-tip.md) %}

{% endnote %}

## Решение проблем при подключении {#troubleshooting-ssh}

* Если после подключения к серийной консоли на экране ничего не отображается:
    * Нажмите на клавиатуре клавишу **Enter**.
    * Перезапустите ВМ (для ВМ, созданных до 22 февраля 2019 года).
* Если при подключении с помощью SSH-ключа возникает ошибка `Warning: remote host identification has changed!`, выполните команду `ssh-keygen -R <IP-адрес_ВМ>`.
* Если при подключении с помощью SSH-сертификата возникает ошибка `Permission denied (publickey).`, убедитесь, что для ВМ включена авторизация по {{ oslogin }} при подключении к серийной консоли, а сертификат — не просрочен. При необходимости включите для ВМ авторизацию по {{ oslogin }} при подключении к серийной консоли или повторно экспортируйте SSH-сертификат.
* Если при подключении с помощью SSH-сертификата возникает ошибка `Connection closed by 2a0d:d6c1:0:**::*** port 9600`, на локальной машине откройте файл `known_hosts` и удалите все строки, которые начинаются с `[serialssh.cloud.yandex.net]:9600`. Затем повторите подключение и на вопрос `Are you sure you want to continue connecting (yes/no/[fingerprint])?` ответьте `yes`.

#### См. также {#see-also}

* [{#T}](../../concepts/serial-console.md)
* [{#T}](./index.md)
* [{#T}](./windows-sac.md)