---
title: Агрегатные функции
description: Агрегатные функции (агрегации) — это функции, которые вычисляются от группы значений и объединяют их в одно результирующее.
keywords:
- агрегатные функции
- агрегации
- агрегирующие функции
- агрегированные данные
- агрегирование данных
- агрегирование
- агрегация данных
- level of detail
- lod
- уровень детализации
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/aggregation-functions.md
---

# Агрегатные функции
Агрегатные функции (агрегации) — это функции, которые вычисляются от группы значений и объединяют их в одно результирующее.

Если в поле с измерением добавить агрегацию, то поле становится показателем.

## Синтаксис {#syntax}

В большинстве случаев у агрегатных функций такой же синтаксис, как и у обычных функций:
```
AGGREGATE_FUNCTION_NAME(arg1, [arg2, ...])
```

Для использования нестандартного уровня детализации (LOD) понадобится расширенный вариант:
```
<AGGREGATE_FUNCTION_NAME>(
    arg1, [arg2, ...]

    [ FIXED dim1, dim2, ...
    | INCLUDE dim1, dim2, ...
    | EXCLUDE dim1, dim2, ... ]

    [ BEFORE FILTER BY filtered_field1, ... ]
)
```
### Уровень детализации (LOD) {#syntax-lod}

Управление уровнем детализации (англ. level of detail - LOD) позволяет создавать вложенные агрегации и агрегации над всеми данными или группами, отличающимися от группировки, заданной на уровне чарта.

Уровень детализации может быть задан с помощью одного из трех ключевых слов:
- `FIXED` — данные группируются по перечисленным измерениям (`dim1, dim2, ...`) вне зависимости от того, какие измерения используются в чарте;
- `INCLUDE` — перечисленные измерения (`dim1, dim2, ...`) добавляются к измерениям чарта;
- `EXCLUDE` — используются все измерения чарта, кроме перечисленных (`dim1, dim2, ...`).

Для любого из этих ключевых слов список может содержать неограниченное количество измерений или быть пустым.

#### Наследование измерений {#syntax-lod-inheritance}
Вложенные агрегации наследуют измерения от тех агрегаций, внутри которых находятся. Выражение
```
AVG(MAX(SUM([Sales] INCLUDE [City]) INCLUDE [Category]))
```
в чарте с дополнительным измерением `[Date]` эквивалентно
```
AVG(MAX(SUM([Sales] FIXED [City], [Category], [Date]) FIXED [Category], [Date]) FIXED [Date])
```
`INCLUDE` или `EXCLUDE` без списка измерений равносильно измерениям внешней агрегации или измерениям чарта, если над текущей агрегацией нет других. `FIXED` без списка означает, что все данные будут агрегированы в одной группе, например, для расчетов итоговых значений.

#### Примеры LOD {#syntax-lod-examples}

- средняя дневная сумма `[Sales]`: `AVG(SUM([Sales] INCLUDE [Date]))`;
- отношение (дневной) суммы `[Sales]` к общей сумме: `SUM([Sales]) / SUM([Sales] FIXED)`;
- сумма `[Sales]` всех заказов, которые меньше среднего: `SUM_IF(SUM([Sales] INCLUDE [Order ID]), SUM([Sales] INCLUDE [Order ID]) < AVG([Sales] FIXED))`.

#### Совместимость измерений {#syntax-lod-compatibility}

Если несколько агрегаций с разными наборами измерений (LOD) находятся внутри другой агрегации, то их наборы измерений должны быть совместимы. То есть один из этих наборов должен содержать все остальные.

Некорректное выражение:
```
SUM(AVG([Sales] INCLUDE [City]) - AVG([Sales] INCLUDE [Category]))
```
У одной из вложенных агрегаций измерение `[City]`, а у другой — `[Category]`. При этом нет другой агрегации, которая содержала бы оба эти измерения.

Корректное выражение:
```
SUM(
    AVG([Sales] INCLUDE [City], [Category])
    - (AVG([Sales] INCLUDE [City]) + AVG([Sales] INCLUDE [Category])) / 2
)
```

У одной из вложенных агрегаций множество измерений содержит остальные.

Другое важное ограничение состоит в том, что верхнеуровневые агрегации не должны содержать измерений, которых нет в чарте.

### BEFORE FILTER BY {#syntax-before-filter-by}

Если какие-либо поля перечислены в `BEFORE FILTER BY`, то эта агрегатная функция будет рассчитана до фильтрации данных по этим полям.

`BEFORE FILTER BY` применяется также и ко всем вложенным агрегатным функциям.
Пример:
- функция — `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [City]))`;
- эквивалент — `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [City]) BEFORE FILTER BY [Category])`.

Не используйте конфликтующие `BEFORE FILTER BY` в запросе:
- корректная формула: `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [City], [Category]) BEFORE FILTER BY [City])` — функции вложены друг в друга, и (`[City]`) является подмножеством (`[City], [Category]`);
- корректная формула: `AVG(SUM([Sales] INCLUDE [Date] BEFORE FILTER BY [Category]) BEFORE FILTER BY [City])` — функции вложены друг в друга, поэтому списки полей комбинируются во второй из функций;
- корректная формула: `SUM([Sales] BEFORE FILTER BY [City], [Category]) - SUM([Sales] BEFORE FILTER BY [City])` — (`[City]`) является подмножеством (`[City], [Category]`);
- некорректная формула: `SUM([Sales] BEFORE FILTER BY [Category]) - SUM([Sales] BEFORE FILTER BY [City])` — функции не вложены, и ни одно из (`[Category]`) и (`[City]`) не является подмножеством другого.

## Ограничения использования {#usage-restrictions}

Существуют следующие особенности использования агрегаций:
1. Функция или оператор не может иметь среди своих аргументов одновременно агрегированные и неагрегированные выражения. Выражение `CONCAT([Profit], SUM([Profit]))` не поддерживается.



## [ALL_CONCAT](ALL_CONCAT.md)

**Синтаксис:**<br/>`ALL_CONCAT( expression [ , separator ] )`<br/>или<br/>`ALL_CONCAT( expression [ , separator ]
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )`

Возвращает строку, которая содержит все попавшие в группу значения `expression`, с разделителем `separator` (по умолчанию разделитель — запятая).



## [ANY](ANY.md)

**Синтаксис:**<br/>`ANY( value )`<br/>или<br/>`ANY( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Возвращает произвольное значение `value` из группы. Это недетерминированная агрегация — результат может различаться от запроса к запросу на одних и тех же входных данных.



## [ARG_MAX](ARG_MAX.md)

**Синтаксис:**<br/>`ARG_MAX( value, comp )`<br/>или<br/>`ARG_MAX( value, comp
         [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
         [ BEFORE FILTER BY ... ]
       )`

Возвращает значение `value`, соответствующее максимальному значению `comp`. Если есть несколько значений `value`, соответствующих максимальному значению `comp`, то возвращет первое попавшееся из них. Это делает функцию недетерминированной.



## [ARG_MIN](ARG_MIN.md)

**Синтаксис:**<br/>`ARG_MIN( value, comp )`<br/>или<br/>`ARG_MIN( value, comp
         [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
         [ BEFORE FILTER BY ... ]
       )`

Возвращает значение `value`, соответствующее минимальному значению `comp`. Если есть несколько значений `value`, соответствующих минимальному значению `comp`, то возвращет первое попавшееся из них. Это делает функцию недетерминированной.



## [AVG](AVG.md)

**Синтаксис:**<br/>`AVG( value )`<br/>или<br/>`AVG( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Возвращает среднее для всех значений. Работает с числовыми типами данных и с типами `Дата`.



## [AVG_IF](AVG_IF.md)

**Синтаксис:**<br/>`AVG_IF( expression, condition )`<br/>или<br/>`AVG_IF( expression, condition
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Возвращает среднее для всех значений, которые удовлетворяют условию `condition`. Если значения отсутствуют, то возвращается `NULL`. Работает только с числовыми типами данных.



## [COUNT](COUNT.md)

**Синтаксис:**<br/>`COUNT(  [ value ] )`<br/>или<br/>`COUNT(  [ value ]
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )`

Возвращает количество элементов в группе.



## [COUNT_IF](COUNT_IF.md)

**Синтаксис:**<br/>`COUNT_IF( condition )`<br/>или<br/>`COUNT_IF( condition
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )`

Возвращает количество элементов в группе, которые удовлетворяют условию `condition`.



## [COUNTD](COUNTD.md)

**Синтаксис:**<br/>`COUNTD( value )`<br/>или<br/>`COUNTD( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Возвращает количество уникальных значений в группе.

См. также [COUNTD_APPROX](COUNTD_APPROX.md).



## [COUNTD_APPROX](COUNTD_APPROX.md)

**Синтаксис:**<br/>`COUNTD_APPROX( value )`<br/>или<br/>`COUNTD_APPROX( value
               [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
               [ BEFORE FILTER BY ... ]
             )`

Возвращает приблизительное количество уникальных значений в группе. Работает быстрее функции [COUNTD](COUNTD.md), но не гарантирует точность.



## [COUNTD_IF](COUNTD_IF.md)

**Синтаксис:**<br/>`COUNTD_IF( expression, condition )`<br/>или<br/>`COUNTD_IF( expression, condition
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )`

Возвращает количество уникальных значений в группе, которые удовлетворяют условию `condition`.

См. также [COUNTD_APPROX](COUNTD_APPROX.md).



## [MAX](MAX.md)

**Синтаксис:**<br/>`MAX( value )`<br/>или<br/>`MAX( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Возвращает максимальное значение.

Если `value`:
- число — возвращает наибольшее число;
- дата — возвращает самую позднюю дату;
- строка — возвращает последнее значение в алфавитном порядке.




## [MEDIAN](MEDIAN.md)

**Синтаксис:**<br/>`MEDIAN( value )`<br/>или<br/>`MEDIAN( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Вовзращает медианное значение.



## [MIN](MIN.md)

**Синтаксис:**<br/>`MIN( value )`<br/>или<br/>`MIN( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Возвращает минимальное значение.

Если `value`:
- число — возвращает наименьшее число;
- дата — возвращает самую раннюю дату;
- строка — возвращает первое значение в алфавитном порядке.




## [QUANTILE](QUANTILE.md)

**Синтаксис:**<br/>`QUANTILE( value, quant )`<br/>или<br/>`QUANTILE( value, quant
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )`

Возвращает точный квантиль уровня `quant` (значение от 0 до 1).



## [QUANTILE_APPROX](QUANTILE_APPROX.md)

**Синтаксис:**<br/>`QUANTILE_APPROX( value, quant )`<br/>или<br/>`QUANTILE_APPROX( value, quant
                 [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                 [ BEFORE FILTER BY ... ]
               )`

Возвращает примерный квантиль уровня `quant` (значение от 0 до 1).



## [STDEV](STDEV.md)

**Синтаксис:**<br/>`STDEV( value )`<br/>или<br/>`STDEV( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )`

Возвращает статистическое стандартное отклонение всех значений в выражении на основе выборки из совокупности.



## [STDEVP](STDEVP.md)

**Синтаксис:**<br/>`STDEVP( value )`<br/>или<br/>`STDEVP( value
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Возвращает статистическое стандартное отклонение всех значений в выражении на основе смещенной совокупности.



## [SUM](SUM.md)

**Синтаксис:**<br/>`SUM( value )`<br/>или<br/>`SUM( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Возвращает сумму всех значений выражения. Работает только с числовыми типами данных.



## [SUM_IF](SUM_IF.md)

**Синтаксис:**<br/>`SUM_IF( expression, condition )`<br/>или<br/>`SUM_IF( expression, condition
        [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
        [ BEFORE FILTER BY ... ]
      )`

Возвращает сумму всех значений выражения, которые удовлетворяют условию `condition`. Работает только с числовыми типами данных.



## [TOP_CONCAT](TOP_CONCAT.md)

**Синтаксис:**<br/>`TOP_CONCAT( expression, amount [ , separator ] )`<br/>или<br/>`TOP_CONCAT( expression, amount [ , separator ]
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )`

Возвращает строку, которая содержит `amount` наиболее часто встречающихся значений из каждой группы `expression` с разделителем `separator` (по умолчанию разделитель — запятая).



## [VAR](VAR.md)

**Синтаксис:**<br/>`VAR( value )`<br/>или<br/>`VAR( value
     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
     [ BEFORE FILTER BY ... ]
   )`

Возвращает статистическую дисперсию всех значений в выражении на основе выборки из совокупности.



## [VARP](VARP.md)

**Синтаксис:**<br/>`VARP( value )`<br/>или<br/>`VARP( value
      [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
      [ BEFORE FILTER BY ... ]
    )`

Возвращает статистическую дисперсию всех значений в выражении по всей совокупности.


