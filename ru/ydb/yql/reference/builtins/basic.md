# Базовые встроенные функции

Ниже описаны функции общего назначения, а для специализированных функций есть отдельные статьи: [агрегатные](aggregation.md), [оконные](window.md), а также статьи для работы со [списками](list.md), [словарями](dict.md) и [типами данных](types.md).

## COALESCE {#coalesce}

Перебирает аргументы слева направо и возвращает первый найденный непустой аргумент. Чтобы результат получился гарантированно непустым (не [optional типа](../types/optional.md)), самый правый аргумент должен быть такого типа (зачастую используют литерал). При одном аргументе его и возвращает без изменений.

Позволяет передавать потенциально пустые значения в функции, которые не умеют обрабатывать их самостоятельно.

Доступен краткий формат записи в виде оператора `??`, обладающего низким приоритетом (ниже булевых операций). Можно использовать алиас `NVL`.

**Примеры**

```sql
SELECT COALESCE(
  maybe_empty_column,
  "it's empty!"
) FROM my_table;
```

```sql
SELECT
  maybe_empty_column ?? "it's empty!"
FROM my_table;
```

```sql
SELECT NVL(
  maybe_empty_column,
  "it's empty!"
) FROM my_table;
```

## LENGTH {#length}

Длина строки в байтах. Также эта функция доступна под именем `LEN`.

**Примеры**

```sql
SELECT LENGTH("foo");
```

```sql
SELECT LEN("bar");
```

{% note info %}

Для вычисления длины строки в unicode символах можно воспользоваться функцией [Unicode::GetLength](../udf/list/unicode.md).<br><br>Для получения числа элементов в списке нужно использовать функцию [ListLength](list.md#listlength).

{% endnote %}

## SUBSTRING {#substring}

Возвращает подстроку.

Обязательные аргументы:

* Исходная строка;
* Позиция — отступ от начала строки в байтах (целое число).

Опциональные аргументы:

* Длина подстроки — количество байт, начиная с указанной позиции (целое число, по умолчанию «до конца исходной строки»).

Если указанные позиция и длина выходят за пределы строки, возвращает пустую строку.

**Примеры**

```sql
SELECT SUBSTRING("abcdefg", 3, 1); -- d
```

```sql
SELECT SUBSTRING("abcdefg", 3); -- defg
```

## IF {#if}

Проверяет условие `IF(condition_expression, then_expression, else_expression)`.

Упрощенная альтернатива — [CASE WHEN ... THEN ... ELSE ... END](../syntax/expressions.md#case).

Аргумент `else_expression` можно не указывать. В этом случае, если условие ложно (`condition_expression` вернул `false`), будет возвращено пустое значение с типом, соответствующим `then_expression` и допускающим значение `NULL`. Таким образом, у результата получится [optional тип данных](../types/optional.md).

**Примеры**
```  yql
SELECT
  IF(foo > 0, bar, baz) AS bar_or_baz,
  IF(foo > 0, foo) AS only_positive_foo
FROM my_table;
```

## NANVL {#nanvl}

Заменяет значения `NaN` (not a number) в выражениях типа `Float`, `Double` или [Optional](../types/optional.md).

Аргументы:

1. Выражение, в котором нужно произвести замену.
2. Значение, на которое нужно заменить `NaN`.

Если один из агрументов `Double`, то в выдаче `Double`, иначе `Float`. Если один из агрументов `Optional`, то и в выдаче `Optional`.

**Примеры**

```sql
SELECT
  NANVL(double_column, 0.0)
FROM my_table;
```

## Random, RandomNumber, RandomUuid {#random}

Генерирует псевдослучайное число:

* `Random` — число с плавающей точкой (Double) от 0 до 1;
* `RandomNumber` — целое число из всего диапазона Uint64;
* `RandomUuid` — [Uuid version 4](https://tools.ietf.org/html/rfc4122#section-4.4).

При генерации случайных чисел аргументы не используются и нужны исключительно для управления моментом вызова. В каждый момент вызова возвращается новое случайное число. Поэтому:

* Повторный вызов Random в рамках **одного запроса** при идентичном наборе аргументов возвращает тот же самый набор случайных чисел. Важно понимать, что речь именно про сами аргументы (текст между круглыми скобками), а не их значения.
* Вызовы Random с одним и тем же набором аргументов в **разных запросах** вернут разные наборы случайных чисел.

Сценарии использования:

* `SELECT RANDOM(1);` — получить одно случайное значение на весь запрос и несколько раз его использовать (чтобы получить несколько, можно передать разные константы любого типа);
* `SELECT RANDOM(1) FROM table;` — одно и то же случайное число на каждую строку таблицы;
* `SELECT RANDOM(1), RANDOM(2) FROM table;` — по два случайных числа на каждую строку таблицы, все числа в каждой из колонок одинаковые;
* `SELECT RANDOM(some_column) FROM table;` — разные случайные числа на каждую строку таблицы;
* `SELECT RANDOM(some_column), RANDOM(some_column) FROM table;` — разные случайные числа на каждую строку таблицы, но в рамках одной строки — два одинаковых числа;
* `SELECT RANDOM(some_column), RANDOM(some_column + 1) FROM table;` или `SELECT RANDOM(some_column), RANDOM(other_column) FROM table;` — две колонки, и все с разными числами.

**Примеры**
```sql
SELECT
    Random(key) -- [0, 1)
FROM my_table;
```

```sql
SELECT
    RandomNumber(key) -- [0, Max<Uint64>)
FROM my_table;
```

```sql
SELECT
    RandomUuid(key) -- Uuid version 4
FROM my_table;
```

```sql
SELECT
    RANDOM(column) AS rand1,
    RANDOM(column) AS rand2, -- same as rand1
    RANDOM(column, 1) AS randAnd1, -- different from rand1/2
    RANDOM(column, 2) AS randAnd2 -- different from randAnd1
FROM my_table;
```

## CurrentUtcDate, CurrentUtcDatetime и CurrentUtcTimestamp {#currentutcdate}

Получение текущей даты и/или времени в UTC. Тип данных результата указан в конце названия функции.

Аргументы опциональны и работают по тому же принципу, что и у [RANDOM](#random).

**Примеры**
```sql
SELECT CurrentUtcDate();
```
```sql
SELECT CurrentUtcTimestamp(TableRow()) FROM my_table;
```

## AddTimezone {#addtz}

Добавление информации о временной зоне к дате/времени, заданных в UTC. При выводе в результате `SELECT` или после `CAST` в `String` будут применены правила временной зоны по вычислению смещения времени.

Аргументы:

1. Дата — тип `Date`/`Datetime`/`Timestamp`;
2. [IANA имя временной зоны](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

Тип результата — `TzDate`/`TzDatetime`/`TzTimestamp`, в зависимости от типа данных входа.

**Примеры**
```  yql
SELECT AddTimezone(Datetime("2018-02-01T12:00:00Z"), "Europe/Moscow");
```

## RemoveTimezone {#removetz}

Удаляет информацию о временной зоне и переводит в дату/время, заданные в UTC.

Аргументы:

Дата — тип `TzDate`/`TzDatetime`/`TzTimestamp`.

Тип результата:

`Date`/`Datetime`/`Timestamp`, в зависимости от типа данных входа.

**Примеры**

```sql
SELECT RemoveTimezone(TzDatetime("2018-02-01T12:00:00,Europe/Moscow"));
```

## MAX_OF, MIN_OF, GREATEST и LEAST {#max-min}

Возвращают минимальный или максимальный среди N аргументов. Эти функции позволяют не использовать стандартную для SQL конструкцию `CASE WHEN a < b THEN a ELSE b END`, которая была бы особенно громоздкой для N больше двух.

Типы аргументов должны быть приводимы друг к другу и могут допускать значение `NULL`.

`GREATEST` является синонимом к `MAX_OF`, а `LEAST` — к `MIN_OF`.

**Примеры**
```  yql
SELECT MIN_OF(1, 2, 3);
```

## AsTuple, AsStruct, AsList, AsDict, AsListStrict и AsDictStrict {#as-container}

Создает контейнеры соответствующих типов.

Особенности:

* Элементы контейнеров передаются через аргументы, таким образом число элементов результирующего контейнера равно числу переданных аргументов, кроме случая, когда повторяются ключи словаря.
* В `AsTuple` и `AsStruct` могут быть вызваны без аргументов, а также аргументы могут иметь разные типы.
* Имена полей в `AsStruct` задаются через `AsStruct(field_value AS field_name)`.
* Для создания списка требуется хотя бы один аргумент, чтобы вывести типы элементов. Для создания пустого списка используется функция [ListCreate](list.md#listcreate).
* Для создания словаря требуется хотя бы один аргумент, чтобы вывести типы элементов. Для создания пустого словаря используется функция [DictCreate](dict.md#listcreate).
* `AsList` выводит общий тип элементов списка. При несовместимых типах генерируется ошибка типизации.
* `AsDict` выводит раздельно общие типы ключей и значений. При несовместимых типах генерируется ошибка типизации.
* `AsListStrict` и `AsDictStrict` требуют одинакового типа для аргументов.
* В `AsDict` и `AsDictStrict` в качестве аргументов ожидаются `Tuple` из двух элементов: ключ и значение, соответственно. Если ключи повторяются, в словаре останется только значение для первого ключа.

**Примеры**

```sql
SELECT
  AsTuple(1, 2, "3") AS tuple,
  AsStruct(
    1 AS a,
    2 AS b,
    "3" AS c
  ) AS struct,
  AsList(1, 2, 3) AS list,
  AsDict(
    AsTuple("a", 1),
    AsTuple("b", 2),
    AsTuple("c", 3)
  ) AS dict;
```

## AsTagged и Untag {#as-tagged}

Оборачивает значение в [Tagged тип данных](../types/special.md) с указаной меткой с сохранением физического типа данных. `Untag` — обратная операция.

Обязательные аргументы:

1. Значение произвольного типа;
2. Имя метки.

Возвращает копию значения из первого аргумента с указанной меткой в типе данных.

Примеры сценариев использования:

* Возвращение на клиент для отображения в веб-интерфейсе медиа-файлов из base64-encoded строк;
* Защита на границах вызова UDF от передачи некорректных значений;
* Дополнительные уточнения на уровне типов возвращаемых колонок.

{% if audience != "external" %}

Поддерживаемые веб-интерфейсом mime-type и одноименные метки ([пример](https://yql.yandex-team.ru/Operations/WwwjZTa9vP89o89j9Qzd43CwTo-z297_nePqwHS70fM=)):

{% else %}

Поддерживаемые веб-интерфейсом mime-type и одноименные метки:

{% endif %}

* image/jpeg
* image/png
* image/gif
* image/webp
* image/svg
* image/svg+xml
* audio/mp4
* audio/webm
* video/mp4
* video/webm

Также им поддерживаются кликабельные ссылки и показ медиа плеера для контента по ссылке, для отображения которых нужно указывать следующие метки:

* url
* imageurl
* audiourl
* videourl

Веб-интерфейс поддерживает расширенный синтаксис для некоторых тегов.

### Ссылка с произвольным текстом {#url-struct}

Чтобы сформировать в выдаче «красивую» ссылку с произвольным текстом, в тег `url` заворачивается структура `Struct<href:String?,text:String?,title:String?>`.

**Примеры**

```sql
SELECT AsTagged(
    AsStruct(
        "https://yandex.ru/" AS href,
        "Yandex main page" AS text,
        "Yandex" AS title
    ),
    "url"
);
```

### Изображение с заданным размером {#set-size-image}

Для ограничения размеров картинки в теги `image/*` и `imageurl` заворачивается структура `Struct<src:String,width:Int64?,height:Int64?,maxWidth:Int64?,maxHeight:Int64>`.

Здесь поле `src` обязательное, все размеры опциональны и задаются в пикселях.

**Примеры**

```sql
SELECT AsTagged(
    AsStruct(
        "https://avatars.yandex-team.ru/get-yablog/id1166620212013/normal" AS src,
        200 AS maxWidth,
        200 AS maxHeighgitt
    ),
    "imageurl"
);
```

{% if audience == "internal" %}

## TablePath {#tablepath}

Доступ к текущему имени таблицы, что бывает востребованно при использовании [CONCAT](../syntax/select.md#concat), [RANGE](../syntax/select.md#range) и других подобных механизмов.

Аргументов нет. Возвращает строку c полным путём, либо пустую строку и warning при использовании в неподдерживаем контексте (например, при работе с подзапросом или диапазоном из 1000+ таблиц).

**Примеры**

```sql
SELECT TablePath() FROM CONCAT(table_a, table_b);
```
## TableName {#tablename}

Получить имя таблицы из пути к таблице. Путь можно получить через функцию [TablePath](#tablepath), или в виде колонки `Path` при использовании табличной функции [FOLDER](../syntax/select.md#folder).

Необязательные аргументы:

* путь к таблице, по умолчанию используется `TablePath()` (также см. его ограничения);
* указание системы ("yt"), по правилам которой выделяется имя таблицы. Указание системы нужно только в том случае, если с помощью [USE](../syntax/select.md#use) не указан текущий кластер.

**Примеры**

```sql
USE hahn;
SELECT TableName() FROM CONCAT(table_a, table_b);
```

```sql
SELECT TableName(Path, "yt") FROM hahn.FOLDER(folder_name);
```

## TableRecord {#tablerecord}

Доступ к текущему порядковому номеру строки в исходной физической таблице, **начиная с 1** (зависит от реализации хранения).

Аргументов нет. При использовании в сочетании с [CONCAT](../syntax/select.md#concat), [RANGE](../syntax/select.md#range) и другими подобными механизмами нумерация начинается заново для каждой таблицы на входе. В случае использования в некорректном контексте возвращает 0.

**Примеры**

```sql
SELECT TableRecord() FROM my_table;
```

{% endif %}

## TableRow {#tablerow}

Получение всей строки таблицы целиком в виде структуры. Аргументов нет.

**Примеры**

```sql
SELECT TableRow() FROM my_table;
```
{% if audience == "internal" %}

## FileContent и FilePath

Как [консольный](../interfaces/cli.md), так и [веб](../interfaces/web.md)-интерфейсы позволяют «прикладывать» к запросу произвольные именованные файлы. С помощью этих функций можно по имени приложенного файла получить его содержимое или путь в «песочнице» и в дальнейшем использовать в запросе произвольным образом.

Аргумент `FileContent` и `FilePath` — строка c алиасом.

**Примеры**

```sql
SELECT "Content of "
  || FilePath("my_file.txt")
  || ":\n"
  || FileContent("my_file.txt");
```
## FolderPath {#folderpath}

Получение пути до корня директории с несколькими «приложенными» файлами с указанным общим префиксом.

Аргумент — строка c префиксом среди алиасов.

Также см. [PRAGMA File](../syntax/pragma.md#file) и [PRAGMA Folder](../syntax/pragma.md#folder).

**Примеры**

```sql
PRAGMA File("foo/1.txt", "http://url/to/somewhere");
PRAGMA File("foo/2.txt", "http://url/to/somewhere/else");
PRAGMA File("bar/3.txt", "http://url/to/some/other/place");

SELECT FolderPath("foo"); -- в директории по возвращённому пути будут
                          -- находиться файлы 1.txt и 2.txt, скачанные по указанным выше ссылкам
```
{% if audience != "external" %}
## ParseFile {#parsefile}

Получить из приложенного текстового файла список значений. Может использоваться в сочетании с [IN](../syntax/expressions.md#in) и прикладыванием файла по URL(инструкции по прикладыванию файлов для [веб-интерфейса](../interfaces/web.md#attach) и [клиента](../interfaces/cli.md#attach)).

Поддерживается только один формат файла — по одному значению на строку. Для чего-то более сложного прямо сейчас придется написать небольшую UDF на [Python](../udf/python.md) или [Javascript](../udf/javascript.md), либо попросить на [yql@](https://ml.yandex-team.ru/lists/yql) добавить нужный формат, если он широко распространен.

Два обязательных аргумента:

1. Тип ячейки списка: поддерживаются только строки и числовые типы;
2. Имя приложенного файла.

{% note info %}

Возвращаемое значние — ленивый список. Для многократного использования его нужно обернуть в функцию [ListCollect](list.md#listcollect)

{% endnote %}

**Примеры**

```sql
SELECT ListLength(ParseFile("String", "my_file.txt"));
```

```sql
SELECT * FROM my_table
WHERE int_column IN ParseFile("Int64", "my_file.txt"));
```
{% endif %}

## WeakField {#weakfield}

Вытаскивает колонку таблицы из строгой схемы, если она там есть, либо из полей `_other` и {% if audience != "external" %} [_rest](https://wiki.yandex-team.ru/logfeller/schema/yt/#osobennostirabotysosxematizirovannymitablicami) {% else %} `rest` {% endif %} . В случае отсутствия значения возвращается `NULL`.

Синтаксис: `WeakField([<table>.]<field>, "<type>"[, <default_value>])`.

Значение по умолчанию используется только в случае отсутствия колонки в схеме данных. Чтобы подставить значение по умолчанию в любом случае можно воспользоваться [COALESCE](#coalesce).

**Примеры**

```sql
SELECT
    WeakField(my_column, "String", "no value"),
    WeakField(my_table.other_column, "Int64")
FROM my_table;
```

{% endif %}

## Ensure, EnsureType и EnsureConvertibleTo {#ensure}

Проверка пользовательских условий:

* `Ensure` — проверка верности предиката во время выполнения запроса;
* `EnsureType` — проверка точного соответствия типа выражения указанному;
* `EnsureConvertibleTo` — мягкая проверка соответствия типа выражения, работающая по тем же правилам, что и неявное приведение типов.

Если проверка не прошла успешно, то весь запрос завершается с ошибкой.

Аргументы:

1. Выражение, которое станет результатом вызова функции в случае успеха проверки. Оно же подвергается проверке на тип данных в соответствующих функциях.
2. В Ensure — булевый предикат, который проверяется на `true`. В остальных функциях — тип данных, который может быть получен через [предназначенные для этого функции](types.md), либо строковый литерал с [текстовым описанием типа](../misc/type_string.md).
3. Опциональная строка с комментарием к ошибке, которая попадет в общее сообщение об ошибке при завершении запроса. Для проверок типов не может использовать сами данные, так как они выполняются на этапе валидации запроса, а для Ensure — может быть произвольным выражением.

Для проверки условий по финальному результату вычисления Ensure удобно использовать в сочетании с [DISCARD SELECT](../syntax/discard.md).

**Примеры**

```sql
SELECT Ensure(
    value,
    value < 100,
    "value out or range"
) AS value FROM my_table;
```

```sql
SELECT EnsureType(
    value,
    TypeOf(other_value),
    "expected value and other_value to be of same type"
) AS value FROM my_table;
```

```sql
SELECT EnsureConvertibleTo(
    value,
    "Double?",
    "expected value to be numeric"
) AS value FROM my_table;
```

{% if audience == "internal" %}

## EvaluateExpr и EvaluateAtom {#evaluate}

Возможность выполнить выражение до начала основного расчета и подставить его результат в запрос как литерал (константу). Во многих контекстах, где в стандартном SQL ожидалась бы только константа (например, в именах таблиц, количестве строк в [LIMIT](../syntax/select.md#limit) и т.п.) этот функционал активируется неявным образом автоматически.

EvaluateExpr может использоваться в тех местах, где грамматикой уже ожидается выражение. Например, с его помощью можно:

* округлить текущее время до дней, недель или месяцев и подставить в запрос, что затем позволит корректно работать [кешированию запросов](../syntax/pragma.md#querycachemode)), хотя обычно использование `YQL::Now()` его полностью отключает;
* сделать тяжелое вычисление с небольшим результатом один раз на запрос вместо одного раза на каждую джобу.

`EvaluateAtom позволяет` динамически менять те части запроса, где обычно ожидалась бы только константа.

Единственный аргумент у обоих функций — само выражение для вычисление и подстановки.

Ограничения:

* выражение не должно приводить к запуску MapReduce операций;
* данный функционал полностью заблокирован в YQL over YDB.

**Примеры**

```sql
$now = CurrentUtcTimestamp();
SELECT EvaluateExpr(
    DateTime::DateStartOfWeek(
        CAST($now AS Date)
    )
);
```

```sql
USE hahn;

$folder_path = AsList("home", "yql", "tutorial");
$table = "users";
$order = EvaluateAtom(ListConcat(AsList("a", "g", "e")));
$full_path = String::JoinFromList(ListExtend($folder_path, AsList($table)), "/");
$limit = 2 + 2;

SELECT * FROM $full_path
ORDER BY YQL::Member(TableRow(), $order) DESC
LIMIT $limit;
```
{% endif %}

## Создание литералов простых типов на основе строкового литерала {#data-type-literals}

В отличие от `CAST("myString" AS MyType)`:

* Проверка на приводимость литерала к требуемому типу происходит на этапе валидации;
* Результат не является optional.

Для типов данных `Date`, `Datetime`, `Timestamp` и `Interval` поддерживаются литералы только в формате, соответствующем [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). У `Interval` есть следующие отличия от стандарта:

* поддерживается отрицательный знак для сдвигов в прошлое;
* микросекунды могут быть записаны как дробная часть секунд;
* единицы измерения больше суток не доступны;
* не поддерживаются варианты с началом/концом интервала, а также повторами.

Для типов данных `TzDate`, `TzDatetime`, `TzTimestamp` литералы также задаются в формате, соответствующем [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601), но вместо опционального суффикса Z через запятую указывается [IANA имя временной зоны](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones), например, GMT или Europe/Moscow.

{% include notitle [Десятичные типы](../../../_includes/decimal_args.md) %}

**Примеры**

```sql
 SELECT
  Bool("true"),
  Uint8("0"),
  Int32("-1"),
  Uint32("2"),
  Int64("-3"),
  Uint64("4"),
  Float("-5"),
  Double("6"),
  Decimal("1.23", 5, 2); -- до 5 десятичных знаков, из которых 2 после запятой
  String("foo"),
  Utf8("привет"),
  Yson("<a=1>[3;%false]"),
  Json(@@{"a":1,"b":null}@@),
  Date("2017-11-27"),
  Datetime("2017-11-27T13:24:00Z"),
  Timestamp("2017-11-27T13:24:00.123456Z"),
  Interval("P1DT2H3M4.567890S"),
  TzDate("2017-11-27,Europe/Moscow"),
  TzDatetime("2017-11-27T13:24:00,America/Los_Angeles"),
  TzTimestamp("2017-11-27T13:24:00.123456,GMT"),
  Uuid("f9d5cc3f-f1dc-4d9c-b97e-766e57ca4ccb");
```

## Доступ к метаданным текущей операции {#metadata}

При запуске YQL операций через веб-интерфейс или API, предоставляется доступ к следующей информации:

* `CurrentOperationId` — приватный идентификатор операции;
* `CurrentOperationSharedId` — публичный идентификатор операции;
* `CurrentAuthenticatedUser` — логин текущего пользователя.

Аргументов нет.

При отсутствии данной информации, например при запуске в embedded режиме, возвращают строку.

**Примеры**

```sql
SELECT
    CurrentOperationId(),
    CurrentOperationSharedId(),
    CurrentAuthenticatedUser();
```

## ToBytes и FromBytes {#tobytes}

Конвертация [простых типов данных](../types/primitive.md) в строку со своим бинарным представлением и обратно. Числа представляются в [little endian](https://en.wikipedia.org/wiki/Endianness#Little-endian).

**Примеры**

```sql
SELECT
    ToBytes(123), -- "\u0001\u0000\u0000\u0000"
    FromBytes(
        "\xd2\x02\x96\x49\x00\x00\x00\x00",
        "Uint64"
    ); -- 1234567890ul
```

## ByteAt {#byteat}

Получение значение байта в строке по индексу от её начала. В случае некорректного индекса возвращается `NULL`.

Аргументы:

1. Строка: `String` или `Utf8`;
2. Индекс: `Uint32`.

**Примеры**

```sql
SELECT
    ByteAt("foo", 0) -- 102
    ByteAt("foo", 1) -- 111
    ByteAt("foo", 9) -- NULL
```

## TestBit, ClearBit, SetBit и FlipBit {#testbit}

Проверить, сбросить, установить или инвертировать бит в беззнаковом числе по указанному порядковому номеру бита.

Аргументы:

1. Беззнаковое число, над которым выполнять требуемую операцию. `TestBit` также реализован и для строк.
2. Номер бита.

`TestBit` возвращает `true/false`. Остальные функции возвращают копию своего первого аргумента с проведенным соответствующим преобразованием.

**Примеры**
```sql
SELECT
    TestBit(1u, 0), -- true
    SetBit(8u, 0); -- 9
```

## Abs {#abs}

Абсолютное значение числа.

**Примеры**

```sql
SELECT Abs(-123); -- 123
```

## Just {#just}

Изменить тип данных значения на [optional](../types/optional.md) от текущего типа данных (то есть `T` превращается в `T?`).

Обратная операция — [Unwrap](#unwrap).

**Примеры**

```sql
SELECT
  Just("my_string"); --  String?
```

## Unwrap {#unwrap}

Преобразование значения [optional](../types/optional.md) типа данных в соответствующий не-optional тип с ошибкой времени выполнений, если в данных оказался `NULL`. Таким образом, `T?` превращается в `T`.

Аргументы:

1. Значение для преобразования;
2. Опциональная строка с комментарием для текста ошибки.

Обратная операция — [Just](#just).

**Примеры**

```sql
$value = Just("value");

SELECT Unwrap($value, "Unexpected NULL for $value");
```

## Nothing {#nothing}

Создать пустое значение указанного [optional](../types/optional.md) типа данных.

**Примеры**

```sql
SELECT
  Nothing(ParseType("String?")); -- пустое значение (NULL) с типом String?
```

Подробнее о `ParseType` и других функциях для работы с типами данных читайте в разделе [Типы данных](types.md).

## AGGREGATION_FACTORY {#aggregationfactory}

Создать фабрику для [агрегационных функций](aggregation.md) для того чтобы разделить процесс описания того, как агрегрировать данные, и то, к каким данным это применять.

Аргументы:

1. Строка в кавычках, являющаяся именем агрегационной функции, например ["MIN"](aggregation.md#min).
2. Опциональные параметры агрегационной функции, которые не зависят от данных. Например, значение percentile в [PERCENTILE](aggregation.md#percentile).

Полученную фабрику можно использовать как второй параметр функции [AGGREGATE_BY](aggregation.md#aggregateby).
Если агрегационная функция работает на двух колонках вместо одной, как например, [MIN_BY](aggregation.md#minby), то в [AGGREGATE_BY](aggregation.md#aggregateby) первым аргументом передается `Tuple` из двух значений. Подробнее это указано при описании такой агрегационной функции.

**Примеры**

```  yql
$factory = AGGREGATION_FACTORY("MIN");
SELECT
    AGGREGATE_BY(value, $factory) AS min_value -- применить MIN агрегацию к колонке value
FROM my_table;
```

## LIKELY {#likely}

Позволяет подсказать оптимизатору, что содержащееся в аргументе булевое значение чаще всего будет `true`. На данный момент эта подсказка используется только при выборе стратегии выполнения [JOIN](../syntax/join.md).

## GROUPING {#grouping}

Позволяет отличить промежуточный итог от `NULL` в исходных данных при агрегации. Подробнее см. в документации по [ROLLUP, CUBE и GROUPING SETS](../syntax/group_by.md#rollup).

{% if audience == "internal" %}

## YQL:: {#yql}

Ассортимент существующих встроенных в YQL функций намного шире перечисленного выше, но многие из них предназначены прежде всего для внутреннего использования или для некоторых особых случаев.

Полный список внутренних функций находится в [документации к s-expressions](../s_expressions/functions.md), альтернативному внутреннему синтаксису YQL. Любую из перечисленных там функций можно вызвать и из SQL синтаксиса, добавив к её имени префикс `YQL::`. Без префикса они или не доступны из SQL синтаксиса или имеют право вести себя по-другому.

**Примеры**

```  yql
SELECT
  YQL::Concat("a", "b"); -- в реальности так писать не рекомендуется,
                         -- так как это аналог SELECT "a" || "b";
```
{% endif %}
