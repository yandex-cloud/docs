# Работа {{ ydb-short-name }} CLI

В этом разделе описана работа с БД при помощи интерфейса командной строки {{ ydb-short-name }} CLI. Вы узнаете что нужно для начала работы с консольным клиентом, как его установить и как с его помощью выполнить ряд основных запросов.

## Перед началом работы {#before-you-begin}

1. Подготовьте эндпоинт и полный путь [созданной БД](../create-db.md).

    {% cut "Как узнать эндпоинт и путь базы данных" %}

    {% include [ydb-endpoint](../../_includes/ydb-endpoint.md) %}

    {% endcut %}

1. Разрешите входящий трафик через порт `2135`. Убедитесь, что в назначенной {% if deploy != "arc" %}[группе безопасности](../../../vpc/concepts/security-groups.md){%else%}группе безопасности{% endif %} существует соответствующее правило или добавьте его.

## Установка {{ ydb-short-name }} CLI {#how-to-install}

{% list tabs %}

- Linux
  
    Чтобы установить {{ ydb-short-name }} CLI, выполните команду:

    ```bash
    curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
    ```

    Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.

    {% note info %}

    Скрипт дополнит переменную `PATH` только если его запустить в командных оболочках bash или zsh.
    Если Вы запустили скрипт в другой оболочке, добавьте путь до CLI в переменную `PATH` самостоятельно.

    {% endnote %}

    Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

- macOS

    Чтобы установить {{ ydb-short-name }} CLI, выполните команду:

    ```bash
    curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
    ```

    Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.

    Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

- Windows

    Для Windows {{ ydb-short-name }} CLI можно установить с помощью PowerShell или cmd:

    * Для установки с помощью PowerShell:

        1. Выполните команду:

            ```powershell
            iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1')
            ```

        1. Скрипт установки спросит, нужно ли добавить путь до {{ ydb-cli }} в переменную `PATH`:

            ```text
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`. После этого {{ ydb-short-name }} CLI можно пользоваться, командную оболочку перезапускать не обязательно.

    * Для установки с помощью cmd:

        1. Выполните команду:

            ```cmd
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1'))"
            ```

        1. Скрипт установки спросит, нужно ли добавить путь до {{ ydb-cli }} в переменную `PATH`:

            ```text
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`.
        1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

        {% note info %}

        {{ ydb-short-name }} CLI использует символы юникода в выводе некоторых команд. При некорректном отображении таких символов в консоли Windows, переключите кодировку на UTF-8, выполнив команду:

        ```cmd
        chcp 65001
        ```

        {% endnote %}

{% endlist %}

## Аутентификация в {{ ydb-short-name }} CLI { #authentication }

Для выполнения запросов к {{ ydb-full-name }} в {{ yandex-cloud }} с помощью {{ ydb-short-name }} CLI необходимо аутентифицироваться. Выберите один из доступных ниже способов авторизации.

{% list tabs %}

- OAuth-токен

    В параметре `--yc-token-file` укажите путь к файлу, в котором содержится ваш {% if deploy != "arc" %}[OAuth-токен](../../../iam/concepts/authorization/oauth-token.md){%else%}OAuth-токен{% endif %}.

    Чтобы не указывать эту опцию каждый раз при вызовах команд {{ ydb-cli }}, значение OAuth-токена можно сохранить в переменную окружения `YC_TOKEN`.

- IAM-токен

    В параметре `--iam-token-file` укажите путь к файлу, в котором содержится ваш {% if deploy != "arc" %}[IAM-токен](../../../iam/concepts/authorization/iam-token.md){%else%}IAM-токен{% endif %}.

    Чтобы не указывать этот параметр каждый раз при вызовах команд {{ ydb-cli }}, значение IAM-токена можно сохранить в переменную окружения `IAM_TOKEN`.

    {% note alert %}

    Время жизни IAM-токена 12 часов.

    {% endnote %}

- Сервис метаданных

    Добавьте к команде флаг `--use-metadata-credentials` и {{ ydb-cli }} попытается получить {% if deploy != "arc" %}[IAM-токен](../../../iam/concepts/authorization/iam-token.md){%else%}IAM-токен{% endif %} с помощью {% if deploy != "arc" %}[сервиса метаданных](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md){%else%}сервиса метаданных{% endif %} при работе из виртуальной машины в {{ yandex-cloud }}.

    Также вместо указания флага можно установить значение `1` в переменную окружения `USE_METADATA_CREDENTIALS`.

- Авторизованные ключи доступа

    В параметре `--sa-key-file` укажите путь к файлу с {% if deploy != "arc" %}[авторизованными ключами доступа](../../../iam/operations/authorized-key/create.md){%else%}авторизованными ключами доступа{% endif %} сервисного аккаунта.

    Также вместо указания флага можно сохранить путь к файлу в переменную окружения `SA_KEY_FILE`.

{% endlist %}

### Проверка корректности аутентификации {#whoami}

Для проверки корректности аутентификации можно использовать команду запроса информации о пользователе:

```bash
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  --yc-token-file <путь к файлу с токеном> \
  discovery whoami \
  --groups \
```

Где:

* `--endpoint` — эндпоинт БД.
* `--database` — полный путь БД.
* `--yc-token-file` — путь OAuth-токена.
* `--groups` — добавить в вывод список групп, в которых состоит пользователь.

Результат выполнения:

```text
User SID: aje6o75au36h5d0tnr8k@as

User has no groups
```

В этом примере токен передается через опцию `--yc-token-file`. Чтобы сохранить значение токена в переменную окружения `YC_TOKEN`, выполните команду:

{% list tabs %}

- Linux/macOS

  ```bash
  export YC_TOKEN=<значение токена>
  ```

- Windows

  * Для PowerShell:
  
      ```powershell
      SET YC_TOKEN=<значение токена>
      ```

  * Для cmd:

      ```cmd
      $YC_TOKEN = “<значение токена>”
      ```

{% endlist %}

## Примеры использования {#examples}

### Создание таблицы {#create-table}

{% list tabs %}

- CLI

  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```

  1. Для создания таблицы выполните запрос:
     
     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'CREATE TABLE series
     (
         series_id Uint64,
         title Utf8,
         series_info Utf8,
         release_date Uint64,
         PRIMARY KEY (series_id)
     );'
     ```

  1. Посмотрите результат, выполнив команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scheme ls -l
     ```

     Результат:

     ```bash
     ┌───────┬─────────────────┬──────┬───────────────────────────────┬──────────┬─────────────┐
     | Type  | Owner           | Size | Created                       | Modified | Name        |
     ├───────┼─────────────────┼──────┼───────────────────────────────┼──────────┼─────────────┤
     | table | ajehdq76s7o8ike | 0 b  | Wed, 09 Dec 2020 14:53:25 MSK | Unknown  | series      |
     | dir   |                 |      |                               |          | .sys        |
     └───────┴─────────────────┴──────┴───────────────────────────────┴──────────┴─────────────┘
     ```

{% endlist %}

### Добавление строк {#replace-data}

Добавьте данные в таблицу, используя конструкцию [REPLACE INTO](../../yql/reference/syntax/replace_into.md):

{% list tabs %}

- CLI

  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```

  1. Для добавления данных в таблицу выполните команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'REPLACE INTO series (series_id, title, release_date, series_info)
     VALUES
     (
         1,
         "IT Crowd",
         CAST(Date("2006-02-03") AS Uint64),
         "The IT Crowd is a British sitcom."
     ),
     (
         2,
         "Silicon Valley",
         CAST(Date("2014-04-06") AS Uint64),
         "Silicon Valley is an American comedy television series."
     ),
     (
         3,
         "Fake series",
         CAST(Date("2018-09-11") AS Uint64),
         "Fake series for testing purposes."
     );'
     ```

     В таблицу `series` будут добавлены новые строки, чтобы увидеть результат, далее вы можете [выбрать строки](#select-data) из таблицы.

{% endlist %}

{% if audience == "internal" %}

![Table preview](../_assets/db_ui_table_preview.png)

{% endif %}

### Замена строк {#update-data}

Измените существующие данные в таблице, использую оператор [UPDATE](../../yql/reference/syntax/update.md):

{% list tabs %}

- CLI

  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```

  1. Для изменения данных в таблице `series` выполните команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'UPDATE series
     SET series_info="Fake series updated"
     WHERE series_id = 3;'
     ```

     Чтобы увидеть результат, далее вы можете [выбрать строки](#select-data) из таблицы.

{% endlist %}

{% if audience == "internal" %}

![Update preview](../_assets/db_ui_run_update.png)

{% endif %}

### Удаление строк {#delete-data}

Удалите данные из таблицы с помощью оператора [DELETE](../../yql/reference/syntax/delete.md):

{% list tabs %}

- CLI

  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```

  1. Для удаления данных в таблице `series` выполните команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'DELETE
     FROM series
     WHERE series_id = 3;'
     ```

     Данная команда удалит строки, в которых колонка `series_id` = 3. Чтобы увидеть результат, далее вы можете [выбрать строки](#select-data) из таблицы.

{% endlist %}

{% if audience == "internal" %}

![Delete preview](../_assets/db_ui_run_delete.png)

{% endif %}

### Запрос к данным {#select-data}

Запросите данные из таблицы с помощью оператора [SELECT](../../yql/reference/syntax/select.md):

{% list tabs %}

- CLI

  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```

  1. Для выборки данных из таблицы `series` выполните команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'SELECT series_id,
     title AS series_title,
     CAST (release_date AS Date) AS release_date
     FROM series;'
     ```

     В результате отобразятся данные таблицы:

     ```bash
     ┌───────────┬──────────────────┬──────────────┐
     | series_id | series_title     | release_date |
     ├───────────┼──────────────────┼──────────────┤
     | 1         | "IT Crowd"       | "2006-02-03" |
     ├───────────┼──────────────────┼──────────────┤
     | 2         | "Silicon Valley" | "2014-04-06" |
     └───────────┴──────────────────┴──────────────┘
     ```

{% endlist %}

{% if audience == "internal" %}

![Select from table](../_assets/db_ui_run_select.png)

{% endif %}

### Удаление таблицы {#drop-table}

Удалите таблицу с помощью конструкции [DROP TABLE](../../yql/reference/syntax/drop_table.md):

{% list tabs %}

- CLI

  1. Посмотрите описание команды для выполнения YQL запроса:

     ```bash
     ydb scripting yql --help
     ```

  1. Для удаления таблицы `series` выполните команду:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
     scripting yql -s \
     'DROP TABLE series;'
     ```

     Таблица будет удалена.

{% endlist %}

### Получение списка эндпоинтов для базы данных {#discovery_list}

Чтобы получить список эндпойнтов, выполните команду:

```bash
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  discovery list
```

Где:

* `--endpoint` — эндпоинт БД.
* `--database` — полный путь БД.

Результат выполнения:

```text
grpcs://vm-etn01lrprvnlnhv8v5kj-ru-central1-a-abod.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135 #table_service #scripting #discovery #rate_limiter #locking #kesus
```

`#table_service`, `#scripting` и другие — это gRPC-сервисы, доступные на данном эндпоинте.

### Выполнение запроса к данным {#query}

Выполните запрос к данным:

```bash
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  table query execute \
  --query "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3"
```

Где:

* `--endpoint` — эндпоинт БД.
* `--database` — полный путь БД.
* `--query` — текст запроса.

Результат выполнения:

```text
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
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  scheme ls
```

Где:

* `--endpoint` — эндпоинт БД.
* `--database` — полный путь БД.

Результат выполнения:

```text
episodes  seasons  series  some_directory  .sys
```

Чтобы посмотреть подробную информацию, добавьте флаг `-l`:

```bash
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  scheme ls \
  -l
```

Результат выполнения:

```text
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

### Работа с директориями {#directory}

Создайте дерево из директорий:

```bash
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  scheme mkdir some_directory
```

```bash
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  scheme mkdir some_directory/sub-directory1
```

```bash
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  scheme mkdir some_directory/sub-directory1/sub-directory1-1
```

```bash
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  scheme mkdir some_directory/sub-directory2
```

Где:

* `--endpoint` — эндпоинт БД.
* `--database` — полный путь БД.

Чтобы посмотреть рекурсивный листинг всех поддиректорий и объектов в них по указанному пути, воспользуйтесь опцией `-R` подкоманды `scheme ls`:

```bash
{{ ydb-cli }} \
  --endpoint <эндпоинт> \
  --database <база данных> \
  scheme ls some_directory \
  -lR
```

Где:

* `--endpoint` — эндпоинт БД.
* `--database` — полный путь БД.

Результат выполнения:

```text
┌──────┬─────────────────────────┬──────┬─────────┬──────────┬─────────────────────────────────┐
| Type | Owner                   | Size | Created | Modified | Name                            |
├──────┼─────────────────────────┼──────┼─────────┼──────────┼─────────────────────────────────┤
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1                  |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1/sub-directory1-1 |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory2                  |
└──────┴─────────────────────────┴──────┴─────────┴──────────┴─────────────────────────────────┘
```

#### Что дальше {#what-is-next}

Ознакомьтесь с другими примерами использования {{ ydb-short-name }} CLI:

* [{#T}](../../operations/ydb-cli/commands.md).
* [{#T}](../../operations/ydb-cli/scheme-describe.md).
* [{#T}](../../operations/ydb-cli/readtable.md).
* [{#T}](../../operations/ydb-cli/operations-index.md).
