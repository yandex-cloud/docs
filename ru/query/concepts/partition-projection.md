# Расширенное партиционирование

[Партиционирование](partitioning.md) позволяет подсказать для {{yq-full-name}} правила размещения данных в {{objstorage-full-name}}.

Предположим, что данные в {{objstorage-full-name}} хранятся в следующей структуре каталогов:

```
year=2021
    month=01
    month=02
    month=03
year=2022
    month=01
```

При выполнении запроса ниже {{yq-full-name}} выполнит следующие действия:
1. Получит полный список подкаталогов внутри '/'.
1. Для каждого подкаталога выполнит попытку обработать имя подкаталога в формате "year=\<DIGITS\>". 
1. Для каждого подкаталога "year=\<DIGITS\>" получит список всех подкаталогов в формате "month=\<DIGITS\>".
1. Обработает считанные данные.

```sql
SELECT 
    * 
FROM 
    objectstorage.'/' 
    WITH
    (
        Schema =
        (
            data String, 
            year Int, 
            month Int
        ),
        partitioned_by = 
        (
            year,
            month
        )
    ) 
WHERE 
    year=2021 
    AND month=02
```

То есть при работе с партиционированными данными выполняется полный листинг содержимого {{objstorage-full-name}}, что может занимать продолжительное время на бакетах большого размера. 

Для оптимизации работы на больших объемах данных следует использовать "расширенное партиционирование". В этом режиме не происходит сканирования каталогов {{ objstorage-full-name }}, вместо этого все пути вычисляются заранее и обращение происходит только к ним. 

Для работы расширенного партиционирования необходимо задать правила работы через специальный параметр - "projection". В этом параметре описываются все правила размещения данных в каталога {{ objstorage-full-name}}.

## Синтаксис { #syntax }

Расширенное партиционирование называется "partition projection" и задается через параметр `projection`.

Пример указания расширенного партиционирования:

```sql

$projection = 
@@ 
{
    "projection.enabled" : true,

    "projection.year.type" : "integer",
    "projection.year.min" : 2010,
    "projection.year.max" : 2022,
    "projection.year.interval" : 1,

    "projection.month.type" : "integer",
    "projection.month.min" : 1,
    "projection.month.max" : 12,
    "projection.month.interval" : 1,
    "projection.month.digits" : 2,

    "storage.location.template" : "${year}/${month}"
}
@@;

SELECT 
    * 
FROM 
    <connection>.`/`
WITH 
(
    schema=
    (
        data String, 
        year Int, 
        month Int
    ), 
    partitioned_by=(year, month),
    projection=@projection
)
```

В примере выше указывается, что данные существуют за каждый год и каждый месяц с 2010 по 2022 годы, при этом в бакете данные размещены в каталогах вида `2022/12`.

В общем виде настройка расширенного партиционирования выглядит следующим образом:

```sql

$projection = 
@@ 
{
    "projection.enabled" : <true|false>,

    "projection.<field1_name>.type" : "<type>",
    "projection.<field1_name>...." : "<extended_properties>",

    "projection.<field2_name>.type" : "<type>",
    "projection.<field2_name>...." : "<extended_properties>",

    "storage.location.template" : ".../${field2}/${field1}/..."
}
@@;

SELECT 
    * 
FROM 
    <connection>.<path> 
WITH 
(
    schema=(<fields>, <field1>, <field2>), 
    partitioned_by=(field1, field2),
    projection=@projection
)
```

## Описание полей { #field_types }

|Название поля|Описание поля|Допустимые значения|
|----|----|----|
|`projection.enabled`|Включено или нет расширенное партиционирование| true, false|
|`projection.<field1_name>.type`|Тип данных поля|integer, enum, date|
|`projection.<field1_name>.XXX`|Свойства конкретного типа||

### Поле типа integer { #integer_type }

Используется для колонок, чьи значения можно представить в виде целых чисел диапазона 2^-63^ до 2^63^-1.

|Название поля|Обязательное|Описание поля|Пример значений|
|----|----|----|----|
|`projection.<field_name>.type`|Да|Тип данных поля|integer|
|`projection.<field_name>.min`|Да|Определяет минимально допустимое значение. Задается в виде целого числа|-100<br>004|
|`projection.<field_name>.max`|Да|Определяет максимально допустимое значение. Задается в виде целого числа|-10<br>5000|
|`projection.<field_name>.interval`|Нет, по умолчанию `1`|Определяет шаг между элементами внутри диапазона значений. Например, шаг 3 при диапазоне значений 2, 10, приведет к следующим значениям: 2, 5, 8|2<br>11|
|`projection.<field_name>.digits`|Нет, по умолчанию `0`|Определяет количество цифр в числе. Если ненулевых цифр в числе меньше, чем указанное значение, то значение дополняется нулями спереди вплоть до числа указанного числа цифр. Например, если указано значение .digits=3, а передается число 2, то оно будет превращено в значение 002|2<br>4|

### Поле типа enum { #enum_type }

Используется для колонок, чьи значения можно представить в виде перечисления значений.

|Название поля|Обязательное|Описание поля|Пример значений
|----|----|----|----|
|`projection.<field_name>.type`|Да|Тип данных поля|enum|
|`projection.<field_name>.values`|Да|Определяет допустимые значения, указанные через запятую. Пробелы не игнорируются|1, 2<br>A,B,C|

### Поле типа date { #date_type }

Используется для колонок, чьи значения можно представить в виде даты. 

|Название поля|Обязательное|Описание поля|Пример значений|
|----|----|----|----|
|`projection.<field_name>.type`|Да|Тип данных поля|date|
|`projection.<field_name>.min`|Да|Определяет минимально допустимую дату. Разрешены значения в формате `YYYY-MM-DD` или в виде выражения, содержащего специальную макроподстановку NOW. С макроподстановкой NOW возможно выполнять арифметические действия:  <br>NOW-3DAYS, <br> NOW+1MONTH, <br>NOW-6YEARS, <br>NOW+4HOURS, <br>NOW-5MINUTES, <br> NOW+6SECONDS. |2020-01-01<br/>NOW-5DAYS<br/>NOW+3HOURS|
|`projection.<field_name>.max`|Да|Определяет максимально допустимую дату. Разрешены значения в формате `YYYY-MM-DD` или в виде выражения, содержащего специальную макроподстановку NOW. С макроподстановкой NOW возможно выполнять арифметические действия:  <br>NOW-3DAYS, <br> NOW+1MONTH, <br>NOW-6YEARS, <br>NOW+4HOURS, <br>NOW-5MINUTES, <br> NOW+6SECONDS. |2020-01-01<br/>NOW-5DAYS<br/>NOW+3HOURS|
|`projection.<field_name>.format`|Да|Строка форматирования даты на основе [strptime](https://cplusplus.com/reference/ctime/strftime/)|%Y-%m-%d<br/>%D|
{% if yq_version>"0.1"%}
|`projection.<field_name>.unit`|Нет, по умолчанию `DAYS`|Единицы измерения интервалов времени. Допустимые значения: YEARS, MONTHS, WEEKS, DAYS, HOURS, MINUTES, SECONDS, MILLISECONDS|SECONDS<br/>YEARS|
{% else %}
|`projection.<field_name>.unit`|Нет|Единицы измерения интервалов времени. Допустимые значения: DAYS|DAYS|
{% endif %}
|`projection.<field_name>.interval`|Нет, по умолчанию `1`|Определяет шаг между элементами внутри диапазона значений с размерностью, указанной в `projection.<field_name>.unit`. Например, для диапазона 2021-02-02, 2021-03-05 шаг 15 c размерностью DAYS приведет к значениям: 2021-02-17, 2021-03-04|2<br/>6|

## Шаблоны путей { #storage_location_template}

Данные в бакетах {{ objstorage-full-name }} могут быть размещены в каталогах с произвольными названием. С помощью настройки `storage.location.template` можно указать правила именования каталогов, где хранятся данные.

|Название поля|Описание поля|Пример значений|
|----|----|----|
|`storage.location.template`|Шаблон пути имен каталогов. Задается в формате "${<field_name...>}/${<field_name...>}"|root/a/${year}/b/${month}/d<br/>${year}/${month}|
