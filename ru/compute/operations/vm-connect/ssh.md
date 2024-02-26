---
title: "Как подключиться к виртуальной машине Linux по SSH"
description: "Следуя данной инструкции, вы сможете подключиться к ВМ с помощью пары ключей SSH: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя."
---

# Подключиться к виртуальной машине Linux по SSH

Рекомендуемый способ подключения к [ВМ](../../concepts/vm.md) по [SSH](../../../glossary/ssh-keygen.md) основан на использовании пары ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Чтобы другой пользователь мог подключиться к ВМ, добавьте для него SSH-ключ по [инструкции](#vm-authorized-keys). Подключение с помощью пары ключей более безопасно, чем подключение по логину и паролю.

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

Вы не сможете подключиться к ВМ с включенным [доступом через OS Login](./os-login.md) с помощью пары SSH-ключей. При этом рекомендуется в любом случае указывать SSH-ключи при создании ВМ: так вы сможете [подключиться к ВМ по SSH](#vm-connect), если отключите для нее доступ через OS Login.


Обучающее видео поможет вам подключиться к ВМ Linux по SSH:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  @[youtube](https://www.youtube.com/watch?v=0Q4kivQo0g4&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=10&pp=iAQB)

- Windows 10 {#windows}

  @[youtube](https://www.youtube.com/watch?v=M7m75y80VFM&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=11&pp=iAQB)

- Windows 7/8 {#windows7-8}

  @[youtube](https://www.youtube.com/watch?v=rNA-bEbSHZ8&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=12&pp=iAQB)

{% endlist %}


## Создание пары ключей SSH {#creating-ssh-keys}

{% include [vm-ssh-prepare-key](../../../_includes/vm-ssh-prepare-key.md) %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к ВМ будет невозможно.

{% endnote %}

## Копирование публичного ключа в буфер обмена {#copy-key}

Скопируйте ключ из файла `<имя_ключа>.pub` с помощью любого текстового редактора, например Notepad. Обратите внимание, что ключ должен быть записан **одной строкой** (не должно быть переносов и разрывов строки).

Ключ можно скопировать и с помощью командной строки:

{% list tabs group=operating_system %}

- Linux {#linux-macos}

  1. Запустите терминал.
  1. Выведите на экран содержимое файла:

     ```bash
     cat ~/.ssh/<имя_ключа>.pub
     ```

     Где `<имя_ключа>` — название ключа, например, `id_ed25519` или `id_rsa`.

     Открытый ключ будет выведен на экран. Выделите текст и скопируйте его в буфер обмена. Например: `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5ABFLIFyapYheN7OZNhTaNqEHefjmU5mtzK********+gRPCz user@Desktop`.
  1. Можно сразу скопировать содержимое файла в буфер обмена:

     ```bash
     cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
     ```

     Вставьте открытый ключ в поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** при создании ВМ через [консоль управления]({{ link-console-main }}).

- macOS {#macos}

  1. Запустите терминал.
  1. Выведите на экран содержимое файла:

     ```bash
     cat ~/.ssh/<имя_ключа>.pub
     ```

     Где `<имя_ключа>` — название ключа, например, `id_ed25519` или `id_rsa`.

     Открытый ключ будет выведен на экран. Выделите текст и скопируйте его в буфер обмена. Например: `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5ABFLIFyapYheN7OZNhTaNqEHefjmU5mtzK********+gRPCz user@Desktop`.
  1. Можно сразу скопировать содержимое файла в буфер обмена:

     ```bash
     cat ~/.ssh/id_ed25519.pub | pbcopy
     ```

     Вставьте открытый ключ в поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** при создании ВМ через [консоль управления]({{ link-console-main }}).

- Windows {#windows}

  1. Запустите `cmd.exe` или `powershell.exe`.
  1. Выведите на экран содержимое файла:

     ```bash
     type C:\Users\<имя_пользователя>\.ssh\<имя_ключа>.pub
     ```

     Где:
     * `<имя_пользователя>` — название вашей учетной записи Windows, например, `User`.
     * `<имя_ключа>` — название ключа, например, `id_ed25519` или `id_rsa`.

     Открытый ключ будет выведен на экран. Чтобы скопировать ключ, выделите его и нажмите правую кнопку мыши. Например: `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5ABFLIFyapYheN7OZNhTaNqEHefjmU5mtzK********+gRPCz`.
  1. Можно сразу скопировать содержимое файла в буфер обмена:

     ```bash
     type C:\Users\User\.ssh\id_ed25519.pub | clip
     ```

     Вставьте открытый ключ в поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** при создании ВМ через [консоль управления]({{ link-console-main }}).

{% endlist %}

## Подключение к ВМ {#vm-connect}

Вы можете подключиться к ВМ в статусе `RUNNING` по протоколу SSH. Для инициализации всех служб после [запуска](../vm-control/vm-stop-and-start.md#start) ВМ может потребоваться время. Если возникла ошибка соединения, попробуйте снова через несколько минут.

Для подключения можно использовать утилиту `ssh` в Linux/macOS/Windows 10 и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows 7/8.

[Группы безопасности](../../../vpc/concepts/security-groups.md) ВМ должны разрешать входящий трафик по протоколу TCP на порт 22.

Для подключения необходимо указать [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ. Публичный IP-адрес можно узнать в консоли управления в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ. Если вы создали ВМ только с внутренним IP-адресом, [привяжите к ней публичный IP-адрес](../vm-control/vm-attach-public-ip.md).

Также можно использовать [внутренние IP-адреса](../../../vpc/concepts/address.md#internal-addresses) и [FQDN](../../../vpc/concepts/address.md#fqdn) для установки SSH-соединения между ВМ внутри одной [облачной сети](../../../vpc/concepts/network.md#network) {{ yandex-cloud }}.

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  В терминале выполните команду:

  ```bash
  ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  Где `<имя_пользователя>` — имя учетной записи пользователя ВМ.

  Если у вас несколько закрытых ключей, укажите нужный:

  ```bash
  ssh -i <путь_к_ключу/имя_файла_ключа> <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  При первом подключении к ВМ появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '130.193.40.101 (130.193.40.101)' can't be established.
  ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
  Are you sure you want to continue connecting (yes/no)?
  ```

  Введите в терминале слово `yes` и нажмите **Enter**.

- Windows 10 {#windows}

  Убедитесь, что учетная запись Windows обладает правами на чтение файлов в папке с ключами.

  Для подключения к ВМ в командной строке выполните команду:

  ```shell
  ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  Где `<имя_пользователя>` — имя учетной записи пользователя ВМ.

  Если у вас несколько закрытых ключей, укажите нужный:

  ```shell
  ssh -i <путь_к_ключу\имя_файла_ключа> <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  При первом подключении к ВМ появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '130.193.40.101 (130.193.40.101)' can't be established.
  ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
  Are you sure you want to continue connecting (yes/no)?
  ```

  Введите в командной строке `yes` и нажмите **Enter**.

- Windows 7/8 {#windows7-8}

  В Windows соединение устанавливается с помощью приложения PuTTY.
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

        Нажмите кнопку **Accept**. Откроется окно терминала с предложением ввести логин пользователя, от имени которого устанавливается соединение. Введите имя пользователя, которое вы указали при создании ВМ и нажмите **Enter**. Если все настроено верно, будет установлено соединение с сервером.

        ![ssh_login](../../../_assets/compute/ssh-putty/ssh_login.png)

  Если вы сохранили профиль сессии в PuTTY, в дальнейшем для установки соединения можно использовать Pageant:
  1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
  1. Выберите пункт меню **Saved sessions**.
  1. В списке сохраненных сессий выберите нужную сессию.

{% endlist %}

## Добавление SSH-ключей для других пользователей {#vm-authorized-keys}

Вы можете добавить SSH-ключи для другого пользователя ВМ. Для этого нужно создать нового пользователя и добавить для него файл с авторизованными ключами.
1. [Подключитесь](#vm-connect) к ВМ от имени пользователя, которого вы указали при создании ВМ в консоли управления. Если ВМ создавалась через CLI, то пользователь по умолчанию `yc-user`.

   {% note info %}

   Получить информацию о ВМ вместе с пользовательскими метаданными можно с помощью команды:

   ```bash
   yc compute instance get --full <имя_ВМ>
   ```

   {% endnote %}

1. Создайте нового пользователя и укажите для него оболочку `bash` для использования по умолчанию:

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

1. Добавьте в файл `authorized_keys` публичный ключ нового пользователя:

   ```bash
   echo "<публичный_ключ>" > /home/testuser/.ssh/authorized_keys
   ```

1. Измените права доступа к файлу `authorized_keys` и каталогу `.ssh`:

   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/authorized_keys
   ```

1. Отключитесь от ВМ командой `exit`.
1. Перезапустите ВМ.
1. Проверьте подключение для нового пользователя:

   ```bash
   ssh testuser@<публичный_IP-адрес_ВМ>
   ```

#### Что дальше {#what-is-next}

* [Узнайте, как работать с {{ yandex-cloud }} изнутри ВМ](auth-inside-vm.md).
