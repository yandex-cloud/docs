# GeeseFS

[GeeseFS](https://github.com/yandex-cloud/geesefs) — программа для монтирования бакетов {{ objstorage-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)) в системах Linux, macOS и Windows. Разработана командой {{ yandex-cloud }} как ответвление от [goofys](goofys.md). Она обеспечивает высокую производительность и POSIX-совместимость.

## Функциональность {#features}

### Производительность {#performance}

По сравнению с goofys и [s3fs](s3fs.md) GeeseFS работает с большими количествами малых файлов (размером до 1 МБ) на порядки быстрее, а с большими файлами — на аналогичной скорости или быстрее. Подробнее о тестах производительности см. в [репозитории GeeseFS на GitHub](https://github.com/yandex-cloud/geesefs/tree/master/bench).

Чтобы GeeseFS работала быстрее, в ней реализованы:

* Параллельное опережающее чтение (parallel readahead).
* Эвристическое опережающее чтение при случайном доступе: если размер нескольких запрошенных подряд блоков ниже порога, для следующих запросов GeeseFS будет скачивать из хранилища меньшие блоки.
* Параллельная [составная загрузка](../concepts/multipart.md) объектов в хранилище (parallel multipart upload).
* Оптимизированное изменение объектов: клиент и хранилище обмениваются только измененными частями объекта.
* Фоновая загрузка малых деревьев объектов и [папок](../concepts/object.md#folder): при запросе папки GeeseFS скачает все дерево за одно обращение к хранилищу.
* Асинхронная запись, переименование и удаление объектов.
* Использование дискового кеша для чтения и записи.

### POSIX-совместимость {#posix-compatibility}

Помимо базовых функций из стандартов POSIX (`open`, `read`, `write`, `close` и т. д.), GeeseFS поддерживает следующие возможности:

* Корректное чтение объектов сразу после записи в них (read-after-write consistency).
* Частичная запись (обратите внимание: в [версионируемых](../concepts/versioning.md) бакетах при частичной записи могут появляться промежуточные версии объекта).
* `fsync` — синхронизация содержимого объекта или папки между памятью машины и хранилищем.
* `truncate` — произвольное изменение размера объекта.
* Символические (мягкие) ссылки.
* `xattr` — расширенные атрибуты файлов.
* Переименование папок.
* `readdir` — чтение метаинформации о папках.

### Частичное изменение и дозапись объектов {#patch}

В GeeseFS поддерживается [частичное изменение и дозапись объектов](../concepts/object-patch.md) в бакеты {{ objstorage-name }}.

Чтобы включить частичное изменение объектов, используйте опцию `--enable-patch`.

Подробнее в репозитории GeeseFS на GitHub:
* [Partial object updates](https://github.com/yandex-cloud/geesefs#partial-object-updates-patch) — описание частичного изменения и дозаписи объектов.
* [Concurrent Updates](https://github.com/yandex-cloud/geesefs#concurrent-patch) — описание частичного изменения объекта одновременно несколькими запросами.

### Ограничения {#restrictions}

В GeeseFS не поддерживаются:

* Работа с правами доступа к файлам и папкам, в том числе команды `chmod` и `chown`. 

  При монтировании файловой системы вы можете указать:

  * Права доступа ко всем файлам или папкам в значениях опций `--file-mode` и `--dir-mode` соответственно.
  * Идентификатор пользователя — владельца всех файлов и папок в значении опции `--uid`.
  * Идентификатор группы, к которой относятся все файлы и папки, в значении опции `--gid`.

  Например:

  ```bash
  geesefs \
    --file-mode=0666 \
    --dir-mode=0777 \
    --uid=1000 \
    <имя_бакета> <точка_монтирования>
  ```

* Жесткие ссылки.
* Блокировка файлов.
* Корректное время последнего доступа к файлу (`atime`) и последнего изменения атрибутов файла (`ctime`). В обоих полях всегда содержится время последнего изменения файла — то же, что и в поле `mtime`.
* Создание файлов размером больше 1 ТБ.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

{% list tabs group=operating_system %}

- Debian/Ubuntu {#ubuntu}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     apt list --installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo apt-get install fuse
     ```

  1. Скачайте и установите GeeseFS:

     {% include [geesefs-install-linux](../../_includes/storage/geesefs-install-linux.md) %}

- CentOS {#centos}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     yum list installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo yum install fuse
     ```

  1. Скачайте и установите GeeseFS:

     {% include [geesefs-install-linux](../../_includes/storage/geesefs-install-linux.md) %}

- macOS {#macos}

  1. Установите пакет [macFUSE](https://osxfuse.github.io/).
  1. [Включите](https://github.com/macfuse/macfuse/wiki/Getting-Started#enabling-support-for-third-party-kernel-extensions-apple-silicon-macs) поддержку сторонних расширений ядра. Этот шаг необходим только при первом использовании MacFUSE на Apple Silicon Mac.
  1. [Разрешите](https://github.com/macfuse/macfuse/wiki/Getting-Started#allow-the-macfuse-kernel-extension-to-load-apple-silicon-and-intel-macs) загрузку расширения ядра MacFUSE (Apple Silicon и Intel Mac).

      Подробнее об установке macFUSE см. в [инструкции по установке](https://github.com/osxfuse/osxfuse/wiki/FAQ#2-installuninstall-questions) в репозитории macFUSE на GitHub.

  1. Скачайте и установите GeeseFS:

     ```bash
     platform='arm64'
     if [[ $(uname -m) == 'x86_64' ]]; then platform='amd64'; fi
     wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-mac-$platform
     chmod a+x geesefs-mac-$platform
     sudo cp geesefs-mac-$platform /usr/local/bin/geesefs
     ```

- Windows {#windows}

  1. [Скачайте](https://winfsp.dev/rel/) и установите WinFSP.
  1. [Скачайте](https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-win-x64.exe) файл `geesefs-win-x64.exe`.
  1. Для удобства работы переименуйте файл `geesefs-win-x64.exe` в `geesefs.exe`.
  1. Создайте папку `geesefs` и перенесите в нее файл `geesefs.exe`.
  1. Добавьте папку `geesefs` в переменную `PATH`:

      {% include [windows-environment-vars](../../_includes/windows-environment-vars.md) %}

{% endlist %}

Также вы можете самостоятельно собрать GeeseFS из исходного кода. Подробнее см. в [инструкции](https://github.com/yandex-cloud/geesefs#installation) в репозитории GeeseFS на GitHub.

## Аутентификация {#authentication}


GeeseFS использует статический ключ доступа к {{ objstorage-name }}, [полученный ранее](#before-you-begin). Он задается несколькими способами:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  * С помощью [файла](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) `credentials`, который нужно поместить в директорию `~/.aws/`:

      1. Создайте директорию:

          ```bash
          mkdir ~/.aws
          ```

      1. Создайте файл `credentials` со следующим содержимым:

          ```text
          [default]
          aws_access_key_id = <идентификатор_ключа>
          aws_secret_access_key = <секретный_ключ>
          ```

    Если файл с ключом находится в другом месте, передайте путь к нему в параметре `--shared-config` при монтировании бакета:

    ```bash
    geesefs \
      --shared-config <путь_к_файлу_с_ключом> \
      <имя_бакета> <точка_монтирования>
    ```

    Структура файла с ключом должна быть аналогична `~/.aws/credentials`.

  * С помощью переменных окружения:

    ```bash
    export AWS_ACCESS_KEY_ID=<идентификатор_ключа>
    export AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

  {% note info %}

  Вы можете использовать команду `geesefs` с правами суперпользователя (`sudo`). В этом случае обязательно передавайте информацию о ключе либо в параметре `--shared-config`, либо с помощью переменных окружения.

  {% endnote %}

- Windows {#windows}

  * С помощью [файла](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) `credentials`, который нужно поместить в папку `users/<текущий_пользователь>/.aws/`:

    ```text
    [default]
    aws_access_key_id = <идентификатор_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

    Если файл с ключом находится в другом месте, передайте путь к нему в параметре `--shared-config` при монтировании бакета:

    ```cmd
    geesefs ^
      --shared-config <путь_к_файлу_с_ключом> ^
      <имя_бакета> <точка_монтирования>
    ```

    Структура файла с ключом должна быть аналогична `~/.aws/credentials`.

    В качестве точки монтирования укажите существующую папку.

  * С помощью переменных окружения:

    ```cmd
    set AWS_ACCESS_KEY_ID=<идентификатор_ключа>
    set AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

{% endlist %}

При работе с GeeseFS на виртуальной машине {{ compute-name }}, к которой [привязан сервисный аккаунт](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance), вы можете включить упрощенную аутентификацию, без статического ключа доступа. Для этого при монтировании бакета используйте опцию `--iam`.

## Монтирование бакета {#bucket-mounting}

Выберите каталог или диск для монтирования бакета. Убедитесь, что у вас достаточно прав для этой операции.

При монтировании бакета также можно задать настройки GeeseFS связанные с [производительностью](#performance) и правами доступа к объектам. Чтобы посмотреть список опций и их описания, выполните команду `geesefs --help`.

* Для разового монтирования бакета:

  {% list tabs group=operating_system %}

  - Linux/macOS {#linux-macos}

    1. Убедитесь, что в файле `.aws/credentials` указаны актуальные данные статического ключа или передайте путь к нему в параметре `--shared-config`.

    1. Создайте папку для монтирования:

        ```bash
        mkdir <точка_монтирования>
        ```

    1. Смонтируйте бакет:

        ```bash
        geesefs <имя_бакета> <точка_монтирования>
        ```

        В качестве точки монтирования следует указывать существующую папку.

  - Windows {#windows}

    1. Убедитесь, что в файле `.aws/credentials` указаны актуальные данные статического ключа или передайте путь к нему в параметре `--shared-config`.

    1. Смонтируйте бакет:

        ```bash
        geesefs <имя_бакета> <точка_монтирования>
        ```

        В качестве точки монтирования укажите имя новой папки, которая будет создана при монтировании бакета. Нельзя указывать имя существующей папки.

  {% endlist %}

* Для автоматического монтирования бакета при запуске системы:

  {% list tabs group=operating_system %}

  - macOS {#macos}

    1. Создайте папку для автоматического монтирования:

        ```bash
        mkdir <точка_монтирования>
        ```

    1. Создайте файл `com.geesefs.automount.plist` с конфигурацией агента автозапуска:

        ```bash
        nano /Users/<имя_пользователя>/Library/LaunchAgents/com.geesefs.automount.plist
        ```

    1. Задайте конфигурацию агента, указав имя бакета и абсолютный путь к точке монтирования:

        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>Label</key>
            <string>com.geesefs.automount</string>
            <key>ProgramArguments</key>
            <array>
                <string>/usr/local/bin/geesefs</string>
                <string><имя_бакета></string>
                <string><абсолютный_путь_к_точке_монтирования></string>
            </array>
            <key>RunAtLoad</key>
            <true/>
            <key>KeepAlive</key>
            <dict>
                <key>NetworkState</key>
                <true/>
            </dict>
        </dict>
        </plist>
        ```

        {% note info %}

        В качестве точки монтирования укажите существующую пустую папку.

        Чтобы бакет монтировался корректно, указывайте полный абсолютный путь к точке монтирования и файлу с ключом без `~`. Например: `/home/user/`.

        {% endnote %}

    1. Включите созданный агент:

        ```bash
        launchctl load /Users/<имя_пользователя>/Library/LaunchAgents/com.geesefs.automount.plist
        ```

    1. Перезагрузитесь и проверьте, что бакет смонтирован в указанную папку.

    Чтобы отключить автозапуск агента, используйте команду:

    ```bash
    launchctl unload /Users/<имя_пользователя>/Library/LaunchAgents/com.geesefs.automount.plist
    ```

  - Linux {#linux}

    1. Создайте папку для автоматического монтирования:
    
        ```bash
        mkdir <точка_монтирования>
        ```

    1. Откройте файл `/etc/fuse.conf`:

        ```bash
        sudo nano /etc/fuse.conf
        ```

    1. Добавьте в него строку:

        ```text
        user_allow_other
        ```

    1.  Откройте файл `/etc/fstab`:

        ```bash
        sudo nano /etc/fstab
        ```

    1. Добавьте в файл `/etc/fstab` строку вида:

        ```text
        <имя_бакета>    /home/<имя_пользователя>/<точка_монтирования>    fuse.geesefs    _netdev,allow_other,--file-mode=0666,--dir-mode=0777,--shared-config=/home/<имя_пользователя>/.aws/credentials    0   0
        ```

        Если вы создавали файл `.aws/credentials` для пользователя `root`, то указывать параметр `--shared-config` не требуется.

        {% note info %}

        Чтобы бакет монтировался корректно, указывайте полный абсолютный путь к точке монтирования и файлу с ключом без `~`. Например: `/home/user/`.

        {% endnote %}

    1. Перезагрузитесь и проверьте, что бакет смонтирован в указанную папку.

    Чтобы отключить автомонтирование, удалите из файла `/etc/fstab`строку с именем бакета.

  - Windows {#windows}

    Создайте службу Windows, которая будет запускаться вместе с ОС:

    1. Запустите командную строку `CMD` от имени администратора.
    1. Выполните команду:

        ```cmd
        sc create <имя_службы> ^
          binPath="<команда_для_монтирования>" ^
          DisplayName= "<имя_службы>" ^
          type=own ^
          start=auto
        ```

        Где `binPath` — путь к файлу `geesefs.exe` с необходимыми параметрами монтирования. Например: `C:\geesefs\geesefs.exe <имя_бакета> <точка_монтирования>`. В качестве точки монтирования укажите имя новой папки, которая будет создана при монтировании бакета. Нельзя указывать имя существующей папки.

        Результат:

        ```text
        [SC] CreateService: успех
        ```

    1. Нажмите кнопку **Пуск** и в строке поиска Windows введите `Службы`. Запустите от имени администратора приложение **Службы**.
    1. В открывшемся окне найдите созданную ранее службу, нажмите на нее правой кнопкой мыши и выберите **Свойства**.
    1. На вкладке **Вход в систему** выберите опцию **С учетной записью** и укажите имя и пароль от вашей учетной записи Windows.

        При необходимости нажмите кнопку **Обзор** → **Дополнительно** → **Поиск**, чтобы найти нужного пользователя на компьютере.

    1. Нажмите кнопку **OK**.

    Чтобы удалить созданную службу, запустите командную строку `CMD` от имени администратора и выполните команду:

    ```cmd
    sc delete <имя_службы>
    ```

    Результат:

    ```text
    [SC] DeleteService: успех
    ```

  {% endlist %}
