---
title: Синтаксис формул в {{ datalens-full-name }}
description: В данной статье описан синтаксис формул для вычисляемых выражений в {{ datalens-name }}.
---

# Синтаксис формул

Вычисляемые выражения в {{ datalens-full-name }} имеют синтаксис, похожий на SQL.
Простые выражения могут быть описаны с помощью обычных арифметических действий:

```
([Sales] - [Profit]) / 10
```

```
[Date] - #2019-01-24#
```

Более сложные выражения используют множество функций для реализации различных вычислений, агрегаций и конвертаций данных из одного типа в другой:

```
CONCAT(SUM([Category Sales]) / [Total Sales], ' %')
```

```
DATETRUNC([datetime], 'month')
```

## Поля датасета в вычислениях {#dataset-fields}

Синтаксис обращения к полям датасета аналогичен Transact-SQL, но в случае {{ datalens-full-name }} требуется заключать имя поля в квадратные скобки (`[]`):

```
[Имя поля]
```

## Константы {#const}

Кроме полей, операторов и функций, в выражениях могут участвовать константы разных типов данных:

- целое число: `23`, `-4325653`;
- дробное число: `0.0234`, `-1.0`;
- дата: `#2020-01-01#`;
- дата и время: `#2020-01-01 11:15:00#`;
- строка: `"Строка"`;
- логический: `TRUE`, `FALSE`;
- геоточка: `GEOPOINT("[55.7912,37.6872]")`.

## Операторы {#operators}

В выражениях доступны операторы:

- Арифметические: `+`, `-`, `*`, `/`.

  ```
  ([Sales per Order] * [OrderCount]) - [Profit]
  ```

  ```
  ([Profit] / [Cost Price]) * 100
  ```

  ```
  [City] + " " + "city"
  ```

Операторы [сложения (+)](../../function-ref/OP_PLUS.md#description), [вычитания (-)](../../function-ref/OP_MINUS.md#description) и [умножения (*)](../../function-ref/OP_MULT.md#description) имеют различное поведение в зависимости от типа аргументов.

- Возведение в степень: `^`.

  ```
  [Mass] * [Speed] ^ 2
  ``` 

- Остаток от деления: `%`.

  ```
  [Sales] % 10 + [Cost Price] % 10
  ```

- Логические: `AND`, `OR`, `NOT`, `IN`, `LIKE`, `IS TRUE`, `IS FALSE`, `BETWEEN`.

- Сравнения: `=`, `!=`, `<`, `<=`, `>`, `>=`.

  Операторы сравнения позволяют создавать логические цепочки:

  ```
  1 > x > -4 > y != 8
  ```

Полное описание [всех операторов](../../function-ref/operator-functions.md).

## Форматирование формул {#formatting}

Любая формула может быть записана в одну строку или в несколько строк:

```
CONCAT(
    SUM([Category Sales]) / [Total Sales],
    ' %'
)
```

## Комментарии {#comments}

Для добавления пояснений или для игнорирования частей формул используются комментарии:

- Однострочный комментарий.

  ```
  -- Это однострочный комментарий
  ```

- Блоковый комментарий.

  ```
  /* Это блоковый
  комментарий */
  ```

## Логические операции {#logical-operations}

Для ветвления вычислений в выражениях используются логические функции:

- `CASE`.

  ```
  CASE [ProductID]
      WHEN 1 THEN "Bananas"
      WHEN 2 THEN "Apples"
      WHEN 3 THEN "Pears"
      ELSE "Other"
  END
  ```

  ```
  CASE( 
      [Color],
      "R", "Red",
      "G", "Green",
      "B", "Blue",
      "Not RGB" 
  )
  ```

  Полное описание логической функции [CASE](../../function-ref/CASE.md).

- `IF`.

  ```
  IF([MassIndex] BETWEEN 18.5 AND 25, "Normally", "Not normal")
  ```

  ```
  IF
      [Year] % 400 = 0 OR ([Year] % 4 = 0 AND [Year] % 100 != 0)
          THEN "Leap year"
      ELSE "Ordinary year"
  END
  ```
  ```
  IF
      [City] = "Moscow"
          THEN "This is the Capital"
      ELSEIF [City] = "St. Petersburg"
          THEN "This is the northern Capital"
      ELSE "Other city"
  END
  ```


Полное описание логической функции [IF](../../function-ref/IF.md).

- `IFNULL`, `ISNULL`, `ZN`.

  ```
  IFNULL([Cost Price], 10) * [OrderCount]
  ```

  Полное описание логической функции [IFNULL](../../function-ref/IFNULL.md).

  ```
  IF(ISNULL([Product Name]) = TRUE, "Unnamed", [Product Name] + " " + [ProductID])
  ```

  Полное описание логической функции [ISNULL](../../function-ref/ISNULL.md).

  ```
  ZN([Total Sales]) - ZN([Total Cost])
  ```

  Полное описание логической функции [ZN](../../function-ref/ZN.md).

## Строки {#strings}

Для обработки текстовых данных используются [строковые функции](../../function-ref/string-functions.md):

```
CONCAT([Total Sales], "$")
```

```
IF(CONTAINS([Product Name], "RU"), [Product Cost] + " " + "RUB", [Product Cost] + " " + "USD")
```

```
REPLACE([OrderID], "2020", [Month])
```

```
IF(STARTSWITH([Region Name], "RU_"), SPLIT([Region Name], "_", 2), [Region Name])
```

Строки могут быть заданы с помощью одиночных или двойных кавычек. При этом один вид кавычек может использоваться внутри другого:

```
FIND([Product Name], 'plus')
```

```
CONCAT('"', [Product Name], '"')
```

В формулах можно выполнять различные преобразования строковых данных с использованием [специальных символов](../../dataset/data-types.md#string):

```
REPLACE([ShopAddress], "\n", " ")
```

```
"File path" + " = " + "\\" + [Folder] + '\\' + [Filename]
```

{% note info %}

Специальные символы `\n`, `\t`, `\r` не влияют на отображение исходных данных.

{% endnote %}

## Преобразование типов {#type-conversions}

Значения выражений могут быть переведены из одного типа в другой:

```
FLOAT([StringWithNumbers])
```

```
DATETIME(STR([Order Date]) + "-" + STR([Order Time]))
```

```
GEOPOINT([Latitude],[Longitude])
```

Полное описание функций [преобразования типов](../../function-ref/type-conversion-functions.md).

## Агрегирование {#aggregation}

Для вычисления результирующих значений используются [агрегатные функции](../../function-ref/aggregation-functions.md):

```
AVG([Check Total]) * COUNTD([CustomerID])
```

```
SUM_IF([Sales], [Category] = "Fruits")
```

```
IF
    MIN[Date] = #2020-01-01#
        THEN SUM[Sales] * 1.1
    ELSE SUM[Sales] * 1.2
END
```

[Оконные функции](../../function-ref/window-functions.md) позволяют агрегировать значения из группы строк, не объединяя сами эти строки в одну, что отличает их от агрегатных. Также оконные функции позволяют рассчитывать значения для одной строки в контексте значений из других строк.

```
SUM([Sales] WITHIN [PaymentType]) / SUM([Sales] TOTAL)
```

```
MSUM([Sales per Order], 1 WITHIN [ProductID] ORDER BY [Price])
```

```
RANK_DENSE(AVG([Price]), "desc" WITHIN [ShopID] BEFORE FILTER BY [PaymentType])
```

Оконные функции поддерживают [группировку](../../function-ref/window-functions.md#syntax-grouping) и [сортировку](../../function-ref/window-functions.md#syntax-order-by) записей, а также опцию [BEFORE FILTER BY](../../function-ref/window-functions.md#syntax-before-filter-by).

## Разметка текста {#text-markup}

Для создания размеченного текста используются [функции разметки](../../function-ref/markup-functions.md):

```
MARKUP(BOLD("This"), " ", ITALIC("is"), " ", URL("https://example.com/", [LinkName]))
```

Чтобы использовать числовые константы при разметке URL-адреса, необходимо их привести к типу `Строка`:

```
URL("https://example.com/?value=" + STR([Value]), [Value])
```
