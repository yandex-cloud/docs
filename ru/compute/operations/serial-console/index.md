# Начало работы с серийной консолью

Серийная консоль — это способ получить доступ к [виртуальной машине](../../concepts/vm.md) вне зависимости от состояния [сети](../../../vpc/concepts/network.md#network) или операционной системы. Таким образом, вы можете использовать консоль, например, для устранения неисправностей ВМ или при возникновении проблем с доступом через [SSH](../../../glossary/ssh-keygen.md).

Для работы с серийной консолью необходима [роль](../../security/index.md) `сompute.admin` или `{{ roles-editor }}`.

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

## Включение консоли при создании ВМ из публичного образа {#turn-on-for-new-instance}

Чтобы включить доступ к серийной консоли при создании ВМ, установите в [метаданных](../../concepts/vm-metadata.md) параметр `serial-port-enable` в значение `1`.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. Выберите один из публичных [образов](../../concepts/image.md) на базе ОС Linux (например, Ubuntu).

     {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

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
     * С OC [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os).
     * С именем `first-instance`.
     * В [зоне доступности](../../../overview/concepts/geo-scope.md) `{{ region-id }}-a`.
     * С активной серийной консолью.

     В ОС ВМ будет автоматически создан пользователь `yc-user` с указанным открытым ключом.


{% endlist %}

## Включение консоли при изменении ВМ {#turn-on-for-current-instance}

Чтобы включить доступ к серийной консоли при изменении ВМ, установите в метаданных параметр `serial-port-enable` в значение `1`.
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

## Настройка ВМ для доступа через серийный порт {#configuration}

Для настройки доступа через серийную консоль у ВМ должен быть [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Вы можете посмотреть адрес в [консоли управления]({{ link-console-main }}) в разделе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** на странице **{{ ui-key.yacloud.compute.switch_instances }}**. Если вы создали ВМ без публичного IP-адреса, вы можете [привязать его](../vm-control/vm-attach-public-ip.md). После настройки адрес можно отвязать, для подключения через серийную консоль он не нужен.

Чтобы серийная консоль была доступна со стороны ОС, ОС должна быть настроена соответствующим образом:
* [Linux](#linux-configuration)


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

