[Документация Yandex Cloud](../index.md) > [Интерфейс командной строки](index.md) > Решение проблем

# Решение проблем с Yandex Cloud CLI

* [Проблемы при установке CLI](#installation-errors)
  * [В PowerShell запрещено выполнение скриптов](#powershell-restriction)
  * [Нет доступа к https://storage.yandexcloud.net](#access-to-s3)
  * [Failure writing output to destination](#failure-writing-output-to-destination)
  * [Команда yc не найдена в Linux или macOS](#command-not-found)
  * [Ошибка command not found: compdef](#compdef-not-found)
* [Проблемы при работе с CLI](#operation-errors)
  * [Пример сообщения об ошибке](#sample)
  * [Как получить подробную информацию об ошибке операции?](#operation-error-details)
  * [Как обратиться в службу технической поддержки?](#what-to-do)
  * [Ресурс не найден при обращении по имени](#name-not-found)
  * [Как пользоваться CLI через прокси-сервер?](#proxy)
  * [Недействительный токен](#invalid-token)
  * [Ошибка при аутентификации на сервере без графического интерфейса и браузера](#federated-auth-without-gui)

## Проблемы при установке CLI {#installation-errors}

#### В PowerShell запрещено выполнение скриптов {#powershell-restriction}

Если PowerShell сообщает, что выполнение скриптов запрещено, проверьте действующие политики выполнения с помощью команды `Get-ExecutionPolicy -List`. Изменяйте политики только в том случае, если это разрешено правилами безопасности вашей организации. Если политика задана администратором или запуск скриптов запрещен, [установите CLI без использования скрипта](operations/install-cli.md#bin).

Подробнее о политиках выполнения PowerShell читайте в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).

#### Нет доступа к https://storage.yandexcloud.net {#access-to-s3}

Вы можете самостоятельно [скачать архив с исполняемым файлом CLI](operations/install-cli.md#bin) и установить его.

Например, это может быть полезно, если на целевом устройстве нет доступа к `https://storage.yandexcloud.net`. Скачайте архив с исполняемым файлом CLI на другом устройстве, а затем перенесите архив на целевое устройство разрешенным в вашей организации способом.

#### Failure writing output to destination {#failure-writing-output-to-destination}

Если утилита `curl` в ОС Linux Ubuntu была установлена с помощью [snap-пакета](https://ru.wikipedia.org/wiki/Snappy_(система_управления_пакетами)), в процессе [установки](operations/install-cli.md) CLI может возникнуть ошибка `curl: (23) Failure writing output to destination`. 

Чтобы исправить эту ошибку, удалите утилиту `curl` и повторно установите ее с помощью [менеджера пакетов](https://ru.wikipedia.org/wiki/Advanced_Packaging_Tool) `apt`:

```bash
sudo snap remove curl
sudo apt install curl
```

Затем повторите [установку CLI](operations/install-cli.md).

#### Команда yc не найдена в Linux или macOS {#command-not-found}

Если после установки CLI возникает ошибка `yc: command not found`, перезапустите командную оболочку или выполните команду:

```bash
exec -l $SHELL
```

Если ошибка сохраняется:

1. Убедитесь, что исполняемый файл CLI установлен:

    ```bash
    ls -l "$HOME/yandex-cloud/bin/yc"
    ```

    Если файла нет, повторите [установку CLI](operations/install-cli.md).

1. Добавьте путь к исполняемому файлу в переменную окружения `PATH` для текущей сессии и проверьте работу CLI:

    ```bash
    source "$HOME/yandex-cloud/path.bash.inc"
    yc version
    ```

1. Чтобы путь добавлялся в новых сессиях автоматически, убедитесь, что в файле `~/.zshrc`, `~/.bashrc` или `~/.bash_profile`, соответствующем вашей командной оболочке, есть строка:

    ```bash
    if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
    ```

#### Ошибка command not found: compdef {#compdef-not-found}

Ошибка `command not found: compdef` возникает, если автодополнение CLI загружается до инициализации системы автодополнения `zsh`.

Добавьте следующие строки в файл `~/.zshrc` перед строкой, которая подключает файл `completion.zsh.inc`:

```bash
autoload -Uz compinit
compinit
```

Затем перезапустите командную оболочку или выполните команду `exec -l $SHELL`. Подробнее о настройке автодополнения читайте в разделе [Включить автодополнение](operations/install-cli.md#enable-completion).

## Проблемы при работе с CLI {#operation-errors}

Если во время выполнения операции возникла ошибка, [CLI](../glossary/cli.md) отобразит соответствующее сообщение.

#### Пример сообщения об ошибке {#sample}

```bash
yc compute instance create \
  --name my-inst3 \
  --metadata user-data="#ps1\nnet user Administrator Passw0rd" \
  --zone ru-central1-a \
  --public-ip \
  --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk-153

ERROR: rpc error: code = ResourceExhausted desc = The limit on maximum number of instances has exceeded.

server-request-id: 9d42710c-4a14-4561-a491-1f3bf76dbaaa
client-request-id: e69f4463-b9de-45bc-89b3-4db6e4d1bae6
client-trace-id: ddd8c763-81a3-4c58-9a7d-445257b59aee

Use server-request-id, client-request-id, client-trace-id for investigation of issues in cloud support
If you are going to ask for help of cloud support, please send the following trace file: C:\Users\username\yandex-cloud\logs\yc_compute_instance_create-2019-02-18T12-26-39.897.txt
```

#### Как получить подробную информацию об ошибке операции? {#operation-error-details}

Если CLI вывел идентификатор операции, запросите сведения о ней:

```bash
yc operation get <идентификатор_операции>
```

Сведения об операции могут содержать более подробное описание причины ошибки.

#### Как обратиться в службу технической поддержки? {#what-to-do}

Чтобы помочь нашим специалистам быстрее решить вашу проблему, из сообщения об ошибке:
1. Скопируйте все доступные **идентификаторы**. В данном примере это `server-request-id`, `client-request-id` и `client-trace-id`.
1. Скопируйте **файл с логами**, который сохранился на вашем ПК. Путь к логам указан в конце сообщения об ошибке.
В данном примере это:

    ```text
    C:\Users\username\yandex-cloud\logs\yc_compute_instance_create-2019-02-18T12-26-39.897.txt
    ```

1. Обратитесь с этой информацией в [службу технической поддержки](https://center.yandex.cloud/support).

#### Ресурс не найден при обращении по имени {#name-not-found}

Если при обращении к ресурсу по имени возникает ошибка:

```text
ERROR: ... not found
```

или

```text
ERROR: rpc error: code = NotFound ...
```

Скорее всего, ресурс находится не в каталоге по умолчанию текущего профиля CLI.

Чтобы решить проблему, укажите каталог явно с помощью параметра `--folder-id` или `--folder-name`:

```bash
yc <сервис> <ресурс> get <имя_ресурса> --folder-id <идентификатор_каталога>
```

Пример для виртуальной машины:

```bash
yc compute instance get my-vm --folder-id b1g5bhjofg7o********
```

Если вы работаете с этим каталогом постоянно, сделайте его каталогом по умолчанию:

```bash
yc config set folder-id <идентификатор_каталога>
```

Если вы используете идентификатор ресурса, указывать каталог не нужно — идентификаторы уникальны.

#### Как пользоваться CLI через прокси-сервер? {#proxy}

Если доступ к Yandex Cloud в вашей организации осуществляется через прокси-сервер, перед выполнением команды `yc init` [настройте подключение CLI к прокси-серверу](concepts/index.md#cli-via-proxy).

#### Недействительный токен {#invalid-token}

При выполнении команды CLI может возникать ошибка о недействительности токена, например:

```text
ERROR: Unable to list clouds: rpc error: code = Unauthenticated desc = UNAUTHENTICATED: The token is invalid
```

Независимо от типа [профиля](operations/profile/profile-create.md) CLI аутентификация в Yandex Cloud выполняется с помощью [IAM-токена](../iam/concepts/authorization/iam-token.md). CLI получает его следующими способами:
* из браузера;
* в обмен на [авторизованный ключ](../iam/concepts/authorization/key.md);
* напрямую из переменной окружения `YC_IAM_TOKEN`.

Ошибка свидетельствует о том, что IAM-токен недействителен. Например, мог истечь срок его действия, или токен был отозван.

Повторно [аутентифицируйтесь](operations/index.md#auth) в CLI.

Учитывайте также, что передача IAM-токена в переменную окружения `export YC_IAM_TOKEN=<значение_IAM-токена>` переопределяет аутентификационные параметры, заданные при других типах аутентификации.

#### Ошибка при аутентификации на сервере без графического интерфейса и браузера {#federated-auth-without-gui}

В случае отсутствия на сервере графического интерфейса и браузера возникает ошибка:

```text
ERROR: fill default credentials: federation id authentication is not supported on this system because the browser can not be opened
```

[Аутентифицируйтесь сервисным аккаунтом](operations/authentication/service-account.md). Также вы можете использовать [SSH-туннель](operations/authentication/auth-without-gui.md#linux-vm-auth) или [форвардинг X11](operations/authentication/auth-without-gui.md#auth-without-gui).


### Полезные ссылки {#see-also}

* [Работа с Yandex Cloud CLI и API в Microsoft Windows](../overview/concepts/console-syntax-guide.md)
* [Обзор интерфейсов для работы с сервисами](../overview/concepts/interfaces.md)
* [Порядок оказания технической поддержки](../support/overview.md)