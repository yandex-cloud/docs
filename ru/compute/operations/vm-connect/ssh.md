
# Подключиться к виртуальной машине Linux по SSH

Для подключения к [ВМ](../../concepts/vm.md) по [SSH](../../../glossary/ssh-keygen.md) используется пара ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Этот способ безопаснее, чем подключение по логину и паролю.

Чтобы другой пользователь мог подключиться к ВМ, добавьте для него SSH-ключ по [инструкции](#vm-authorized-keys).

{% note info %}

При создании ВМ с доступом по [{{ oslogin }}](./os-login.md) указывайте SSH-ключи в [метаданных](../../concepts/metadata/sending-metadata.md). Так вы сможете [подключиться к ВМ по SSH](#vm-connect), даже если отключите для нее доступ по {{ oslogin }}.

{% endnote %}

Чтобы подключиться к ВМ Linux по SSH:

1. [Создайте пару SSH-ключей](#creating-ssh-keys).
1. [Скопируйте открытый ключ](#copy-key) в поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** на странице создания ВМ.
1. [Подключитесь к ВМ](#vm-connect).


Обучающее видео поможет вам подключиться к ВМ Linux по SSH:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvujof7tlqigs4ufgs?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=0Q4kivQo0g4&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=10&pp=iAQB).



- Windows 10/11 {#windows}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvfxj66n2cs7nlgbzd?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=M7m75y80VFM&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=11&pp=iAQB).



- Windows 7/8 {#windows7-8}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvmhu4vhxduzmdtmdk?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=rNA-bEbSHZ8&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=12&pp=iAQB).



{% endlist %}


## Создание пары ключей SSH {#creating-ssh-keys}

{% list tabs group=operating_system %}

- Консоль управления {#console}

  {% include [vm-ssh-prepare-key-console](../../../_includes/vm-ssh-prepare-key-console.md) %}

- Linux/macOS {#linux-macos}

  {% include [vm-ssh-prepare-key-linux-macos](../../../_includes/vm-ssh-prepare-key-linux-macos.md) %}

- Windows 10/11 {#windows}

  {% include [vm-ssh-prepare-key-win-10-11](../../../_includes/vm-ssh-prepare-key-win-10-11.md) %}

- Windows 7/8 {#windows7-8}

  {% include [vm-ssh-prepare-key-win-7-8](../../../_includes/vm-ssh-prepare-key-win-7-8.md) %}

{% endlist %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к ВМ будет невозможно.

{% endnote %}

## Копирование открытого ключа в буфер обмена {#copy-key}

[Созданный ранее](#creating-ssh-keys) открытый ключ имеет следующий формат:

```text
<тип_ключа> <тело_открытого_ключа> <опциональный_комментарий>
```

Пример:

> ```text
> ssh-ed25519 AAAAC3NzaC1lZDI1NTE5ABFLIFyapYheN7OZNhTaNqEHefjmU5mtzK********+gRPCz user@Desktop
> ```

{% note tip %}

Блок `<опциональный_комментарий>` не используется при SSH-подключении, вы можете не копировать его.

{% endnote %}

Откройте файл `<имя_ключа>.pub` с помощью любого текстового редактора, например Notepad, и скопируйте из него ключ. Ключ должен быть записан одной строкой (не должно быть переносов и разрывов строки).

Ключ можно скопировать и с помощью командной строки:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  В терминале скопируйте ключ одним из следующих способов:

    * Вручную. Для этого выведите на экран содержимое файла:

        ```bash
        cat <путь_к_файлу_ключа>/<имя_ключа>.pub
        ```

        Открытый ключ будет выведен на экран. Скопируйте его в буфер обмена.

    * При помощи соответствующей команды:

        * Для Linux: `cat <путь_к_файлу_ключа>/<имя_ключа>.pub | xclip -selection clipboard`.
        * Для macOS: `cat <путь_к_файлу_ключа>/<имя_ключа>.pub | pbcopy`.

        Указанные выше команды копируют все содержимое файла, в том числе опциональный комментарий.

- Windows {#windows}

  1. Запустите `cmd.exe` или `powershell.exe`.
  1. Скопируйте ключ одним из следующих способов:

      * Вручную. Для этого выведите на экран содержимое файла:

          ```shell
          type <путь_к_файлу_ключа>\<имя_ключа>.pub
          ```

          Открытый ключ будет выведен на экран. Скопируйте его в буфер обмена.

      * При помощи соответствующей команды:

          ```shell
          type <путь_к_файлу_ключа>\<имя_ключа>.pub | clip
          ```

          Указанная выше команда копирует все содержимое файла, в том числе опциональный комментарий.

{% endlist %}

После этого вставьте открытый ключ в поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** при создании ВМ через [консоль управления]({{ link-console-main }}).

## Подключение к ВМ {#vm-connect}

Вы можете подключиться к ВМ в статусе `RUNNING` по протоколу SSH. Для инициализации всех служб после [запуска](../vm-control/vm-stop-and-start.md#start) ВМ может потребоваться время. Если возникла ошибка соединения, попробуйте снова через несколько минут.

[Группы безопасности](../../../vpc/concepts/security-groups.md) ВМ должны разрешать входящий трафик по протоколу TCP на порт 22.

Для подключения необходимо указать [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ. Публичный IP-адрес можно узнать в консоли управления, в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ. Если вы создали ВМ только с внутренним IP-адресом, [привяжите к ней публичный IP-адрес](../vm-control/vm-attach-public-ip.md).

Также можно использовать [внутренние IP-адреса](../../../vpc/concepts/address.md#internal-addresses) и [FQDN](../../../vpc/concepts/address.md#fqdn) для установки SSH-соединения между ВМ внутри одной [облачной сети](../../../vpc/concepts/network.md#network) {{ yandex-cloud }}.

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  В терминале выполните команду:

  ```bash
  ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  Где `<имя_пользователя>` — имя учетной записи пользователя ВМ. Если ВМ создавалась через CLI, то пользователь по умолчанию — `yc-user`.

  Если у вас несколько закрытых ключей, укажите нужный:

  ```bash
  ssh -i <путь_к_ключу/имя_файла_ключа> <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  При первом подключении к ВМ появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
  ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в терминале слово `yes` и нажмите **Enter**.

- Windows 10/11 {#windows}

  Убедитесь, что учетная запись Windows обладает правами на чтение файлов в папке с ключами.

  Для подключения к ВМ в командной строке выполните команду:

  ```shell
  ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  Где `<имя_пользователя>` — имя учетной записи пользователя ВМ. Если ВМ создавалась через CLI, то пользователь по умолчанию — `yc-user`.

  Если у вас несколько закрытых ключей, укажите нужный:

  ```shell
  ssh -i <путь_к_ключу\имя_файла_ключа> <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  При первом подключении к ВМ появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
  ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в командной строке `yes` и нажмите **Enter**.

- Windows 7/8 {#windows7-8}

  Установите соединение с помощью приложения PuTTY:
  1. Запустите приложение Pageant.
     1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
     1. В контекстном меню выберите пункт **Add key**.
     1. Выберите сгенерированный PuTTY приватный ключ в формате `.ppk`. Если для ключа задан пароль, введите его.
  1. Запустите приложение PuTTY.
     1. В поле **Host Name (or IP address)** введите публичный IP-адрес ВМ, к которой вы хотите подключиться. Укажите порт `22` и тип соединения **SSH**.

        ![ssh_add_ip](../../../_assets/compute/ssh-putty/ssh_add_ip.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth**.
     1. Установите флаг **Allow agent forwarding**.

        ![ssh_choose_private_key](../../../_assets/compute/ssh-putty/authentication_parameters.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth** → **Credentials**.

     1. В поле **Private key file for authentication** выберите файл с приватным ключом.

        ![ssh_choose_private_key](../../../_assets/compute/ssh-putty/ssh_choose_private_key.png)

     1. Вернитесь в меню **Sessions**. В поле **Saved sessions** введите любое название для сессии и нажмите кнопку **Save**. Настройки сессии сохранятся под указанным именем. Вы сможете использовать этот профиль сессии для подключения с помощью Pageant.

        ![ssh_save_session](../../../_assets/compute/ssh-putty/ssh_save_session.png)

     1. Нажмите кнопку **Open**. Если вы подключаетесь к ВМ в первый раз, может появиться предупреждение о неизвестном хосте:

        ![ssh_unknown_host_warning](../../../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

        Нажмите кнопку **Accept**. Откроется окно терминала с предложением ввести логин пользователя, от имени которого устанавливается соединение. Введите имя пользователя, которое вы указали при создании ВМ, и нажмите **Enter**. Если ВМ создавалась через CLI, то пользователь по умолчанию — `yc-user`.

        Если все настроено верно, будет установлено соединение с сервером.

        ![ssh_login](../../../_assets/compute/ssh-putty/ssh_login.png)

  Если вы сохранили профиль сессии в PuTTY, в дальнейшем для установки соединения можно использовать Pageant:
  1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
  1. Выберите пункт меню **Saved sessions**.
  1. В списке сохраненных сессий выберите нужную сессию.

- {{ cloud-shell-full-name }} {#console}

  {% include [cloud-shell-connect](../../_includes_service/cloud-shell-connect.md) %}

{% endlist %}

О решении проблем при подключении читайте в разделе [Вопросы и ответы](../../qa/connection.md).

## Добавление SSH-ключей для других пользователей {#vm-authorized-keys}

Вы можете добавить SSH-ключи для другого пользователя ВМ. Для этого нужно создать нового пользователя и добавить для него файл с авторизованными ключами.

Чтобы создать одновременно нескольких пользователей с ключами, используйте [метаданные](../../concepts/metadata/sending-metadata.md).

Чтобы настроить пользователей изнутри ВМ, воспользуйтесь инструкцией:

1. [Подключитесь](#vm-connect) к ВМ от имени пользователя, которого вы указали при создании ВМ в консоли управления.

    {% note info %}

    Получить информацию о ВМ вместе с пользовательскими метаданными можно с помощью команды:

    ```bash
    yc compute instance get --full <имя_ВМ>
    ```

    {% endnote %}

1. Создайте нового пользователя `testuser` и укажите для него оболочку `bash` для использования по умолчанию:

    ```bash
    sudo useradd -m -d /home/testuser -s /bin/bash testuser
    ```

1. Переключитесь на созданного пользователя:

    ```bash
    sudo su - testuser
    ```

1. Создайте папку `.ssh` в домашней директории нового пользователя:

    ```bash
    mkdir .ssh
    ```

1. Создайте в папке `.ssh` файл `authorized_keys`:

    ```bash
    touch .ssh/authorized_keys
    ```

1. Добавьте в файл `authorized_keys` открытый ключ нового пользователя:

    ```bash
    echo "<открытый_ключ>" >> /home/testuser/.ssh/authorized_keys
    ```

1. Измените права доступа к файлу `authorized_keys` и каталогу `.ssh`:

    ```bash
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys
    ```

1. Отключитесь от ВМ командой `exit`.
1. [Перезапустите ВМ](../vm-control/vm-stop-and-start.md#restart).
1. Проверьте подключение для нового пользователя:

   ```bash
   ssh testuser@<публичный_IP-адрес_ВМ>
   ```

#### Что дальше {#what-is-next}

* [Узнайте, как работать с {{ yandex-cloud }} изнутри ВМ](auth-inside-vm.md).

#### См. также {#see-also}

* [{#T}](cloud-shell.md)
* [{#T}](rdp.md)
* [{#T}](powershell.md)
* [{#T}](os-login.md)
