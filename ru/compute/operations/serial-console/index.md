# Начало работы с серийной консолью

Серийная консоль — это способ получить доступ к виртуальной машине вне зависимости от состояния сети или операционной системы. Таким образом, вы можете использовать консоль, например, для устранения неисправностей виртуальных машин или при возникновении проблем с доступом через SSH.

По умолчанию доступ к серийной консоли отключен.

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

## Перед началом работы {#before-you-begin}

Перед тем, как включить доступ к серийной консоли на виртуальной машине:

1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину. Серийная консоль аутентифицирует пользователей с помощью SSH-ключей.

1. Создайте текстовый файл (например, `sshkeys.txt`) и укажите следующие данные:

   ```txt
   <имя пользователя>:<открытый SSH-ключ пользователя>
   ```

   Пример текстового файла для пользователя `yc-user`:

   ```txt
   yc-user:ssh-rsa AAAAB3Nza......OjbSMRX yc-user@example.com
   ```

   По умолчанию пользовательские SSH-ключи хранятся в каталоге `~/.ssh` этого пользователя. Получить открытый ключ можно с помощью команды `cat ~/.ssh/<имя открытого ключа>.pub`.

## Включение консоли при создании виртуальной машины из публичного образа {#turn-on-for-new-instance}

Чтобы включить доступ к серийной консоли при создании виртуальной машины, установите в метаданных параметр `serial-port-enable` в значение `1`.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

{% list tabs %}

- Linux

  1. Посмотрите описание команды CLI для создания виртуальной машины:

     ```bash
     $ yc compute instance create --help
     ```

  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) на базе операционной системы Linux (например, Ubuntu).

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1.  Создайте виртуальную машину в каталоге по умолчанию:

      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts \
          --metadata-from-file ssh-keys=sshkeys.txt \
          --ssh-key ~/.ssh/<имя открытого ключа>.pub \
          --metadata serial-port-enable=1
      ```

      Данная команда создаст виртуальную машину:

      - С OC Ubuntu.
      - С именем `first-instance`.
      - В зоне `ru-central1-a`.
      - С активной серийной консолью.

      В ОС виртуальной машины будет автоматически создан пользователь `yc-user` с указанным открытым ключом.

- Windows

  1. Посмотрите описание команды CLI для создания виртуальной машины:

     ```
     $ yc compute instance create --help
     ```

  1. Выберите публичный [образ](../images-with-pre-installed-software/get-list.md) на базе операционной системы Windows.

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1.  Создайте виртуальную машину в каталоге по умолчанию:

      ```
      $ yc compute instance create \
      --name win-instance \
      --metadata-from-file user-data=metadata.yaml \
      --zone ru-central1-c \
      --network-interface subnet-name=default-c,nat-ip-version=ipv4 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata serial-port-enable=1
      ```

      Данная команда создаст виртуальную машину:

      - С OC Windows.
      - С именем `win-instance`.
      - В зоне `ru-central1-c`.
      - С активной серийной консолью.

      В ОС виртуальной машины будет автоматически создан пользователь `Administrator` с паролем, указанном в файле `metadata.yaml`.

{% endlist %}

## Включение консоли при изменении виртуальной машины {#turn-on-for-current-instance}

Чтобы включить доступ к серийной консоли при изменении виртуальной машины, установите в метаданных параметр `serial-port-enable` в значение `1`.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Получите список виртуальных машин в каталоге по умолчанию:

    {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.

1. Установите в метаданных виртуальной машины параметр `serial-port-enable=1`:

   ```
   $ yc compute instance add-metadata \
       --name first-instance \
       --metadata serial-port-enable=1
   ```

   Данная команда запустит операцию активации серийной консоли на машине с именем `first-instance`.

## Настройка виртуальной машины для доступа через серийный порт {#configuration}

Чтобы серийная консоль была доступна со стороны операционной системы, ОС должна быть настроена соответствующим образом:

* [Linux](#linux-configuration)
* [Windows](#windows-configuration)

### Linux {#linux-configuration}

Чтобы подключаться к серийной консоли Linux, убедитесь, что [отключена парольная аутентификация для SSH](#ssh-pass-off), и при необходимости [задайте пароль](#create-pass) для нужного пользователя операционной системы.

#### Отключите SSH-авторизацию по паролю {#ssh-pass-off}

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

Если вы используете собственный образ, убедитесь, что доступ по SSH с использованием логина и пароля отключен.

Чтобы отключить парольную аутентификацию по SSH:

1. Откройте файл конфигурации SSH-сервера, по умолчанию `/etc/ssh/sshd_config`. Файл доступен для чтения и редактирования только суперпользователю.
1. Задайте для опции `PasswordAuthentication` значение `no`.
1. Перезапустите SSH-сервер:

   ```
   $ sudo systemctl restart ssh
   ```

#### Создайте пароль для пользователя Linux {#create-pass}

Некоторые операционные системы могут запрашивать данные пользователя для доступа на виртуальную машину. Поэтому перед подключением к таким машинам необходимо создать локальный пароль для пользователя по умолчанию.

Чтобы создать локальный пароль, используйте CLI.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Получите список виртуальных машин в каталоге по умолчанию:

   {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.

1. Получите публичный IP-адрес виртуальной машины.

   ```
   $ yc compute instance get first-instance
   ```

   В выводе команды найдите адрес виртуальной машины в блоке `one_to_one_nat`:

   ```
   ...
   one_to_one_nat:
       address: <публичный IP-адрес>
       ip_version: IPV4
   ...
   ```

1. Подключитесь к виртуальной машине. Подробнее читайте в разделе [{#T}](../vm-connect/ssh.md#vm-connect).

1. Создайте локальный пароль. В OC Linux задать пароль можно с помощью команды `passwd`:

   ```
   $ sudo passwd <имя пользователя>
   ```

   Пример для пользователя `yc-user`:

   ```
   $ sudo passwd yc-user
   ```

1. Завершите SSH-сессию с помощью команды `exit`.


### Windows {#windows-configuration}

Аналог серийной консоли в Windows — специальная административная консоль (Special Administration Console, SAC).

{% note info %}

Если ваша виртуальная машина была создана после 22 февраля 2019 года, дополнительно настраивать ничего не нужно — SAC включена по умолчанию.

{% endnote %}

Если ваша виртуальная машина была создана до 22 февраля 2019 года, для подключения к SAC нужно изменить реестр Windows:

1. [Подключитесь к виртуальной машине по RDP](../vm-connect/rdp.md).

1. Запустите `cmd` или PowerShell и выполните следующие команды:

   ```
   $ bcdedit /ems "{current}" on
   The operation completed successfully.

   $ bcdedit /emssettings EMSPORT:2 EMSBAUDRATE:115200
   The operation completed successfully.
   ```

1. Перезагрузите виртуальную машину.

{% endlist %}
