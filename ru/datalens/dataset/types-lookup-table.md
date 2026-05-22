---
title: Таблица соответствий типов баз данных и внутренних типов {{ datalens-full-name }}
description: При создании датасета {{ datalens-full-name }} приводит данные из источника в свой тип для оптимизации. Это позволяет {{ datalens-short-name }} унифицировать работу с данными из разных источников.
---

# Таблица соответствий типов баз данных и внутренних типов {{ datalens-full-name }}

При создании датасета {{ datalens-short-name }} приводит данные из источника в свой тип для оптимизации.
Это позволяет {{ datalens-short-name }} унифицировать работу с данными из разных источников.

Ниже приведена таблица соответствий типов баз данных и внутренних типов {{ datalens-short-name }}.

DataLens | {{ CH }} | PostgreSQL | MySQL | MS SQL | {{ ydb-short-name }}
----- | ----- | ----- | ----- | ----- | -----
**Логический** | boolean | boolean | bit | bit | boolean
**Дата** | date | date | date | date | date<br/>date32
**Дата и время** | datetime | timestamp | datetime<br/>timestamp | datetime<br/>datetime2<br/>smalldatetime<br/>datetimeoffset | datetime<br/>datetime64<br/>timestamp<br/>timestamp64
**Дробное число** | float<br/>float32<br/>float64<br/>decimal<sup>*</sup> | real<br/>double precision<br/>numeric | float<br/>double<br/>numeric<br/>decimal<sup>*</sup> | float<br/>real<br/>numeric<br/>decimal<sup>*</sup> | float<br/>double<br/>decimal<sup>*</sup><br/>dynumber
**Целое число** | integer<br/>int8<br/>int16<br/>int32<br/>int64<br/>uint8<br/>uint16<br/>uint32<br/>uint64 | smallint<br/>integer<br/>bigint | tinyint<br/>smallint<br/>mediumint<br/>integer<br/>bigint | tinyint<br/>smallint<br/>integer<br/>bigint | int8<br/>int16<br/>int32<br/>int64<br/>uint8<br/>uint16<br/>uint32<br/>uint64<br/>interval<br/>interval64
**Строка** | string<br/>enum8<br/>enum16 | char<br/>varchar<br/>text<br/>citext<br/> | tinyblob<br/>blob<br/>binary<br/>varbinary<br/>char<br/>varchar<br/>tinytext<br/>text<br/>enum | char<br/>varchar</br>text<br/>nchar<br/>nvarchar<br/>ntext<br/> | string<br/>utf8
**Геоточка** | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }}
**Геополигон** | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }} | Задается формулой в {{ datalens-short-name }}
**Массив целых чисел** | Array(integer)<br/> Array(int8)<br/>Array(int16)<br/>Array(int32)<br/>Array(int64)<br/>Array(uint8)<br/>Array(uint16)<br/>Array(uint32)<br/>Array(uint64) | Array(smallint)<br/>Array(integer)<br/>Array(bigint) | Не поддерживается | Не поддерживается | Не поддерживается
**Массив дробных чисел** | Array(float32)<br/>Array(float64) | Array(real)<br/>Array(double)<br/>Array(precision)<br/>Array(numeric)| Не поддерживается | Не поддерживается | Не поддерживается
**Массив строк** | Array(string) | Array(char)<br/>Array(varchar)<br/>Array(text) | Не поддерживается | Не поддерживается | Не поддерживается

<sup>*</sup> Возможна потеря точности при конвертации данных.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
