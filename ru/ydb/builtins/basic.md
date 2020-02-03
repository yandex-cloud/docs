# Встроенные функции

## COALESCE {#coalesce}

Перебирает аргументы слева направо и возвращает первый найденный не пустой аргумент. Самый правый аргумент должен быть гарантированно не пустым (не optional-типа).

Позволяет передавать потенциально пустые значения в функции, которые не умеют их обрабатывать самостоятельно.

Доступен краткий формат записи в виде оператора `??`, обладающим низким приоритетом (ниже булевых операций).

Можно использовать алиас `NVL`.

Приведенные справа примеры эквивалентны.

**Примеры:**
```sql
SELECT COALESCE(
  maybe_empty_column,
  "it's empty!"
) FROM my_table;
```

```sql
SELECT NVL(
  maybe_empty_column,
  "it's empty!"
) FROM my_table;
```

```sql
SELECT
  maybe_empty_column ?? "it's empty!"
FROM my_table;
```

## LENGTH {#length}

Длина строки в байтах.

Для вычисления длины строки в символах unicode можно воспользоваться функцией [Unicode::GetLength](../udf/list/unicode.md).

**Примеры:**
```sql
SELECT LENGTH("foo");
```

## SUBSTRING {#substring}

Получить подстроку.

Обязательные аргументы:

* Исходная строка;
* Позиция — отступ от начала строки в байтах (целое число);

Опциональные аргументы:

* Длина подстроки — количество байт начиная с указанной позиции (целое число, по умолчанию до конца исходной строки).

Если указанные позиция и длина выходят за пределы строки, возвращает пустую строку.

**Примеры:**
```sql
SELECT SUBSTRING("abcde", 1, 2); -- bc
```
```sql
SELECT SUBSTRING("abcde", 3); -- de
```

## IF {#if}

Проверка условия: `IF(condition_expression, then_expression, else_expression)`.

Упрощенная альтернатива `CASE WHEN ... THEN ... ELSE ... END`.

Аргумент `else_expression` можно не указывать: в этом случае, если условие ложно (`condition_expression` вернул `false`), будет возвращено пустое значение  (Optional type), с типом, соответствующим `then_expression` и допускающим значение `NULL`.

**Примеры:**
```sql
SELECT
  IF(foo > 0, bar, baz) AS bar_or_baz,
  IF(foo > 0, foo) AS only_positive_foo
FROM my_table;
```

## NANVL {#nanvl}

Замена значения `NaN` (not a number) в выражении типа `Float`, `Double` или `Optional` от них.

Аргументы:

1. Выражение, в котором нужно произвести замену
2. Значение, на которое нужно заменить `NaN`

Если один из агрументов `Double`, то в выдаче `Double`, иначе `Float`. Если один из агрументов `Optional`, то и в выдаче `Optional`.

**Примеры:**
```sql
SELECT
  NANVL(double_column, 0.0)
FROM my_table;
```

## Random и RandomNumber {#random-randomnumber}
<a name="random"></a><a name="randomnumber"></a>

Сгенерировать псевдослучайное число:

* `Random` — число с плавающей точкой (Double) от 0 до 1;
* `RandomNumber` — целое число из всего диапазона Uint64.

Аргументы при генерации случайных чисел не используются и нужны исключительно для управления моментом вызова. В каждый момент вызова возвращается новое случайное число. Поэтому:

* Повторный вызов Random в рамках **одного запроса** при идентичном наборе аргументов возвращает тот же самый набор случайных чисел. Важно понимать, что речь именно про сами аргументы (текст между круглыми скобками), а не их значения.
* Вызовы Random с одним и тем же набором аргументов в **разных запросах** вернут разные наборы случайных чисел.

Сценарии использования:

* `SELECT RANDOM(1);` — получить одно случайное значение на весь запрос и несколько раз его использовать (чтобы получить несколько, можно передать разные константы любого типа);
* `SELECT RANDOM(1) FROM table;` — одно и то же случайное число на каждую строку таблицы;
* `SELECT RANDOM(1), RANDOM(2) FROM table;` — по два случайных числа на каждую строку таблицы, все числа в каждой из колонок одинаковые;
* `SELECT RANDOM(some_column) FROM table;` — разные случайные числа на каждую строку таблицы;
* `SELECT RANDOM(some_column), RANDOM(some_column) FROM table;` — разные случайные числа на каждую строку таблицы, но в рамках одной строки — два одинаковых числа;
* `SELECT RANDOM(some_column), RANDOM(some_column + 1) FROM table;` или `SELECT RANDOM(some_column), RANDOM(other_column) FROM table;` — две колонки, и все с разными числами.

**Примеры:**
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
    RANDOM(column) AS rand1,
    RANDOM(column) AS rand2, -- same as rand1
    RANDOM(column, 1) AS randAnd1, -- different from rand1/2
    RANDOM(column, 2) AS randAnd2 -- different from randAnd1
FROM my_table;
```

## CurrentUtcDate, CurrentUtcDatetime и CurrentUtcTimestamp {#currentutcdate-currentutcdatetime-currentutctimestamp}

Получение текущей даты и/или времени в UTC. Тип данных результата указан в конце названия функции.

Аргументы опциональны и работают по тому же принципу, что и у [RANDOM](#random).

**Примеры:**
```sql
SELECT CurrentUtcDate();
```
```sql
SELECT CurrentUtcTimestamp(TableRow()) FROM my_table;
```

## MAX_OF, MIN_OF, GREATEST и LEAST {#max-of-min-of-greatest-least}

Возвращают минимальный или максимальный среди N аргументов.
Эти функции позволяют не использовать стандартную для SQL конструкцию `CASE WHEN a < b THEN a ELSE b END`, которая была бы особенно громоздкой для N больше двух.

Типы аргументов должны быть приводимы друг к другу и могут допускать значение NULL.

`GREATEST` является синонимом к `MAX_OF`, а `LEAST` — к `MIN_OF`.

**Примеры:**
```sql
SELECT MIN_OF(1, 2, 3);
```

## AsTuple, AsStruct, AsList и AsDict {#astuple-asstruct-aslist-asdict}

Создание контейнеров соответствующих типов.

Особенности:

* Элементы контейнеров передаются через аргументы, таким образом число элементов результирующего контейнера равно числу переданных аргументов.
* В `AsTuple` и `AsStruct` могут быть вызваны без аргументов, а также аргументы могут иметь разные типы.
* `AsList` и `AsDict` требуют одинакового типа данных для аргументов и требуют хотя бы одного аргумента, чтобы этот тип зафиксировать.
* Имена полей в `AsStruct` задаются через `AsStruct(field_value AS field_name)`.
* В `AsDict` в качестве аргументов ожидаются `Tuple` из двух элементов: ключ и значение, соответственно.

**Примеры:**
```sql
SELECT
  AsTuple(1, 2, "3") AS tuple,
  AsStruct(1 AS a,
   2 AS b,
   "3" AS c) AS struct,
  AsList(1, 2, 3) AS list,
  AsDict(
    AsTuple("a", 1),
    AsTuple("b", 2),
    AsTuple("c", 3)
  ) AS dict;
```
## AsTagged и Untag {#astagged-untag}

AsTagged оборачивает значение в Tagged тип данных с указаной меткой с сохранением физического типа данных. Untag — обратная операция.

Обязательные аргументы:

1. Значение произвольного типа
2. Имя метки

Возвращает копию значения из первого аргумента с указанной меткой в типе данных.

Примеры сценариев использования:

* Возвращение на клиент для отображения в веб-интерфейсе медиа-файлов из base64-encoded строк;
* Защита на границах вызова UDF от передачи некорректных значений;
* Дополнительные уточнения на уровне типов возвращаемых колонок.

Поддерживаемые mime-type и одноименные метки:

  * image/jpeg
  * image/png
  * image/gif
  * image/webp
  * image/svg
  * image/svg+xml
  * video/mp4

[Пример](https://yql.yandex-team.ru/Operations/WwwjZTa9vP89o89j9Qzd43CwTo-z297_nePqwHS70fM=)
{% if yt %}
## TablePath {#tablepath}

Доступ к текущему имени таблицы, что бывает востребованно при использовании [CONCAT](../syntax/extensions.md#concat), [RANGE](../syntax/extensions.md#range) и других подобных механизмов.

Аргументов нет. Возвращает строку c полным путём к таблице, либо пустую строку при использовании в некорректном контексте.

**Примеры:**
```sql
SELECT TablePath() FROM CONCAT(table_a, table_b);
```

## TableRecord {#tablerecord}

Доступ к текущему порядковому номеру строки в исходной физической таблице, **начиная с 1** (зависит от реализации хранения).

Аргументов нет. При использовании в сочетании с [CONCAT](../syntax/extensions.md#concat), [RANGE](../syntax/extensions.md#range) и другими подобными механизмами нумерация начинается заново для каждой таблицы на входе. В случае использования в некорректном контексте возвращает 0.

**Примеры:**
```sql
SELECT TableRecord() FROM my_table;
```
{% endif %}
## TableRow {#tablerow}

Получение всей строки таблицы целиком в виде структуры. Аргументов нет.

**Примеры:**
```sql
SELECT TableRecord() FROM my_table;
```
{% if yt %}
## FileContent и FilePath {#filecontent-filepath}

Как консольный, так и веб-интерфейсы позволяют «прикладывать» к запросу произвольные именованные файлы. С помощью этих функций можно по имени приложенного файла получить его содержимое или путь в «песочнице» MapReduce-кластера и в дальнейшем использовать в запросе произвольным образом.

Аргумент `FileContent` и `FilePath` — строка c алиасом.

**Примеры:**
```sql
SELECT "Content of "
  || FilePath("my_file.txt")
  || ": "
  || FileContent("my_file.txt");
```
## FolderPath {#folderpath}

Получение пути до корня директории с несколькими «приложенными» файлами с указанным общим префиксом.

Аргумент — строка c префиксом среди алиасов.

Также см. [PRAGMA File](../pragmas.md#file) и [PRAGMA Folder](../pragmas.md#folder).

**Примеры:**
```sql
PRAGMA File("foo/1.txt", "http://url/to/somewhere");
PRAGMA File("foo/2.txt", "http://url/to/somewhere/else");
PRAGMA File("bar/3.txt", "http://url/to/some/other/place");

SELECT FolderPath("foo"); -- в директории по возвращённому пути будут
                          -- находиться файлы 1.txt и 2.txt, скачанные по указанным выше ссылкам
```

## ParseFile {#parsefile}

Получить из приложенного текстового файла список значений. Может использоваться в сочетании с [IN](../syntax/basic.md#in) и прикладыванием файла по URL <span style="color:gray;">(инструкции по прикладыванию файлов для <a href="../interfaces/web/">веб-интерфейса</a> и <a href="../interfaces/cli/">клиента</a></span>.

Поддерживается только один формат файла — по одному значению на строку. Для чего-то более сложного прямо сейчас придется написать небольшую UDF на [Python](../udf/python.md) или [Javascript](../udf/javascript.md), либо попросить на [yql@](https://ml.yandex-team.ru/lists/yql) добавить нужный формат, если он широко распространен.

Два обязательных аргумента:

1. Тип ячейки списка: поддерживаются только строки и числовые типы.
2. Имя приложенного файла.

**Примеры:**
```sql
SELECT ListLength(ParseFile("String", "my_file.txt"));
```
```sql
SELECT * FROM my_table
WHERE int_column IN ParseFile("Int64", "my_file.txt"));
```

## WeakField {#weakfield}

Вытаскивает колонку таблицы из строгой схемы, если оно там есть, либо из полей `_other` и [_rest](https://wiki.yandex-team.ru/logfeller/schema/yt/#osobennostirabotysosxematizirovannymitablicami). В случае отсутствия значения возвращается `NULL`.

Синтаксис: `WeakField([<table>.]<field>, "<type>"[, <default_value>])`.

Значение по умолчанию используется только в случае отсутствия колонки в схеме данных. Чтобы подставить значение по умолчанию в любом случае можно использовать [COALESCE](#coalesce).

**Примеры:**
```sql
SELECT
    WeakField(my_column, "String", "no value"),
    WeakField(my_table.other_column, "Int64")
FROM my_table;
```
{% endif %}
## Ensure, EnsureType и EnsureConvertibleTo {#ensure-ensuretype-ensureconvertibleto}

Проверка пользовательских условий:

* Ensure — проверка верности предиката во время выполнения запроса.
* EnsureType — проверка точного соответствия типа выражения указанному.
* EnsureConvertibleTo — мягкая проверка соответствия типа выражения, работающая по тем же правилам, что и неявное приведение типов.
Если проверка не прошла успешно, то весь запрос завершается с ошибкой.

Аргументы:

1. Выражение, которое станет результатом вызова функции в случае успеха проверки. Оно же подвергается проверке на тип данных в соответствующих функциях.
2. В Ensure — булевый предикат, который проверяется на true. В остальных функциях — тип данных, который может быть получен через [предназначенные для этого функции](types.md), либо строковый литерал с [текстовым описанием типа](../misc/type_string.md).
3. Опциональная строка с комментарием к ошибке, которая попадет в общее сообщение об ошибке при завершении запроса. Для проверок типов обязана быть строковым литералом, т.к. они выполняются на этапе валидации запроса, а для Ensure может быть произвольным выражением.

Для проверки условий по финальному результату вычисления Ensure удобно использовать в сочетании с [DISCARD SELECT](../syntax/extensions.md#discard).

**Примеры:**
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
{% if yt %}
## EvaluateExpr и EvaluateAtom {#evaluateexpr-evaluateatom}

Возможность выполнить выражение до начала основного расчета и подставить его результат в запрос как литерал (константу). Во многих контекстах, где в стандартном SQL ожидалась бы только константа (например, в именах таблиц, количестве строк в [LIMIT](../syntax/basic.md#limit) / [OFFSET](../syntax/basic.md#offset) и т.п.) этот функционал активируется неявным образом автоматически.

EvaluateExpr может использоваться в тех местах, где грамматикой уже ожидается выражение. Например, с его помощью можно:

* округлить текущее время до дней, недель или месяцев и подставить в запрос, что затем позволит корректно работать [кешированию запросов](../pragmas.md#querycachemode)), хотя обычно использование `YQL::Now()` его полностью отключает;
* сделать тяжелое вычисление с небольшим результатом один раз на запрос вместо одного раза на каждую джобу.

EvaluateAtom позволяет динамически менять те части запроса, где обычно ожидалась бы только константа.

Единственный аргумент у обоих функций — само выражение для вычисление и подстановки.

Ограничения:

* выражение не должно приводить к запуску MapReduce операций;
* данный функционал полностью заблокирован в YQL over KiKiMR.

**Примеры:**
```sql
$now = DateTime::TimestampFromMicroSeconds(YQL::Now());
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

## Создание литералов простых типов на основе строкового литерала {#creation-of-the-literals-of-simple-types-based-on-string-literal}
<a name="data-type-literals"></a>

В отличии от `CAST("myString" AS MyType)`:

* Проверка на приводимость литерала к требуемому типу происходит на этапе валидации
* Результат не является optional

Для типов данных Date, Datetime, Timestamp и Interval поддерживаются литералы только в формате, соответствующем [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). У Interval есть следующие отличия от стандарта:

* поддерживается отрицательный знак для сдвигов в прошлое;
* микросекунды могут быть записаны как дробная часть секунд;
* единицы измерения больше суток не доступны;
* не поддерживаются варианты с началом/концом интервала, а также повторами.

**Примеры:**
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
  String("foo"),
  Utf8("привет"),
  Yson("<a=1>[3;%false]"),
  Json(@@{"a":1,"b":null}@@),
  Date("2017-11-27"),
  Datetime("2017-11-27T13:24:00Z"),
  Timestamp("2017-11-27T13:24:00.123456Z"),
  Interval("P1DT2H3M4.567890S");
```

## Доступ к метаданным текущей операции {#access-to-the-metadata-of-the-current-operation}

При запуске YQL операций через консоль управления или API предоставляют доступ к следующей информации:

* **CurrentOperationId** — приватный идентификатор операции;
* **CurrentOperationSharedId** — публичный идентификатор операции;
* **CurrentAuthenticatedUser** — логин текущего пользователя.

Аргументов нет.

При отсутствии данной информации, например при запуске в embedded режиме, возвращают строку.

**Примеры:**
```sql
SELECT
    CurrentOperationId(),
    CurrentOperationSharedId(),
    CurrentAuthenticatedUser();
```

## ToBytes и FromBytes {#tobytes-frombytes}

Конвертация чисел в строку со своим бинарным представлением в little endian и обратно.

**Примеры:**
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

1. Строка: `String` или `Utf8`.
2. Индекс: `Uint32`.

**Примеры:**
```sql
SELECT
    ByteAt("foo", 0) -- 102
    ByteAt("foo", 1) -- 111
    ByteAt("foo", 9) -- NULL
```

## TestBit, ClearBit, SetBit и FlipBit {#testbit-clearbit-setbit-flipbit}

Проверить, сбросить, установить или инвертировать бит в беззнаковом числе по указанному порядковому номеру бита.

Аргументы:

1. Беззнаковое число, над которым выполнять требуемую операцию. TestBit также реализован и для строк.
2. Номер бита.

TestBit возвращает `true/false`. Остальные функции возвращают копию своего первого аргумента с проведенным соответствующим преобразованием.

**Примеры:**
```sql
SELECT
    TestBit(1u, 0), -- true
    SetBit(8u, 0); -- 9
```

## Abs {#abs}

Абсолютное значение числа.

**Примеры:**
```sql
SELECT Abs(-123); -- 123
```

## Just {#just}

Изменить тип данных значения на optional от текущего типа данных (то есть `T` превращается в `T?`).

Обратная операция — [Unwrap](#unwrap).

**Примеры:**
```sql
SELECT
  Just("my_string"); --  String?
```

## Unwrap {#unwrap}

Преобразование значения optional типа данных в соответствующий не-optional тип с ошибкой времени выполнений, если в данных оказался NULL. Таким образом, `T?` превращается в `T`.

Аргументы:

1. Значение для преобразования;
2. Опциональная строка с комментарием для текста ошибки.

Обратная операция — [Just](#just).

**Примеры:**
```sql
$value = Just("value");

SELECT Unwrap($value, "Unexpected NULL for $value");
```

## Nothing {#nothing}

Создать пустое значение указанного optional типа.

[Подробнее о ParseType и других функциях для работы с типами данных](types.md).

**Примеры:**
```sql
SELECT
  Nothing(ParseType("String?")); -- пустое значение (NULL) с типом String?
```

## YQL:: {#yql}

На самом деле встроенных функций намного больше, но они предназначены прежде всего для внутреннего использования или для некоторых особых случаев. В SQL-подобном синтаксисе зарезервированы ключевые слова только для указанных в этой таблице встроенных функций.

Полный список встроенных функций находится в [документации к s-expressions](../s_expressions/functions.md), альтернативному внутреннему синтаксису YQL.  Любую из не упомянутых выше встроенных функций можно вызвать, добавив к ее имени префикс `YQL::` .

**Примеры:**
```sql
SELECT
  YQL::Concat("a", "b"); -- в реальности так писать не рекомендуется,
                         -- так как это аналог SELECT "a" || "b";
```
