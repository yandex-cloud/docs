---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Агрегатные функции

## COUNT {#count}

Подсчет количества строк в таблице (если в качестве аргумента указана `*` или константа) или непустых значений в столбце таблицы (если в качестве аргумента указано имя столбца).

Как и другие агрегатные функции, может использоваться в сочетании с [GROUP BY](../syntax/group_by.md) для получения статистики по частям таблицы, соответствующим значениям в столбцах, по которым идет группировка. А модификатор [DISTINCT](../syntax/group_by.md#distinct) позволяет посчитать число уникальных значений.

**Примеры**

```sql
SELECT COUNT(*) FROM my_table;
```

```sql
SELECT key, COUNT(value) FROM my_table GROUP BY key;
```

```sql
SELECT COUNT(DISTINCT value) FROM my_table;
```

## MIN и MAX {#min-max}

Минимальное или максимальное значение.

В качестве аргумента допустимо произвольное вычислимое выражение с числовым результатом.

**Примеры**

```sql
SELECT MIN(value), MAX(value) FROM my_table;
```

## SUM {#sum}

Сумма чисел.

В качестве аргумента допустимо произвольное вычислимое выражение с числовым результатом.

Целые числа автоматически расширяются до 64 бит, чтобы уменьшить риск переполнения.

```sql
SELECT SUM(value) FROM my_table;
```

## AVG {#avg}

Арифметическое среднее.

В качестве аргумента допустимо произвольное вычислимое выражение с числовым результатом.

Целочисленные значения и интервалы времени автоматически приводятся к Double.

**Примеры**

```sql
SELECT AVG(value) FROM my_table;
```

## COUNT_IF {#count-if}

Количество строк, для которых указанное в качестве аргумента выражение истинно (результат вычисления выражения — true).

Значение `NULL` приравнивается к `false` (в случае, если тип аргумента `Bool?`).

Функция *не* выполняет неявного приведения типов к булевым для строк и чисел.

**Примеры**

```sql
SELECT
  COUNT_IF(value % 2 == 1) AS odd_count
```

{% note info %}

Если нужно посчитать число уникальных значений на строках, где выполняется условие, то в отличие от остальных агрегатных функций модификатор [DISTINCT](../syntax/group_by.md#distinct) тут не поможет, так как в аргументах нет никаких значений. Для получения данного результата, стоит воспользоваться в подзапросе встроенной функцией [IF](../builtins/basic.md#if) с двумя аргументами (чтобы в else получился `NULL`), а снаружи сделать [COUNT(DISTINCT ...)](#count) по её результату.

{% endnote %}

## SUM_IF и AVG_IF {#sum-if}

Сумма или арифметическое среднее, но только для строк, удовлетворяющих условию, переданному вторым аргументом.

Таким образом, `SUM_IF(value, condition)` является чуть более короткой записью для `SUM(IF(condition, value))`, аналогично для `AVG`. Расширение типа данных аргумента работает так же аналогично одноименным функциям без суффикса.

При использовании [фабрики агрегационной функции](basic.md#aggregationfactory) в качестве первого аргумента [AGGREGATE_BY](#aggregateby) передается `Tuple` из значения и предиката.

**Примеры**

```sql
SELECT
    SUM_IF(value, value % 2 == 1) AS odd_sum,
    AVG_IF(value, value % 2 == 1) AS odd_avg,
FROM my_table;
```

```sql
$sum_if_factory = AGGREGATION_FACTORY("SUM_IF");
$avg_if_factory = AGGREGATION_FACTORY("AVG_IF");

SELECT
    AGGREGATE_BY(AsTuple(value, value % 2 == 1), $sum_if_factory) AS odd_sum,
    AGGREGATE_BY(AsTuple(value, value % 2 == 1), $avg_if_factory) AS odd_avg
FROM my_table;
```

## CountDistinctEstimate, HyperLogLog и HLL {#countdistinctestimate}

Примерная оценка числа уникальных значений по алгоритму [HyperLogLog](https://en.wikipedia.org/wiki/HyperLogLog). Логически делает то же самое, что и [COUNT(DISTINCT ...)](#count), но работает значительно быстрее ценой некоторой погрешности.

Аргументы:

1. Значение для оценки;
2. Точность (от 4 до 18 включительно, по умолчанию 14).

Выбор точности позволяет разменивать дополнительное потребление вычислительных ресурсов и оперативной памяти на уменьшение погрешности.

На данный момент все три функции являются алиасами, но в будущем `CountDistinctEstimate` может начать использовать другой алгоритм.

**Примеры**

```sql
SELECT
  CountDistinctEstimate(my_column)
FROM my_table;
```

```sql
SELECT
  HyperLogLog(my_column, 4)
FROM my_table;
```

## SOME {#some}

Получить значение указанного в качестве аргумента выражения для одной из строк таблицы. Не дает никаких гарантий о том, какая именно строка будет использована. Аналог функции [any()](https://clickhouse.tech/docs/ru/sql-reference/aggregate-functions/reference/any/) в ClickHouse.

Из-за отсутствия гарантий `SOME` вычислительно дешевле, чем часто использующиеся в подобных ситуациях [MIN](#min)/[MAX](#max).

**Примеры**

```sql
SELECT
  SOME(value)
FROM my_table;
```

{% note alert %}

При вызове агрегатной функции `SOME` несколько раз **не** гарантируется, что все значения результатов будут взяты с одной строки исходной таблицы. Для получения данной гарантии, нужно запаковать значения в какой-либо из контейнеров и передавать в `SOME` уже его. Например, для структуры это можно сделать с помощью [AsStruct](../builtins/basic.md#asstruct)

{% endnote %}

## LIST {#list}

Получить все значения столбца в виде списка. В сочетании с `DISTINCT` возвращает только уникальные значения. Порядок элементов в результирующем списке зависит от реализации и снаружи не задается, чтобы получить упорядочный список необходимо отсортировать результат, например с помощью [ListSort](list.md#listsort).

Например, можно использовать в сочетании с `DISTINCT` и функцией [String::JoinFromList](../udf/list/string.md) (аналог `','.join(list)` из Python) для распечатки в строку всех значений, которые встретились в столбце после применения `GROUP BY`.

{% note alert %}

Выполняется **не** ленивым образом, поэтому при использовании нужно быть уверенным, что список получится разумных размеров, примерно в пределах тысячи элементов. Чтобы подстраховаться, можно воспользоваться вторым опциональным числовым аргументом, который включает ограничение на число элементов в списке.

{% endnote %}

Стоит учитывать, что результатом выполнения функции может быть `List` или `List?` ([опциональный](../types/optional)), в зависимости от контекста.

**Примеры**

```sql
-- В контексте GROUP BY — тип List
SELECT LIST(ip, 1)
FROM [//home/yql/tutorial/users]
GROUP BY age
```

```sql
-- В контексте без GROUP BY — опциональный тип List?
SELECT LIST(ip, 1)
FROM [//home/yql/tutorial/users]
```

## MAX_BY и MIN_BY {#max-min-by}

Вернуть значение первого аргумента для строки таблицы, в которой второй аргумент оказался минимальным/максимальным.

Опционально можно указать третий аргумент N, который влияет на поведение в случае, если в таблице есть несколько строк с одинаковым минимальным или максимальным значением:

* Если N не указано — будет возвращено значение одной из строк, а остальные отбрасываются.
* Если N указано — будет возвращен список со всеми значениями, но не более N, все значения после достижения указанного числа отбрасываются.

При выборе значения N рекомендуется не превышать порядка сотен или тысяч, чтобы не возникало проблем с ограниченной доступной памятью на кластерах.

Если для задачи обязательно нужны все значения, и их количество может измеряться десятками тысяч и больше, то вместо данных агрегационных функций следует использовать `JOIN` исходной таблицы с подзапросом, где по ней же сделан `GROUP BY + MIN/MAX` на интересующих вас колонках.

{% note alert %}

Если второй аргумент всегда NULL, то результатом агрегации будет NULL.

{% endnote %}

При использовании [фабрики агрегационной функции](basic.md#aggregationfactory) в качестве первого аргумента [AGGREGATE_BY](#aggregateby) передается `Tuple` из значения и ключа.

**Примеры**

```sql
SELECT
  MIN_BY(value, LENGTH(value)),
  MAX_BY(value, key, 100)
FROM my_table;
```

```sql
$min_by_factory = AGGREGATION_FACTORY("MIN_BY");
$max_by_factory = AGGREGATION_FACTORY("MAX_BY", 100);

SELECT
    AGGREGATE_BY(AsTuple(value, LENGTH(value)), $min_by_factory),
    AGGREGATE_BY(AsTuple(value, key), $max_by_factory)
FROM my_table;
```

## TOP и BOTTOM {#top-button}

Вернуть список максимальных/минимальных значений выражения. Первый аргумент — выражение, второй — ограничение на количество элементов.

**Примеры**

```sql
SELECT
  TOP(key, 3),
  BOTTOM(value, 3)
FROM my_table;
```

```sql
$top_factory = AGGREGATION_FACTORY("TOP", 3);
$bottom_factory = AGGREGATION_FACTORY("BOTTOM", 3);

SELECT
    AGGREGATE_BY(key, $top_factory),
    AGGREGATE_BY(value, $bottom_factory)
FROM my_table;
```

## TOP_BY и BOTTOM_BY {#top-bottom-by}

Вернуть список значений первого аргумента для строк с максимальными/минимальными значениями второго аргумента. Третий аргумент - ограничение на количество элементов в списке.

При использовании [фабрики агрегационной функции](basic.md#aggregationfactory) в качестве первого аргумента [AGGREGATE_BY](#aggregateby) передается `Tuple` из значения и ключа. Ограничение на количество элементов в этом случае передаётся вторым аргументом при создании фабрики.

**Примеры**

```sql
SELECT
  TOP_BY(value, LENGTH(value), 3),
  BOTTOM_BY(value, key, 3)
FROM my_table;
```

```sql
$top_by_factory = AGGREGATION_FACTORY("TOP_BY", 3);
$bottom_by_factory = AGGREGATION_FACTORY("BOTTOM_BY", 3);

SELECT
    AGGREGATE_BY(AsTuple(value, LENGTH(value)), $top_by_factory),
    AGGREGATE_BY(AsTuple(value, key), $bottom_by_factory)
FROM my_table;
```

## TOPFREQ и MODE {#topfreq}

Получение приближенного списка самых часто встречающихся значений колонки с оценкой их числа. Возвращают список структур с двумя полями:

* `Value`— найденное часто встречающееся значение;
* `Frequency` — оценка числа упоминаний в таблице.

Обязательный аргумент: само значение.

Опциональные аргументы:

1. Для `TOPFREQ` — желаемое число элементов в результате. `MODE` является алиасом к `TOPFREQ` с 1 в этом аргументе. У `TOPFREQ` по умолчанию тоже 1.
2. Число элементов в используемом буфере, что позволяет разменивать потребление памяти на точность. По умолчанию 100.

**Примеры**

```sql
SELECT
    MODE(my_column),
    TOPFREQ(my_column, 5, 1000)
FROM my_table;
```

## STDDEV и VARIANCE {#stddev-variance}

Стандартное отклонение и дисперсия по колонке. Используется [однопроходной параллельный алгоритм](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Parallel_algorithm), результат которого может отличаться от полученного более распространенными методами, требующими двух проходов по даным.

По умолчанию вычисляются выборочная дисперсия и стандартное отклонение. Доступны несколько способов записи:

* с суффиксом/префиксом `POPULATION`, на**Примеры** `VARIANCE_POPULATION`, `POPULATION_VARIANCE` — вычисляет дисперсию/стандартное отклонение для генеральной совокупности;
* с суффиксом/префиксом `SAMPLE` или без суффикса, например `VARIANCE_SAMPLE`, `SAMPLE_VARIANCE`, `SAMPLE` — вычисляет выборочную дисперсию и стандартное отклонение.

Также определено несколько сокращенных алиасов, например `VARPOP` или `STDDEVSAMP`.

Если все переданные значения — `NULL`, возвращает `NULL`.

**Примеры**

```sql
SELECT
  STDDEV(numeric_column),
  VARIANCE(numeric_column)
FROM my_table;
```

## CORRELATION и COVARIANCE {#correlation-covariance}

Корреляция и ковариация двух колонок.

Также доступны сокращенные версии `CORR` или `COVAR`, а для ковариации - версии c суффиксом `SAMPLE` / `POPULATION` по аналогии с описанной выше [VARIANCE](#variance).

В отличие от большинства других агрегатных функций не пропускают `NULL`, а считают его за 0.

При использовании [фабрики агрегационной функции](basic.md#aggregationfactory) в качестве первого аргумента [AGGREGATE_BY](#aggregateby) передается `Tuple` из двух значений.

**Примеры**

```sql
SELECT
  CORRELATION(numeric_column, another_numeric_column),
  COVARIANCE(numeric_column, another_numeric_column)
FROM my_table;
```

```sql
$corr_factory = AGGREGATION_FACTORY("CORRELATION");

SELECT
    AGGREGATE_BY(AsTuple(numeric_column, another_numeric_column), $corr_factory)
FROM my_table;
```

## PERCENTILE и MEDIAN {#percentile-median}

{% note alert %}

Первый аргумент (N) должен быть именем колонки таблицы. Если это ограничение необходимо обойти, можно использовать подзапрос. Ограничение введено для упрощения вычислений, поскольку в реализации несколько вызовов с одинаковым первым аргументом (N) склеиваются в один проход.

{% endnote %}

```sql
SELECT
    MEDIAN(numeric_column),
    PERCENTILE(numeric_column, 0.99)
FROM my_table;
```

## HISTOGRAM {#histogram}

Построение примерной гистограммы по числовому выражению с автоматическим выбором корзин.

Вспомогательные функции перечислены в разделе [Histogram UDF](../udf/list/histogram.md).

### Базовые настройки {#basic-settings}

Ограничение на число корзин можно задать с помощью опционального аргумента, значение по умолчанию — 100. Следует иметь в виду, что дополнительная точность стоит дополнительных вычислительных ресурсов и может негативно сказываться на времени выполнения запроса, а в экстремальных случаях — и на его успешности.

### Поддержка весов {#weight-support}

Имеется возможность указать «вес» для каждого значения, участвующего в построении гистограммы. Для этого вторым аргументом в агрегатную функцию нужно передать выражение для вычисления веса. По умолчанию всегда используется вес `1.0`. Если используются нестандартные веса, ограничение на число корзин можно задать третьим аргументом.

В случае, если передано два аргумента, смысл второго аргумента определяется по его типу (целочисленный литерал — ограничение на число корзин, в противном случае — вес).


### Если нужна точная гистограмма {#if-you-need-an-accurate-histogram}

1. Можно воспользоваться описанными ниже агрегатными функциями с фиксированными сетками корзин: [LinearHistogram](#linearhistogram) или [LogarithmicHistogram](#logarithmichistogram).
2. Можно самостоятельно вычислить номер корзины для каждой строки и сделать по нему [GROUP BY](../syntax/group_by.md).

При использовании [фабрики агрегационной функции](basic.md#aggregationfactory) в качестве первого аргумента [AGGREGATE_BY](#aggregateby) передается `Tuple` из значения и веса.

**Примеры**

```sql
SELECT
        HISTOGRAM(numeric_column)
FROM my_table;
```

```sql
SELECT
    Histogram::Print(
        HISTOGRAM(numeric_column, 10),
        50
    )
FROM my_table;
```

```sql
$hist_factory = AGGREGATION_FACTORY("HISTOGRAM");

SELECT
    AGGREGATE_BY(AsTuple(numeric_column, 1.0), $hist_factory)
FROM my_table;
```

## LinearHistogram, LogarithmicHistogram и LogHistogram {%linearhistogram} {#linearhistogram-logarithmichistogram-and-loghistogram-linearhistogram}

Построение гистограммы по явно указанной фиксированной шкале корзин.

Аргументы:

1. Выражение, по значению которого строится гистограмма. Все последующие — опциональны.
2. Расстояние между корзинами для `LinearHistogram` или основание логарифма для `LogarithmicHistogram` / `LogHistogram` (это алиасы). В обоих случаях значение по умолчанию  — 10.
3. Минимальное значение. По умолчанию минус бесконечность.
4. Максимальное значение. По умолчанию плюс бесконечность.

Формат результата полностью аналогичен [адаптивным гистограммам](#histogram), что позволяет использовать тот же [набор вспомогательных функций](../udf/list/histogram.md).

Если разброс входных значений неконтролируемо велик, рекомендуется указывать минимальное и максимальное значение для предотвращения потенциальных падений из-за высокого потребления памяти.

**Примеры**

```sql
SELECT
    LogarithmicHistogram(numeric_column, 2)
FROM my_table;
```

## BOOL_AND и BOOL_OR {#bool-and-or}

Применение соответствующей логической операции (`AND / OR`) ко всем значениям булевой колонки или выражения.

Логика работы эквивалентна Python функциям `all()` и `any()` соответственно.

**Примеры**

```sql
SELECT
  BOOL_AND(bool_column),
  BOOL_OR(bool_column)
FROM my_table;
```

## BIT_AND, BIT_OR и BIT_XOR {#bit-and-or-xor}

Применение соответствующей битовой операции ко всем значениям числовой колонки или выражения.

**Примеры**

```sql
SELECT
  BIT_XOR(unsigned_numeric_value)
FROM my_table;
```
## AGGREGATE_BY и MULTI_AGGREGATE_BY {#aggregateby}

Применение [фабрики агрегационной функции](basic.md#aggregationfactory) ко всем значениям колонки или выражения. Функция `MULTI_AGGREGATE_BY` требует, чтобы в значении колонки или выражения была структура, и применяет фабрику поэлементно, размещая результат в структуре с теми же полями.

1. Колонка, `DISTINCT` колонка или выражение;
2. Фабрика.

**Примеры**

```sql
$count_factory = AGGREGATION_FACTORY("COUNT");

SELECT
    AGGREGATE_BY(DISTINCT column, $count_factory) as uniq_count
FROM my_table;

SELECT
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("count")) as count,
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("min")) as min,
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("max")) as max,
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("avg")) as avg,
    MULTI_AGGREGATE_BY(nums, AGGREGATION_FACTORY("percentile", 0.9)) as p90
FROM my_table;
```
