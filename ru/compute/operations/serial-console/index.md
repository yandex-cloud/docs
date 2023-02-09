# Начало работы с серийной консолью

Серийная консоль — это способ получить доступ к виртуальной машине вне зависимости от состояния сети или операционной системы. Таким образом, вы можете использовать консоль, например, для устранения неисправностей ВМ или при возникновении проблем с доступом через SSH.

По умолчанию доступ к серийной консоли отключен.

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

## Перед началом работы {#before-you-begin}

Перед тем, как включить доступ к серийной консоли на ВМ:

1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на ВМ. Серийная консоль аутентифицирует пользователей с помощью SSH-ключей.

1. Создайте текстовый файл (например, `sshkeys.txt`) и укажите следующие данные:

   ```txt
   <имя пользователя>:<открытый SSH-ключ пользователя>
   ```

   Пример текстового файла для пользователя `yc-user`:

   ```txt
   yc-user:ssh-ed25519 AAAAB3Nza......OjbSMRX yc-user@example.com
   ```

   По умолчанию пользовательские SSH-ключи хранятся в каталоге `~/.ssh` этого пользователя. Получить открытый ключ можно с помощью команды `cat ~/.ssh/<имя открытого ключа>.pub`.

## Включение консоли при создании виртуальной машины из публичного образа {#turn-on-for-new-instance}

Чтобы включить доступ к серийной консоли при создании ВМ, установите в метаданных параметр `serial-port-enable` в значение `1`.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

{% list tabs %}

- Linux

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. Выберите один из публичных образов на базе ОС Linux (например, Ubuntu).

     {% include [standard-images](../../../_includes/standard-images.md) %}

  1.  Создайте ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts \
        --metadata-from-file ssh-keys=sshkeys.txt \
        --metadata serial-port-enable=1
      ```

      Команда создаст ВМ:
      * С OC Ubuntu.
      * С именем `first-instance`.
      * В зоне `{{ region-id }}-a`.
      * С активной серийной консолью.

      В ОС ВМ будет автоматически создан пользователь `yc-user` с указанным открытым ключом.

{% if product == "cloud-il" %}

- Windows

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. Выберите публичный образ на базе ОС Windows.

     {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Создайте ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance create \
        --name win-instance \
        --metadata-from-file user-data=metadata.yaml \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=default-c,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
        --metadata serial-port-enable=1
      ```

      Команда создаст ВМ:
      * С OC Windows.
      * С именем `win-instance`.
      * В зоне `{{ region-id }}-a`.
      * С активной серийной консолью.

      В ОС ВМ будет автоматически создан пользователь `Administrator` с паролем, указанном в файле `metadata.yaml`.

{% endif %}

{% endlist %}

## Включение консоли при изменении виртуальной машины {#turn-on-for-current-instance}

Чтобы включить доступ к серийной консоли при изменении ВМ, установите в метаданных параметр `serial-port-enable` в значение `1`.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Получите список ВМ в каталоге по умолчанию:

   {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.

1. Установите в метаданных ВМ параметр `serial-port-enable=1`:

   ```bash
   yc compute instance add-metadata \
     --name first-instance \
     --metadata-from-file ssh-keys=sshkeys.txt \
     --metadata serial-port-enable=1
   ```

   Команда запустит операцию активации серийной консоли на ВМ с именем `first-instance`.

## Настройка виртуальной машины для доступа через серийный порт {#configuration}

Для настройки доступа через серийную консоль у виртуальной машины должен быть публичный IP-адрес. Вы можете посмотреть адрес в [консоли управления]({{ link-console-main }}) в разделе **Compute Cloud** на странице **Виртуальные машины**. Если вы создали виртуальную машину без публичного IP-адреса, вы можете [привязать его](../vm-control/vm-attach-public-ip.md). После настройки адрес можно отвязать, для подключения через серийную консоль он не нужен.

Чтобы серийная консоль была доступна со стороны ОС, ОС должна быть настроена соответствующим образом:
* [Linux](#linux-configuration)
{% if product == "cloud-il" %}* [Windows](#windows-configuration){% endif %}

### Linux {#linux-configuration}

Чтобы подключаться к серийной консоли Linux, убедитесь, что [отключена парольная аутентификация для SSH](#ssh-pass-off), и при необходимости [задайте пароль](#create-pass) для нужного пользователя ОС.

#### Отключите SSH-авторизацию по паролю {#ssh-pass-off}

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

Если вы используете собственный образ, убедитесь, что доступ по SSH с использованием логина и пароля отключен.

Чтобы отключить парольную аутентификацию по SSH:
1. Откройте файл конфигурации SSH-сервера, по умолчанию `/etc/ssh/sshd_config`. Файл доступен для чтения и редактирования только суперпользователю.
1. Задайте для опции `PasswordAuthentication` значение `no`.
1. Перезапустите SSH-сервер:

   ```bash
   sudo systemctl restart ssh
   ```

#### Создайте пароль для пользователя Linux {#create-pass}

Некоторые ОС могут запрашивать данные пользователя для доступа на ВМ. Поэтому перед подключением к таким ВМ необходимо создать локальный пароль для пользователя по умолчанию.

Чтобы создать локальный пароль, используйте CLI.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Получите список ВМ в каталоге по умолчанию:

   {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.

1. Получите публичный IP-адрес ВМ.

   ```bash
   yc compute instance get first-instance
   ```

   В выводе команды найдите адрес ВМ в блоке `one_to_one_nat`:

   ```bash
   ...
   one_to_one_nat:
     address: <публичный IP-адрес>
     ip_version: IPV4
   ...
   ```

1. Подключитесь к ВМ. Подробнее читайте в разделе [{#T}](../vm-connect/ssh.md#vm-connect).

1. Создайте локальный пароль. В OC Linux задать пароль можно с помощью команды `passwd`:

   ```bash
   sudo passwd <имя пользователя>
   ```

   Пример для пользователя `yc-user`:

   ```bash
   sudo passwd yc-user
   ```

1. Завершите SSH-сессию с помощью команды `exit`.

{% if product == "cloud-il" %}

### Windows {#windows-configuration}

Аналог серийной консоли в Windows — специальная административная консоль (Special Administration Console, SAC).

{% note info %}

Если ваша ВМ была создана после 22 февраля 2019 года, дополнительно настраивать ничего не нужно — SAC включена по умолчанию.

{% endnote %}

Если ваша ВМ была создана до 22 февраля 2019 года, для подключения к SAC нужно изменить реестр Windows:

1. [Подключитесь к ВМ по RDP](../vm-connect/rdp.md).

1. Запустите командную строку или PowerShell и выполните:

   ```
   bcdedit /ems "{current}" on
   The operation completed successfully.

   bcdedit /emssettings EMSPORT:2 EMSBAUDRATE:115200
   The operation completed successfully.
   ```

1. Перезагрузите ВМ.

Подробнее о работе [командной оболочки в Windows SAC](windows-sac.md).

{% endif %}
