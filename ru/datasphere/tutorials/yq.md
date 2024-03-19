# Анализ данных с помощью {{ yq-full-name }}

{{ yq-full-name }} — это интерактивный сервис для бессерверного анализа данных. Он позволяет обрабатывать данные из различных хранилищ без создания выделенного кластера обработки данных, используя SQL-запросы. {{ yq-full-name}} работает с хранилищами данных [{{ objstorage-full-name }}](../../storage/), [{{ mpg-name }}](../../managed-postgresql/), [{{ mch-name }}](../../managed-clickhouse/).

Чтобы анализировать данные в {{ ml-platform-name }} с помощью {{ yq-name }}:

1. [Установите и настройте пакет yandex_query_magic](#setup-plugin).
1. [Создайте шаблон запроса](#templating).
1. [Обработайте результаты выполнения](#capture-command-result).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

Настройте инфраструктуру для работы с {{ yq-full-name }}:
1. Перейдите в [консоль управления]({{ link-console-main }}) и [привяжите](../../billing/operations/pin-cloud.md) платежный аккаунт к облаку.
1. [Создайте каталог](../../resource-manager/operations/folder/create.md), в котором будет работать {{ yq-full-name }}

### Необходимые платные ресурсы {#paid-resources}

В стоимость анализа данных с помощью из {{ yq-full-name }} входят:

* плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md);
* плата за данные, считанные [{{ yq-full-name }} при исполнении запросов](../../query/pricing.md).

## Установите и настройте пакет yandex_query_magic {#setup-plugin}

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Установите пакет [yandex_query_magic](https://pypi.org/project/yandex-query-magic/), выполнив в ячейке ноутбука команду:

  ```python
  %pip install yandex_query_magic --upgrade
  ```

1. Настройте пакет `yandex_query_magic`. Это можно сделать, задав параметры с помощью line команды `yq_settings`:

  ```python
  %yq_settings --folder-id <идентификатор_каталога> ...
  ```

  Доступные параметры:

  * `--folder-id <идентификатор_каталога>` — идентификатор каталога для выполнения запросов {{ yq-name }}.
  * `--env-auth <переменная_окружения_environment_variable>` — устанавливает режим аутентификации авторизованным ключом, содержимое которого находится в [секрете {{ ml-platform-full-name }}](../../datasphere/concepts/secrets.md). [Создайте](../../datasphere/operations/data/secrets.md) секрет {{ ml-platform-name }}, а имя созданного секрета укажите в параметре `--env-auth`.

### Проверьте работу пакета {#check-installation}

Команду `%yq line magic` можно использовать, когда весь SQL-запрос представлен одной строкой. В этом случае SQL-запрос выполняется с помощью ключевого слова `%yq`.

Выполните следующие команды в ноутбуке:

```python
%load_ext yandex_query_magic
%yq_settings --env-auth <название_секрета_{{ ml-platform-full-name }}> --folder-id <идентификатор_каталога>
%yq SELECT "Hello, world!"
```

Где:

* `%yq` — имя "магической" команды.
* `SELECT "Hello, world!"` — текст запроса к {{ yq-name }}.

Чтобы выполнять многострочные SQL-запросы, необходимо использовать `%%yq cell magic`. Текст запроса должен начинаться с ключевого слова `%%yq`:

```sql
%%yq --folder-id <идентификатор_каталога> --name "Мой запрос"  --raw-results

SELECT
    col1,
    COUNT(*)
FROM table
GROUP BY col1
```

Где:

* `--folder-id` — идентификатор каталога для выполнения запроса {{ yq-name }}. По умолчанию используется каталог, указанный ранее через `%yq_settings`. Если он не указан, то используется каталог, в котором запущена виртуальная машина.
* `--name` — (опционально) имя запроса.
* `--description` — (опционально) описание запроса.
* `--raw-results` — (опционально) параметр, чтобы возвращать необработанные результаты выполнения запроса в {{ yq-name }}. Спецификация формата доступна в разделе [{#T}](../../query/api/yql-json-conversion-rules.md).

{% include  [working_with_yq](../../_includes/query/magics.md)%}
