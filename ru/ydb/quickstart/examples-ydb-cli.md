# Использование интерфейса командной строки YDB CLI

В этом разделе описана работа с базой при помощи интерфейса командной строки YDB CLI. Вы узнаете что нужно для начала работы с консольным клиентом, как его установить и как с его помощью выполнить ряд основных запросов.

## Перед началом работы {#before-you-begin}

Чтобы успешно выполнять команды через YDB CLI, потребуются:
* База данных. Если у вас еще нет БД, [создайте ее](create-db.md) и [наполните данными](examples-yql.md).
* Эндпоинт и полный путь к базе данных в {{ ydb-full-name }}.
    
    {% cut "Как узнать эндпоинт и путь для своей базы данных" %}
        
    Чтобы узнать эндпоинт и путь для своей базы данных:
    1. Перейдите в [консоль управления]({{ link-console-main }}).
    1. Выберите нужный каталог и перейдите в сервис **{{ ydb-full-name }}**.
    1. Выберите базу данных, к которой планируете сделать запрос.
    1. В меню слева перейдите в раздел **Обзор**.
    1. Значение эндпоинта указано в строке **Эндпоинт**. 
        * Пример значения параметра для Dedicated базы: `lb.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135`. 
        * Пример значения параметра для Serverless базы: `ydb.serverless.yandexcloud.net:2135`. 
            Порт для эндпоинта по умолчанию `2135`, так что указывать в запросе `:2135` не обязательно.
    1. Полный путь к базе указан в строке **База данных**.  
        Пример значения параметра: `/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj`.
        
    {% endcut %}

* Разрешение входящего трафика через порт `2135`. Убедитесь, что в назначенной [группе безопасности](../../vpc/concepts/security-groups.md) существует соответствующее правило или добавьте его.

## Установка YDB CLI {#how-to-install}

{% list tabs %}

- Linux
  
  Чтобы установить YDB CLI:
  1. Выполните команду:

     ```
     curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
     ```

     Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения PATH.

     {% note info %}

     Скрипт дополнит переменную PATH только если его запустить в командных оболочках bash или zsh.
     Если Вы запустили скрипт в другой оболочке, добавьте путь до CLI в переменную PATH самостоятельно.

     {% endnote %}

  1. Перезапустите командную оболочку.

- macOS

  Чтобы установить YDB CLI:
  1. Выполните команду:

     ```
     curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
     ```

     Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения PATH.

  1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

- Windows

    Для Windows YDB CLI можно установить с помощью PowerShell или `cmd`:

    - Для установки с помощью PowerShell:

        1. Выполните команду:
            ```
            iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1')
            ```

        1. Скрипт установки спросит, нужно ли добавить путь до `{{ ydb-cli }}` в переменную PATH:
            ```
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`. После этого YDB CLI можно пользоваться, командную оболочку перезапускать не обязательно.

    - Для установки с помощью `cmd`:

        1. Выполните команду:
            ```
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1'))"
            ```

        1. Скрипт установки спросит, нужно ли добавить путь до `{{ ydb-cli }}` в переменную PATH:
            ```
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`.
        1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

        {% note info %}
    
        YDB CLI использует символы юникода в выводе некоторых команд. При некорректном отображении таких символов в консоли Windows, переключите кодировку на UTF-8, выполнив команду:
        ```
        chcp 65001
        ```
    
        {% endnote %}

{% endlist %}

## Аутентификация в YDB CLI { #authentication }

Для выполнения запросов к {{ ydb-full-name }} в {{ yandex-cloud }} с помощью YDB CLI необходимо аутентифицироваться. Выберите один из доступных ниже способов авторизации.

{% list tabs %}

- OAuth-токен

    В параметре `--yc-token-file` укажите путь к файлу, в котором содержится ваш [OAuth-токен](../../iam/concepts/authorization/oauth-token.md).
    
    Чтобы не указывать эту опцию каждый раз при вызовах команд `{{ ydb-cli }}`, **значение** OAuth-токена можно сохранить в переменную окружения `YC_TOKEN`.

- IAM-токен

    В параметре `--iam-token-file` укажите путь к файлу, в котором содержится ваш [IAM-токен](../../iam/concepts/authorization/iam-token.md). 
    
    Чтобы не указывать этот пара опцию каждый раз при вызовах команд `{{ ydb-cli }}`, **значение** [IAM-токена](../../iam/concepts/authorization/iam-token.md) можно сохранить в переменную окружения `IAM_TOKEN`.
    
    {% note alert %}
    
    Время жизни IAM-токена 12 часов.
    
    {% endnote %}

- Сервис метаданных

    Добавьте к команде флаг `--use-metadata-credentials` и `{{ ydb-cli }}` попытается получить [IAM-токен](../../iam/concepts/authorization/iam-token.md) с помощью [сервиса метаданных](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md) при работе из виртуальной машины в {{ yandex-cloud }}. 
    
    Также вместо указания флага можно установить значение **1** в переменную окружения — `USE_METADATA_CREDENTIALS=1`.

- Авторизованные ключи доступа
    
    В параметре `--sa-key-file` укажите путь к файлу с [авторизованными ключами доступа](../../iam/operations/authorized-key/create.md) сервисного аккаунта. 
    
    Или можно сохранить **путь к файлу** в переменную окружения `SA_KEY_FILE`.

{% endlist %}

### Проверка корректности аутентификации {#whoami}

Для проверки корректности аутентификации можно использовать команду запроса информации о пользователе:

```bash
{{ ydb-cli }} -e <эндпоинт> -d <база данных> --yc-token-file <путь к файлу с токеном> discovery whoami -g
```

Параметры команды:

- `-e` и `-d` — это **Эндпоинт** и **База данных**. В разделе [Предварительные требования](#requirements) подробно описано, как их можно получить.
- Опция `-g` добавляет в вывод список групп, в которых состоит пользователь.

Результат команды:

```bash
User SID: aje6o75au36h5d0tnr8k@as

User has no groups
```

В этом примере токен передается через опцию `--yc-token-file`. Можно сохранить **значение** самого токена в переменную окружения YC_TOKEN, чтобы уменьшить объем вводимого текста. 

Используйте для этого команду:

{% list tabs %}

- Linux/macOS

    ```bash
    export YC_TOKEN=<значение токена>
    ```

- Windows
    
    * Для PowerShell:
    
        ```bash
        SET YC_TOKEN=<значение токена>
        ```
    * Для `cmd`:
        
        ```bash
        $YC_TOKEN = “<значение токена>”
        ```

{% endlist %}


## Примеры использования {#examples}

### Получение списка эндпоинтов для базы данных {#discovery_list}

Чтобы получить список эндпойнтов, выполните команду:

```bash
{{ ydb-cli }} -e <эндпоинт> -d <база данных> discovery list
```

Результат команды:

```bash
grpcs://vm-etn01lrprvnlnhv8v5kj-ru-central1-a-abod.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135 #table_service #scripting #discovery #rate_limiter #locking #kesus
```

`#table_service`, `#scripting` и другие — это gRPC-сервисы, доступные на данном эндпоинте.

### Выполнение запроса к данным {#query}

Чтобы выполнить запрос к данным, выполните команду:

```bash
{{ ydb-cli }} -e <эндпоинт> -d <база данных> table query execute -q "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3"
```

Результат команды:

```bash
┌───────────┬────────────┬────────────────────────────────┐
| season_id | episode_id | title                          |
├───────────┼────────────┼────────────────────────────────┤
| [2u]      | [1u]       | ["The Work Outing"]            |
├───────────┼────────────┼────────────────────────────────┤
| [2u]      | [2u]       | ["Return of the Golden Child"] |
├───────────┼────────────┼────────────────────────────────┤
| [2u]      | [3u]       | ["Moss and the German"]        |
└───────────┴────────────┴────────────────────────────────┘
```


### Листинг объектов {#listing}

Листинг объектов производится подкомандой `scheme ls <путь>`. Если путь не указан, то будет производиться листинг корня базы данных:

```bash
{{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme ls
```

Результат команды:

```bash
episodes  seasons  series  some_directory  .sys
```

Можно посмотреть подробную информацию, добавив флаг `-l`:

```bash
{{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme ls -l

```

Результат команды:

```bash
┌───────┬─────────────────────────┬─────────┬───────────────────────────────┬───────────────────────────────┬────────────────┐
| Type  | Owner                   | Size    | Created                       | Modified                      | Name           |
├───────┼─────────────────────────┼─────────┼───────────────────────────────┼───────────────────────────────┼────────────────┤
| table | aje6o75au36h5d0tnr8k@as | 1.13 Kb | Thu, 17 Sep 2020 09:17:44 UTC | Thu, 17 Sep 2020 09:24:31 UTC | episodes       |
| table | aje6o75au36h5d0tnr8k@as | 1.45 Kb | Thu, 17 Sep 2020 09:17:44 UTC | Thu, 17 Sep 2020 09:20:07 UTC | seasons        |
| table | aje6o75au36h5d0tnr8k@as | 1.12 Kb | Thu, 17 Sep 2020 09:17:44 UTC | Thu, 17 Sep 2020 09:19:46 UTC | series         |
| dir   | aje6o75au36h5d0tnr8k@as |         |                               |                               | some_directory |
| dir   |                         |         |                               |                               | .sys           |
└───────┴─────────────────────────┴─────────┴───────────────────────────────┴───────────────────────────────┴────────────────┘
```

{% note info %}

Таблицы `episodes`, `series` и `seasons` из приводимых примеров можно создать самостоятельно.
В разделе ["Начало работы - Примеры YQL-запросов"](examples-yql.md) описано, как можно выполнять запросы к {{ ydb-full-name }} в [консоли {{ yandex-cloud }}](https://console.cloud.yandex.ru/).
Создание всех таблиц из приводимых примеров описано в разделе ["Туториал YQL - Создание таблицы"](../yql/tutorial/create_demo_tables.md).
А наполнение их данными — в разделе ["Туториал YQL - Добавление данных в таблицу"](../yql/tutorial/fill_tables_with_data.md).

{% endnote %}

Создайте дерево из директорий:

```bash
{{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme mkdir some_directory
{{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme mkdir some_directory/sub-directory1
{{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme mkdir some_directory/sub-directory1/sub-directory1-1
{{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme mkdir some_directory/sub-directory2
```

Теперь при помощи опции `-R` для команды `scheme ls` можно посмотреть рекурсивный листинг всех поддиректорий и объектов в них по указанному пути:

```bash
{{ ydb-cli }} -e <эндпоинт> -d <база данных> scheme ls some_directory -lR
```

Результат команды:

```bash
┌──────┬─────────────────────────┬──────┬─────────┬──────────┬─────────────────────────────────┐
| Type | Owner                   | Size | Created | Modified | Name                            |
├──────┼─────────────────────────┼──────┼─────────┼──────────┼─────────────────────────────────┤
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1                  |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1/sub-directory1-1 |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory2                  |
└──────┴─────────────────────────┴──────┴─────────┴──────────┴─────────────────────────────────┘
```


#### Что дальше {#what-is-next}

Ознакомьтесь с другими примерами использования YDB CLI:
* [{#T}](../operations/ydb-cli/commands.md).
* [{#T}](../operations/ydb-cli/scheme-describe.md).
* [{#T}](../operations/ydb-cli/readtable.md).
* [{#T}](../operations/ydb-cli/operations-index.md).

