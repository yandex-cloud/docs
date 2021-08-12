---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Работа с {{ ydb-short-name }} CLI

В этом разделе описана работа с БД при помощи интерфейса командной строки {{ ydb-short-name }} CLI. Вы узнаете что нужно для начала работы с консольным клиентом, как его установить и как с его помощью выполнить ряд основных запросов.

## Перед началом работы {#before-you-begin}

1. [Установите](../../../cli/quickstart.md#install) и [инициализируйте](../../../cli/quickstart.md#initialize) интерфейс командной строки {{ yandex-cloud }}.
1. Подготовьте YDB эндпоинт и полный путь [созданной БД](../create-db.md).

{% cut "Как узнать эндпоинт и путь базы данных" %}

{% include [ydb-endpoint](../../_includes/ydb-endpoint.md) %}

{% endcut %}

{% note info %}

При использовании нестандартной конфигурации базы данных может потребоваться явное разрешение входящего трафика через порт `2135`. Убедитесь, что в назначенной [группе безопасности](../../../vpc/concepts/security-groups.md) существует соответствующее правило или добавьте его.

{% endnote %}

## Установка {{ ydb-short-name }} CLI {#how-to-install}

{% include [ydb-cli-install](../../_includes/ydb-cli-install.md) %}

## Настройка авторизации {#iam}

В этой инструкции для авторизации в {{ ydb-short-name }} используется [IAM-токен](../../../iam/concepts/authorization/iam-token.md). О других способах читайте в разделе [{#T}](../../ydb-cli/authorization.md).

1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md):

    ```bash
    yc iam create-token
    ```

1. Сохраните полученный токен в файл, например `iam-token.txt`. Он понадобится на следующем шаге.

    {% note alert %}

    Время жизни IAM-токена не более 12 часов.

    {% endnote %}

1. Проверьте корректность авторизации запросив информацию о пользователе:

    ```bash
    {{ ydb-cli }} \
      --endpoint <эндпоинт> \
      --database <база_данных> \
      --iam-token-file <путь> \
      discovery whoami \
      --groups
    ```

    * `--endpoint` — эндпоинт БД.
    * `--database` — полный путь БД.
    * `--iam-token-file` — путь файла с IAM-токеном.
    * `--groups` — добавить в вывод список групп, в которых состоит пользователь.

    Пример команды:

    ```bash
    {{ ydb-cli }} \
      --endpoint ydb.serverless.yandexcloud.net:2135 \
      --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
      --iam-token-file iam-token.txt \
      discovery whoami \
      --groups
    ```

    Пример результата:

    ```text
    User SID: aje6o75au36h5d0tnr8k@as

    User has no groups
    ```

## Примеры использования {#examples}

Чтобы не указывать эндпоинт, полный путь базы данных и параметры авторизации при каждом вызове команд {{ ydb-short-name }} CLI, настройте [профиль](../../ydb-cli/profile/create.md).

### Создание таблицы {#create-table}

Добавите данные в таблицу с помощью инструкции [CREATE TABLE](../../yql/reference/syntax/create_table.md):

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
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

Посмотрите результат:

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scheme ls -l
```

Результат:

```text
┌───────┬─────────────────────────┬──────┬───────────────────────────────┬──────────┬──────────────┐
| Type  | Owner                   | Size | Created                       | Modified | Name         |
├───────┼─────────────────────────┼──────┼───────────────────────────────┼──────────┼──────────────┤
| table | ajevsalaghmdvtfjgm29@as | 0 b  | Thu, 17 Jun 2021 11:00:28 UTC | Unknown  | series       |
| dir   |                         |      |                               |          | .sys         |
└───────┴─────────────────────────┴──────┴───────────────────────────────┴──────────┴──────────────┘
  ```

### Добавление данных {#replace-data}

Добавьте данные в таблицу с помощью инструкции [REPLACE INTO](../../yql/reference/syntax/replace_into.md):

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
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

В таблицу `series` будут добавлены новые записи. Чтобы посмотреть результат, [запросите](#select-data) данные из таблицы.


### Обновление данных {#update-data}

Обновите данные с помощью инструкции [UPDATE](../../yql/reference/syntax/update.md):

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scripting yql -s \
  'UPDATE series
  SET series_info="Fake series updated"
  WHERE series_id = 3;'
```

Чтобы посмотреть результат, [запросите](#select-data) данные из таблицы.

{% endlist %}


### Удаление данных {#delete-data}

Удалите данные из таблицы с помощью инструкции [DELETE](../../yql/reference/syntax/delete.md):

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scripting yql -s \
  'DELETE
  FROM series
  WHERE series_id = 3;'
```

Эта команда удалит записи, в которых значение `series_id` равно 3. Чтобы посмотреть результат, [запросите](#select-data) данные из таблицы.


### Запрос к данным {#select-data}

Запросите данные из таблицы с помощью инструкции [SELECT](../../yql/reference/syntax/select.md):

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scripting yql -s \
  'SELECT series_id, title AS series_title,
  CAST (release_date AS Date) AS release_date
  FROM series;'
```

Результат:

```text
┌───────────┬──────────────────┬──────────────┐
| series_id | series_title     | release_date |
├───────────┼──────────────────┼──────────────┤
| 1         | "IT Crowd"       | "2006-02-03" |
├───────────┼──────────────────┼──────────────┤
| 2         | "Silicon Valley" | "2014-04-06" |
└───────────┴──────────────────┴──────────────┘
```

{% endlist %}


### Удаление таблицы {#drop-table}

Удалите таблицу с помощью инструкции [DROP TABLE](../../yql/reference/syntax/drop_table.md):

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scripting yql -s \
  'DROP TABLE series;'
```

Таблица будет удалена.

{% endlist %}
