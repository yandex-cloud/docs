---
title: Типы данных {{ datalens-full-name }}
description: "{{ datalens-name }} работает с различными источниками данных, в которых типы данных полей могут отличаться. Для более эффективной работы с данными {{ datalens-name }} конвертирует типы данных полей источника в собственные типы. Это оптимизирует работу с данными. Вы можете изменять тип данных у полей в интерфейсе датасета и в визарде."
---

# Типы данных Yandex DataLens

{{ datalens-short-name }} работает с различными источниками данных, в которых типы данных полей могут отличаться.

Для более эффективной работы с данными, {{ datalens-short-name }} конвертирует типы данных полей источника в собственные типы.
Это оптимизирует работу с данными. Подробнее в разделе [{#T}](#types-lookup-table).

Вы можете изменять тип данных у полей в интерфейсе датасета и в визарде.

{% note warning %}

При загрузке CSV-файла в качестве [источника данных](../operations/connection/create-file.md), {{ datalens-short-name }} пытается автоматически определить тип данных полей.  
Если определить тип данных не удалось, DataLens задает полю тип `Строка`.

Вы можете самостоятельно изменить тип данных в интерфейсе датасета или в визарде.

{% endnote %}

## Геоточка {#geopoint}

Точка координат, которая состоит из значений широты и долготы. В {{ datalens-short-name }} задается с помощью функции [GEOPOINT](../function-ref/GEOPOINT.md).

Функция принимает на вход типы данных `Строка`, `Геоточка`, или два значения с типом `Дробное число` или `Строка`.
Если на вход подается одна строка, в ней должен содержаться список из двух чисел в JSON-синтаксисе.

Если в источнике данные записаны в формате следующей строки `"[55.75222,37.61556]"`, вы можете изменить тип данных поля в интерфейсе датасета и в визарде без использования формулы.

#### Пример записи {#geopoint-example}

```sql
GEOPOINT("[55.7912,37.6872]")
GEOPOINT("[55.8538,37.6312]")
```

## Геополигон {#geopolygon}

Несколько точек координат, которые описывают полигон на карте. В {{ datalens-short-name }} задается с помощью функции [GEOPOLYGON](../function-ref/GEOPOLYGON.md).
Для заливки полигона используется алгоритм [Even-Odd](https://en.wikipedia.org/wiki/Even–odd_rule). Это позволяет создавать полигоны с вырезами.

Функция принимает на вход строку вида `"[[[v1,v1], [v2,v2]], ..., [[vN-1,vN-1], [vN,vN]]]"`. Если в источнике данные записаны в таком формате, вы можете изменить тип данных поля в интерфейсе датасета и в визарде без использования формулы.

#### Пример записи {#geopolygon-example}

```sql
/* Полигон без выреза */
GEOPOLYGON("[[[55.79421,37.65046],[55.79594,37.6513],[55.79642,37.65133],[55.7969, 37.65114],[55.79783, 37.65098],[55.78871,37.75101]]]")

/* Полигоны с вырезом */
GEOPOLYGON("[[[55.75,37.52],[55.75,37.68],[55.65,37.60]],[[55.79,37.60],[55.76,37.57],[55.76,37.63]]]")
GEOPOLYGON("[[[55.75,37.50],[55.80,37.60],[55.75,37.70],[55.70,37.70],[55.70,37.50]],[[55.75,37.52],[55.75,37.68],[55.65,37.60]],[[55.79,37.60],[55.76,37.57],[55.76,37.63]]]")
```

## Дата {#date}

Дата без указанного времени. 

При использовании в формулах необходимо задавать дату с помощью знака решетки `#`. Например `DATETRUNC(#2018-07-12#, "year", 5)`.

Вы можете привести исходный тип данных в тип `Дата` с помощью функций [DATE](../function-ref/DATE.md) и [DATE_PARSE](../function-ref/DATE_PARSE.md).

#### Пример записи {#date-example}

```sql
#2018-01-18#
#2015-01-01#
DATETRUNC(#2018-07-12#, "year", 5)
DATEADD(#2018-01-12#, "day", 6)
```

## Дата и время (устаревший) {#datetime-old}

Дата с указанным временем (с приведением значения к [UTC]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Всемирное_координированное_время){% else %}(https://en.wikipedia.org/wiki/Coordinated_Universal_Time){% endif %}).

При использовании в формулах необходимо задавать дату и время с помощью знака решетки `#`. Например `DATEADD(#2018-01-12 01:02:03#, "second", 6)`.

Вы можете привести исходный тип данных в тип `Дата и время (устаревший)` с помощью функций [DATETIME](../function-ref/DATETIME.md) и [DATETIME_PARSE](../function-ref/DATETIME_PARSE.md).

{% note info %}

При использовании поля с типом `Дата и время (устаревший)` вы увидите предупреждение в правом верхнем углу чарта. Подробнее о том, как перейти к новому типу `Дата и время`, см. раздел [{#T}]{% if audience == "internal" %}(../faq.md#new-datetime){% else %}(../qa/index.md#new-datetime){% endif %}

{% endnote %}

#### Пример записи {#datetime-old-example}

```sql
#2018-01-12 01:08:03#
#2018-05-01T#
DATEADD(#2018-01-12 01:02:03#, "second", 6)
DATETRUNC(#2018-07-12 11:07:13#, "month", 4)
```

#### Закрытие типа Дата и время (устаревший) {#datetime-deprecation}

* С {% if audience == "internal" %}24 августа{% else %}6 сентября{% endif %} 2022 года доступен для использования новый тип [Дата и время](#datetime), без приведения к UTC.

* {% if audience == "internal" %}5{% else %}12{% endif %} октября 2022 года:

  * Во всех датасетах поля с типом `Дата и время (устаревший)` будут заменены на поля с типом `Дата и время`.
  * Использование знака решетки `#` перестанет приводить константы к UTC.
  * Функции [DATETIME](../function-ref/DATETIME.md) и [DATETIME_PARSE](../function-ref/DATETIME_PARSE.md) перестанут приводить выражения к UTC.

## Дата и время {#datetime}

Дата с указанным временем (без приведения значения к [UTC]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Всемирное_координированное_время){% else %}(https://en.wikipedia.org/wiki/Coordinated_Universal_Time){% endif %}).

При использовании в формулах необходимо задавать дату и время с помощью удвоенного знака решетки `##`. Например `DATEADD(##2018-01-12 01:02:03##, "second", 6)`.

Вы можете привести исходный тип данных в тип `Дата и время` с помощью функций [GENERICDATETIME](../function-ref/GENERICDATETIME.md) и [GENERICDATETIME_PARSE](../function-ref/GENERICDATETIME_PARSE.md).

#### Пример записи {#datetime-example-tmp}

```sql
##2018-01-12 01:08:03##
##2018-05-01T##
DATEADD(##2018-01-12 01:02:03##, "second", 6)
DATETRUNC(##2018-07-12 11:07:13##, "month", 4)
```

## Дробное число {#float}

Вещественное число. В качестве разделителя используется символ точки.

Вы можете привести исходный тип данных в тип `Дробное число` с помощью функции [FLOAT](../function-ref/FLOAT.md).

{% note warning %}

При конвертации типа `decimal` в `Дробное число` возможна потеря точности.

{% endnote %}

#### Пример записи {#float-example}

```sql
1.47113
0.62024
FLOAT("34.567")
```

## Логический {#boolean}

Логический тип, который принимает только одно из двух значений — `TRUE` или `FALSE`.

Вы можете привести исходный тип данных в тип `Логический` с помощью функции [BOOL](../function-ref/BOOL.md).

#### Пример записи {#boolean-example}

```sql
FALSE
```

## Строка {#string}

Строка с текстом. Задается с помощью символов одиночных или двойных кавычек.
В случае использования одного вида кавычек, второй вид можно свободно использовать в этой строке без экранирования.
Например, `'Парные кавычки "пример" и одна " кавычка.'`

В строках вы можете использовать следующие символы:
- `\n` - перенос строки (LF);
- `\r` - возврат каретки (CR);
- `\t` - табуляция;
- `\"` - двойная кавычка;
- `\'` - одинарная кавычка;
- `\\` - обратная косая черта.

Вы можете привести исходный тип данных в тип `Строка` с помощью функции [STR](../function-ref/STR.md).

#### Пример записи {#string-example}

```sql
"Строка"
'Строка с "подстрокой"'
```

## Целое число {#integer}

Число, которое не содержит дробной части.

Вы можете привести исходный тип данных в тип `Целое число` с помощью функции [INT](../function-ref/INT.md).

#### Пример записи {#integer-example}

```sql
42
157
```

## Массив {#array}

Структура, которая состоит из последовательности элементов одного типа.

{{ datalens-short-name }} поддерживает работу со столбцами одномерных массивов в БД {{ CH }}{% if audience == "internal" %}, CH over YT, CH over YDB{% endif %} и {{ PG }}. Элементы массива могут быть следующих типов:

* `Целое число`
* `Дробное число`
* `Строка`

{% note warning %}

Определить массив внутри {{ datalens-short-name }} нельзя.

{% endnote %}

#### Пример записи {#array-example}

```sql
[1, 2, 3]
[1.1, 1.2, 1.3]
["Cheese", "Bread"]
```

## Дерево строк {#tree-hierarchy}

В {{ datalens-short-name }} можно создавать древовидные иерархии. Для этого используется тип поля **Дерево строк**. Данные хранятся в формате [массива](#array) с полным путем для каждого узла. Последовательность значений в массиве определяет порядок раскрытия дерева.

{% note info %}

Создание дерева доступно только в типе чарта **Таблица**.

Для хранения деревьев можно использовать источники, которые поддерживают работу с массивами:

{% if audience == "internal" %} * {{ yt-name }} / CH over YT {% endif %}
* {{ CH }}
* {{ PG }}

{% endnote %}

### Создание дерева {#how-to-create-tree}

1. В источнике данных определите массив с полным путем для каждого узла дерева. Например:

   * United States — `["United States"]`
   * West — `["United States", "West"]`
   * Idaho — `["United States", "West", "Idaho"]`

   При наличии столбцов со значениями иерархии такой массив можно создать с помощью функции [ARRAY](../function-ref/ARRAY.md). Например: `ARRAY([Country], [Region], [State])`.

1. На основе массива [создайте вычисляемое поле](../operations/dataset/create-calculated-field.md) через формулу: `TREE([Raw Geo-Tree])`, где `Raw Geo-Tree` — имя поля с типом **Массив строк**, описывающего дерево.

### Использование дерева в чарте {#how-to-use-tree}

1. [Создайте](../visualization-ref/table-chart.md#create-diagram) чарт **Таблица**.
1. Перетащите в секцию **Столбцы** измерение с типом **Дерево строк**. В области визуализации отобразится древовидная иерархия. Используйте значок **+** или **-**, чтобы раскрыть или свернуть дерево.

   {% note info %}

   Не используйте в чарте другие измерения, кроме дерева.

   {% endnote %}

1. Добавьте в секцию **Столбцы** необходимые показатели.

   ![image](../../_assets/datalens/concepts/chart-tree-hierarchy.png)

### Ограничения {#tree-restrictions}

В текущей версии древовидная иерархия имеет следующие ограничения:

* Одно дерево/иерархия на чарт.
* В таблице с деревьями недоступно использование опции **Пагинация** и строки **Итоги**.
* Состояние раскрытия дерева не запоминается.
* В селекторах не поддерживается использование дерева.
* В источнике необходимо хранить промежуточные узлы дерева, даже те, по которым нет данных.

## Таблица соответствий типов данных {#types-lookup-table}

При создании датасета {{ datalens-short-name }} приводит данные из источника в свой тип для оптимизации.
Это позволяет {{ datalens-short-name }} унифицировать работу с данными из разных источников.

Ниже приведена таблица соответствий типов баз данных и внутренних типов {{ datalens-short-name }}.

DataLens |{% if audience != "internal" %} Материализованный<br/>датасет |{% endif %} ClickHouse | PostgreSQL | MySQL | MS SQL |{% if audience == "internal" %} CH over YT | CH over YDB{% endif %}
----- |{% if audience != "internal" %} ----- |{% endif %} ----- | ----- | ----- | ----- |{% if audience == "internal" %} ----- | ----- |{% endif %}
**Логический** | boolean | boolean | boolean | bit | bit |{% if audience == "internal" %} boolean<br/>bool | bool |{% endif %}
**Дата** | date | date | date | date | date |{% if audience == "internal" %} date | date |{% endif %}
**Дата и время** | datetime | datetime | timestamp | datetime<br/>timestamp | datetime<br/>datetime2<br/>smalldatetime<br/>datetimeoffset |{% if audience == "internal" %} datetime<br/>timestamp | datetime<br/>timestamp |{% endif %}
**Дробное число** | float | float<br/>float32<br/>float64<br/>decimal<sup>*</sup> | real<br/>double precision<br/>numeric | float<br/>double<br/>numeric<br/>decimal<sup>*</sup> | float<br/>real<br/>numeric<br/>decimal<sup>*</sup> |{% if audience == "internal" %} float<br/>double<br/>decimal<sup>*</sup> | float<br/>double<br/>decimal<sup>*</sup> |{% endif %}
**Целое число** | int64 | integer<br/>int8<br/>int16<br/>int32<br/>int64<br/>uint8<br/>uint16<br/>uint32<br/>uint64 | smallint<br/>integer<br/>bigint | tinyint<br/>smallint<br/>mediumint<br/>integer<br/>bigint | tinyint<br/>smallint<br/>integer<br/>bigint |{% if audience == "internal" %} interval<br/>int8<br/>int16<br/>int32<br/>int64<br/>uint8<br/>uint16<br/>uint32<br/>uint64 | interval<br/>DyNumber<br/>int8<br/>int16<br/>int32<br/>int64<br/>uint8<br/>uint16<br/>uint32<br/>uint64 |{% endif %}
**Строка** | string | string<br/>enum8<br/>enum16 | char<br/>varchar<br/>text<br/> | tinyblob<br/>blob<br/>binary<br/>varbinary<br/>char<br/>varchar<br/>tinytext<br/>text<br/>enum | char<br/>varchar</br>text<br/>nchar<br/>nvarchar<br/>ntext<br/> |{% if audience == "internal" %} string<br/>utf8 | string<br/>utf8<br/>json<br/>JsonDocument<br/>Uuid |{% endif %}
**Геоточка** | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} |{% if audience == "internal" %} Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} |{% endif %}
**Геополигон** | Задается формулой в {{ datalens-short-name }}  | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} |{% if audience == "internal" %} Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} |{% endif %}
**Массив целых чисел** | Array(int64) | Array(integer)<br/> Array(int8)<br/>Array(int16)<br/>Array(int32)<br/>Array(int64)<br/>Array(uint8)<br/>Array(uint16)<br/>Array(uint32)<br/>Array(uint64) | Array(smallint)<br/>Array(integer)<br/>Array(bigint) | Не поддерживается | Не поддерживается |{% if audience == "internal" %} list | list |{% endif %}
**Массив дробных чисел** | Array(float64) | Array(float32)<br/>Array(float64) | Array(real)<br/>Array(double)<br/>Array(precision)<br/>Array(numeric)| Не поддерживается | Не поддерживается |{% if audience == "internal" %} list | list |{% endif %}
**Массив строк** | Array(string) | Array(string) | Array(char)<br/>Array(varchar)<br/>Array(text) | Не поддерживается | Не поддерживается |{% if audience == "internal" %} list | list |{% endif %}

<sup>*</sup> Возможна потеря точности при конвертации данных.
