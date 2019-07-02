# Практическое применение метапрограммирования на YQL

## Введение
Из-за отсутствия в YT нативной поддержки партиционированных таблиц, типовой ситуацией является хранение логически единой таблицы в виде множества физических таблиц, разбитых по датам, часам или остатку от деления хеша какого-либо из полей. Таким образом, в YQL over YT запросы часто работают с огромным количеством таблиц (десятки, сотни и тысячи). По меркам стандарта SQL это исключительная ситуация и общепринятых механизмов для описания таких запросов им не предоставляется. YQL обладает многими расширениями стандарта, спроектированных специально для подобных специфичных задач. Также для регулярно или многократно запускаемых запросов в большинстве случаев они позволяют обойтись совсем без генерации текстов запросов на клиенте. Каждый механизм в отдельности [подробно описан в основном руководстве по синтаксису YQL](../syntax/extensions.md), а цель данной статьи состоит в том, чтобы продемонстрировать как их можно комбинировать для достижения практически полезных результатов на приближенных к реальности примерах. В [основной Tutorial](https://yql.yandex-team.ru/Tutorial/01_Select_all_columns) эти примеры по ряду причин пока не включены, но в будущем вероятно будут.

## Сценарии

### Выбор таблиц по датам
Архив подавляющего большинства логов хранится на YT в плоской директории, где каждой дате соответствует отдельная таблица. Чтобы выполнить расчет по интересующим датам и при этом не подставлять их в текст запроса вручную можно воспользоваться табличной функцией FILTER в сочетании с выбирающей нужные даты lambda функцией.

``` yql
USE hahn;

$log_type = "visit-log";
$base_folder = "logs/" || $log_type || "/1d";
$today = CAST(DateTime::TimestampFromMicroSeconds(YQL::Now()) AS Date);
$yesterday = $today - Interval("P1DT");
$a_week_ago = $today - Interval("P7DT");

$is_during_last_week = ($table_name) -> {
    $date = CAST($table_name AS Date);
    RETURN ($date BETWEEN $a_week_ago AND $yesterday) ?? false;
};

SELECT COUNT(*)
FROM FILTER($base_folder, $is_during_last_week);
```

<details markdown="1">
<summary>Ссылки на документацию</summary>

* [DateTime UDF](../udf/list/datetime.md)
* [Lambda функции](../syntax/extensions.md#lambda)
* [FILTER](../syntax/extensions.md#filter)
</details>

### Обработка таблиц скользящим окном с кешированием
Допустим, вам нужно ежедневно считать какой-то агрегат по данным за последнюю неделю примерно как в предыдущем примере. Так как по своей природе большинство таблиц с логами перестают меняться уже начиная с ночи следующего дня, то условно 6/7-х вычислительных ресурсов каждый день тратилось на повторное вычисление того, что уже считалось в предыдущий раз. В YQL есть механизм [автоматического кеширования промежуточных результатов вычислений](../pragmas.md#querycachemode), но так как он оперирует на уровне MapReduce операций целиком, то в предыдущем запросе cache hit был бы нулевой: каждый день получался бы свой набор входных таблиц в первую Map операцию, а он участвует в вычислении ключа в кеше.

Чтобы дать механизму автоматического кеширования шанс на успех <span style="color:gray;">(или даже гарантировать его, если переопределить [PRAGMA yt.TmpFolder](../pragmas.md#tmpfolder) в свою директорию/квоту вместо `//tmp`)</span>, нужно считать агрегат по каждому дню по отдельности, а затем объединять их в одно значения для получения требуемого результата, благо для большинства агрегатных функций это возможно.

``` yql
USE hahn;

$log_type = "visit-log";
$base_folder = "logs/" || $log_type || "/1d/";
$today = CAST(DateTime::TimestampFromMicroSeconds(YQL::Now()) AS Date);
$range = ListFromRange(1, 9);

$shift_back_by_days = ($days_count) -> {
    RETURN Unwrap(
        $today - $days_count * Interval("P1DT"),
        "Failed to shift today back by " || CAST($days_count AS String) || " days"
    );
};
$dates = ListMap($range, $shift_back_by_days);

DEFINE ACTION $max_income($date) AS
    $table_path = $base_folder || CAST($date AS String);
    INSERT INTO @daily_results
    SELECT MAX(CAST(Income AS Double)) AS MaxIncome
    FROM $table_path;
END DEFINE;

EVALUATE FOR $date IN $dates DO $max_income($date);

COMMIT;

SELECT MAX(MaxIncome) AS MaxIncome
FROM @daily_results;

DISCARD SELECT
    Ensure(
        NULL,
        COUNT(*) == 7,
        "Unexpected number of aggregates to be merged: " || CAST(COUNT(*) AS String) || " instead of 7"
    )
FROM @daily_results;
```

В данном примере в отличии от предыдущего пути к таблицам не выбираются из содержимого директории, а генерируются «из воздуха», основываясь на принятой для данного лога схеме именования таблиц. Объявляется «действие» для обработки каждой таблицы в отдельности (DEFINE ACTION), которое затем в цикле применяется к каждой дате, которая должна попасть в расчет (EVALUATE FOR).

Также в данном запросе демонстрируется несколько способов «уронить» запрос с содержательной ошибкой вместо выдачи некорректного результата, если вдруг начало получаться что-то странное:

* Арифметика над датами может вернуть NULL в практически не возможных для данного сценария ситуациях выхода за диапазон поддерживаемых значений, что делает достаточно безопасным использование Unwrap — превращения Optional значения в не-Optional <span style="color:gray;">(точно не NULL), с ошибкой времени выполнения если в Optional таки лежал NULL.
* Ensure позволяет проверить выполнение произвольных условий во время выполнения запроса и вернуть ошибку, если условие не выполнено. Его можно вставлять и прямо по ходу вычисления, но в сочетании с DISCARD <span style="color:gray;">(посчитать что-то и выкинуть результат)</span> можно и сделать отдельную проверку сбоку, например по агрегату от временной или итоговой таблицы как здесь. В варианте с DISCARD первый аргумент Ensure, который обычно становится результатом его вызова, особого смысла не имеет и туда можно писать любую константу, например NULL.

Ссылки на документацию:

* [Lambda функции](../syntax/extensions.md#lambda)
* [ListFromRange](../builtins/list.md#listfromrange) / [ListMap](../builtins/list.md#listmap) / [ListLength](../builtins/list.md#listlength)
* [Unwrap](../builtins/basic.md#unwrap)
* [DEFINE ACTION](../syntax/extensions.md#define-action)
* [EVALUATE FOR](../syntax/extensions.md#evaluate-for)
* [@foo](../syntax/extensions.md#temporary-tables)
* [COMMIT](../syntax/basic.md#commit)
* [DISCARD](../syntax/extensions.md#discard)
* [Ensure](../builtins/basic.md#ensure)


### Сценарий с обработкой заданий
Допустим у вас есть некий внешний процесс, записывающий в определённую директорию таблицы, которые по сути являются заданиями для обработки: нужно запускать на основе содержимого какой такой таблицы вычисление, записывать результат в другую директорию, а обработанные таблицы удалять — и всё это транзакционно.

<details markdown="1">
<summary>Как можно сэмулировать такой внешний процесс на YQL для теста.</summary>
``` yql
USE hahn;

$root_folder = "//tmp/tasks/";
$values = ListFromRange(1, 10);

DEFINE ACTION $create_task($i) AS
    $path = $root_folder || CAST($i AS String);
    INSERT INTO $path SELECT $i AS Task;
END DEFINE;

EVALUATE FOR $value IN $values DO $create_task($value);
```
</details>

Собственно запуск обработки:
``` yql
USE hahn;

$tasks_folder = "tmp/tasks";
$results_folder = "tmp/results";

DEFINE ACTION $process_task($input_path) AS
    $output_path = String::ReplaceAll($input_path, $tasks_folder, $results_folder);

    INSERT INTO $output_path WITH TRUNCATE
    SELECT Task * Task AS Result
    FROM $input_path;
    COMMIT;
    DROP TABLE $input_path;
END DEFINE;

$tasks = (
    SELECT LIST(Path)
    FROM FOLDER($tasks_folder, "row_count")
    WHERE Type == "table" AND
        Yson::LookupInt64(Attributes, "row_count") == 1
);

EVALUATE FOR $task IN $tasks ?? ListCreate(TypeOf($tasks)) DO $process_task($task);
```
Здесь так же используется механизм «действий» с циклом по списку, но при этом список входных таблиц берётся не «из воздуха», а из табличной функции FOLDER, которая предоставляет доступ к содержимому произвольной директории в YT. Так как FOLDER выдает не только таблицы, но и другие виды узлов, то если нет уверенности, что в директории лежат только таблицы, то лучше добавлять фильтр по Type, также возможен фильтр по произвольным мета атрибутам таблицы <span style="color:gray;">(здесь row_count для примера)<span style="color:red;">, для этого надо заказать их во втором аргументе FOLDER <span style="color:gray;">(если несколько, то через точку с запятой)</span> и затем обратиться к колонке Attributes типа Yson.

ListExtract делает из списка структур с одним элементом список сразу строк с путями, а можно было бы доставать Path и уже внутри действия.

Ссылки на документацию:

* [String UDF](../udf/list/string.md) / [Yson UDF](../udf/list/yson.md)
* [ListFromRange](../builtins/list.md#listfromrange) / [ListExtract](../builtins/list.md#listextract)
* [FOLDER](../syntax/extensions.md#folder)
* [DROP TABLE](../syntax/basic.md#drop-table)


### Доступ к мета атрибутам
Некоторые проекты настолько сильно завязываются на мета атрибуты в YT, что не заглядывая в них даже не понять к каким таблицам вообще правильно обращаться. Например, у Jupiter всегда есть в наличии несколько срезов данных, по которым строится Поисковая база, но какой из них чему соответствует (скажем, сейчас находится в production) можно узнать только по [атрибутам директории //home/jupiter](https://yt.yandex-team.ru/banach/#page=navigation&path=//home/jupiter&mode=attributes). В таких ситуациях можно использовать табличную функцию FOLDER чисто чтобы взять нужное значение из атрибутов, а затем работать уже с ним. Запрос-пример считает количество URL, которые показывались на Поиске среди тех, которые участвуют в текущем production срезе данных:
``` yql
USE banach;
PRAGMA SimpleColumns;

$home_path = "home/jupiter";
$meta = (
    SELECT
        Yson::ConvertToString(Attributes.jupiter_meta.production_current_state) AS State
    FROM FOLDER([home], "jupiter_meta")
    WHERE Path == $home_path
);
$shards_count = 18;
$shards = ListFromRange(0, $shards_count);
$generate_urldat_path = ($shard, $state) -> {
    $shard = CAST($shard AS String);
    $parts = AsList($home_path, "urldat", $state, $shard, "data");
    RETURN String::JoinFromList($parts, "/");
};
$urldat_paths = ListMap($shards, $generate_urldat_path, $meta);
$url_count = (
    SELECT COUNT_IF(UrlWasOnSearch) AS Count
    FROM EACH($urldat_paths)
);

-- INSERT INTO [some/path/to/append]
SELECT
    State,
    Count
FROM $meta AS m
CROSS JOIN $url_count AS uc;
```

В самом финальном запросе используется CROSS JOIN из двух таблиц с одной строкой, чтобы получить одну строку с идентификатором среза данных и полученной статистикой, которые можно было бы например регулярным запуском дописывать в конец таблицы с динамикой изменений. Также полезным сценарием может быть join строк таблиц со своими атрибутами через INNER JOIN по колонке Path из FOLDER и результату функции [TablePath()](../builtins/basic.md#tablepath).

Табличная функция EACH позволяет обратиться к конкатенации однотипных таблиц, пути к которым находятся в списке строк.

<details markdown="1">
<summary>Ссылки на документацию</summary>

* [String UDF](../udf/list/string.md) / [Yson UDF](../udf/list/yson.md)
* [PRAGMA SimpleColumns](../pragmas.md#simplecolumns)
* [Lambda функции](../syntax/extensions.md#lambda)
* [FOLDER](../syntax/extensions.md#folder)
* [EACH](../syntax/extensions.md#each)
* [CROSS JOIN](../syntax/basic.md#cross-join)
</details>
