# Чтение и запись данных

Запросы могут быть отправлены для выполнения в YDB следующими способами:

* из [консоли управления](#web-sql);
* из приложения, написанного с использованием [YDB SDK](../ydb-sdk/index.md) для [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk) и [Go](https://github.com/yandex-cloud/ydb-go-sdk);
* с помощью [API, совместимого с Amazon DynamoDB](../docapi/api-ref/index.md) — для документальных таблиц.

Для выполнения запросов в этом разделе будет использоваться консоль управления.

## Предварительные требования {#prerequisite}

Для выполнения запросов понадобится создать [базу данных](create_manage_database.md) и [таблицу](schema.md) в ней.

## SQL-запросы в консоли управления {#web-sql}

Чтобы отправить SQL-запрос к базе данных из консоли управления:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
1. В списке сервисов выберите **{{ ydb-name }}**.
1. Выберите базу из списка.
1. Нажмите кнопку **SQL-запрос** и введите текст запроса. При составлении запроса вы можете пользоваться шаблонами:
   * Чтобы воспользоваться одним из стандартных шаблонов, выберите его из выпадающего списка справа от кнопки **SQL-запрос**.
   * Чтобы подставить в шаблон данные определенной таблицы, нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) в строке с нужной таблицей и выберите шаблон.
1. Нажмите кнопку **Выполнить**. 

## Вставьте и измените данные {#change-data}

Для вставки данных в {{ ydb-short-name }} используются инструкции [REPLACE](../yql/reference/syntax/replace_into.md), [UPSERT](../yql/reference/syntax/upsert_into.md) и [INSERT](../yql/reference/syntax/insert_into.md).

При выполнении инструкций REPLACE и UPSERT осуществляется слепая запись. При выполнении инструкции INSERT перед операцией записи выполняется операция чтения данных. Это позволяет убедиться, что уникальность первичного ключа будет соблюдена.

Использование инструкций REPLACE и UPSERT предпочтительнее при операциях записи и изменения данных.

Одним запросом REPLACE, UPSERT или INSERT можно вставить в таблицу несколько строк.

{% note warning %}

В консоль управления YQL включена PRAGMA AutoCommit. Это означает, что после каждого запроса автоматически будет выполняться COMMIT. Например, если вы введете несколько выражений (как показано в примере ниже) и выполните запрос, после запроса автоматически будет выполнен СOMMIT.

```sql
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 1, "Yesterday's Jam");
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 2, "Calamity Jen");
```

{% endnote %}

### REPLACE {#replace}

После создания таблиц ```series```, ```seasons``` и ```episodes``` можно вставить данные в таблицу с помощью инструкции [REPLACE](../yql/reference/syntax/replace_into.md). Базовый синтаксис:

```sql
REPLACE INTO имя_таблицы (список_столбцов) VALUES (список_добавляемых_значений);
```

Инструкция [REPLACE](../yql/reference/syntax/replace_into.md) используется для добавления новой или изменения существующей строки по заданному значению первичного ключа. Если строка с указанным значением первичного ключа не существует, она будет создана. Если строка уже существует, значения колонок существующей строки будут заменены новыми значениями. *При этом значения колонок, не участвующих в операции, устанавливаются в значения по умолчанию.* В этом заключается единственное отличие от инструкции UPSERT.

{% note info %}

При выполнении операции REPLACE осуществляется слепая запись. Для операций записи или изменения данных предпочтительнее использовать инструкции REPLACE или UPSERT.

{% endnote %}

Данные, добавленные с помощью следующего примера кода, будут использоваться далее в этом разделе.

{% include notitle [replace-into-3-columns](../_includes/queries/replace-into-3-columns.md) %}

### UPSERT {#upsert}

Инструкция [UPSERT](../yql/reference/syntax/upsert_into.md) используется для добавления новой или изменения существущей строки по заданному значению первичного ключа. Если строка с указанным значением первичного ключа не существует, она будет создана. Если строка уже существует, значения колонок существующей строки будут заменены новыми значениями. *При этом значения колонок, не участвующих в операции, не изменяют свои значения. В этом заключается единственное отличие от инструкции REPLACE.*

{% note info %}

При выполнении операции UPSERT осуществляется слепая запись. Для записи предпочтительнее использовать инструкции REPLACE или UPSERT.

{% endnote %}

Код, приведенный ниже, вставит в таблицу ```episodes``` одну строчку с данными.

{% include notitle [upsert-into-3-columns](../_includes/queries/upsert-into-3-columns.md) %}

### INSERT {#insert}

Инструкция [INSERT](../yql/reference/syntax/insert_into.md) используется для вставки одной или нескольких строк. При попытке вставить строку в таблицу, с уже существующим значением первичного ключа {{ ydb-short-name }} вернёт ошибку с сообщением ```Transaction rolled back due to constraint violation: insert_pk.```.

{% note info %}

При выполнении операции INSERT перед записью осуществляется чтение данных. Это делает ее менее эффективной, чем операции REPLACE и UPSERT. Для записи предпочтительнее использовать операции REPLACE или UPSERT.

{% endnote %}

Код, приведенный ниже, вставит в таблицу ```episodes``` одну строчку с данными.

{% include notitle [insert-into-3-columns](../_includes/queries/insert-into-3-columns.md) %}

### UPDATE {#update}

Инструкция [UPDATE](../yql/reference/syntax/update.md) изменяет значения колонок для строк таблицы, отфильтрованных по предикату из условия WHERE. Базовый синтаксис:

```sql
UPDATE имя_таблицы SET имя_столбца1=новое_значение_столбца1, ... ,имя_столбцаN=новое_значение_столбцаN WHERE условия_для_фильтра_строк;
```

Значения первичного ключа в рамках инструкции UPDATE не могут быть изменены. Введите и выполните следующую инструкцию UPDATE, чтобы изменить значение столбца ```title``` для эпизода с значениями столбцов ```series_id = 2```, ```season_id = 1```и ```episode_id = 3``` со значения "Test Episode" на значение "Test Episode Updated".

{% include notitle [update-3-columns](../_includes/queries/update-3-columns.md) %}

### DELETE {#delete}

Инструкция [DELETE](../yql/reference/syntax/delete.md) удаляет строки таблицы, отфильтрованные по предикату из условия WHERE. Код, приведенный ниже, удалит из таблицы ```episodes``` эпизод со следующими значениями столбцов: ```series_id = 2```, ```season_id = 5```, и ```episode_id = 21```.

{% include notitle [delete-from-3-columns](../_includes/queries/delete-from-3-columns.md) %}

## Запросите данные при помощи SELECT {#select}

Для чтения данных в таблице используется инструкция [SELECT](../yql/reference/syntax/select.md).

Чтобы запросить данные из таблицы ```series```, выполните код, представленный ниже.

{% include notitle [select-from-3-columns](../_includes/queries/select-from-3-columns.md) %}

Чтобы выбрать все столбцы в таблице, можно использовать звездочку. Для того чтобы получить значения всех столбцов из таблицы ```series```,
выполните код представленный ниже.

{% include notitle [select-all](../_includes/queries/select-all.md) %}

{% note info %}

Подробнее о том, как запросить данные по вторичному индексу, читайте в разделе [{#T}](../yql/reference/syntax/select.md#si-select).

{% endnote %}

## Сделайте параметризированный запрос {#param-queries}

Использование параметризованных запросов может улучшить производительность за счет сокращения частоты выполнения компиляции и перекомпиляции запросов.

**Пример**

```sql
DECLARE $seriesId AS Uint64;
DECLARE $seasonId AS Uint64;

$seriesId = 1;
$seasonId = 2;

SELECT sa.title AS season_title, sr.title AS series_title
FROM seasons AS sa
INNER JOIN series AS sr
ON sa.series_id = sr.series_id
WHERE sa.series_id = $seriesId AND sa.season_id = $seasonId;
```
