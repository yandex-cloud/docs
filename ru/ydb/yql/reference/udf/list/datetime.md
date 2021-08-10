---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# DateTime UDF

В модуле DateTime основным внутренним форматом представления является `Resource<TM>`, хранящий следующие компоненты даты:

* Year (12 бит);
* Month (4 бита);
* Day (5 бит);
* Hour (5 бит);
* Minute (6 бит);
* Second (6 бит);
* Microsecond (20 бит);
* TimezoneId (16 бит);
* DayOfYear (9 бит) — день от начала года;
* WeekOfYear (6 бит) — неделя от начала года, 1 января всегда относится к первой неделе;
* DayOfWeek (3 бита) — день недели.

Если таймзона не GMT, то в компонентах хранится локальное время в соответствующей таймзоне.

## Split {#split}

Преобразование из примитивного типа во внутреннее представление. Всегда успешно при непустом входе.

**Список функций**

* ```DateTime::Split(Date{Flags:AutoMap}) -> Resource<TM>```
* ```DateTime::Split(Datetime{Flags:AutoMap}) -> Resource<TM>```
* ```DateTime::Split(Timestamp{Flags:AutoMap}) -> Resource<TM>```

Функции, принимающие на вход `Resource<TM>`, могут быть вызваны непосредственно от примитивного типа даты/времени. В этом случае будет сделано неявное преобразование через вызов соответствующей функции `Split`.

## Make... {#make}

Сборка примитивного типа из внутреннего представления. Всегда успешна при непустом входе.

**Список функций**

* ```DateTime::MakeDate(Resource<TM>{Flags:AutoMap}) -> Date```
* ```DateTime::MakeDatetime(Resource<TM>{Flags:AutoMap}) -> Datetime```
* ```DateTime::MakeTimestamp(Resource<TM>{Flags:AutoMap}) -> Timestamp```

**Примеры**

```sql
SELECT
    DateTime::MakeTimestamp(DateTime::Split(Datetime("2019-01-01T15:30:00Z"))), -- 2019-01-01T15:30:00.000000Z
    DateTime::MakeDate(Datetime("2019-01-01T15:30:00Z")); -- 2019-01-01
```

## Get... {#get}

Взятие компоненты внутреннего представления.

**Список функций**

* ```DateTime::GetYear(Resource<TM>{Flags:AutoMap}) -> Uint16```
* ```DateTime::GetDayOfYear(Resource<TM>{Flags:AutoMap}) -> Uint16```
* ```DateTime::GetMonth(Resource<TM>{Flags:AutoMap}) -> Uint8```
* ```DateTime::GetMonthName(Resource<TM>{Flags:AutoMap}) -> String```
* ```DateTime::GetWeekOfYear(Resource<TM>{Flags:AutoMap}) -> Uint8```
* ```DateTime::GetDayOfMonth(Resource<TM>{Flags:AutoMap}) -> Uint8```
* ```DateTime::GetDayOfWeek(Resource<TM>{Flags:AutoMap}) -> Uint8```
* ```DateTime::GetDayOfWeekName(Resource<TM>{Flags:AutoMap}) -> String```
* ```DateTime::GetHour(Resource<TM>{Flags:AutoMap}) -> Uint8```
* ```DateTime::GetMinute(Resource<TM>{Flags:AutoMap}) -> Uint8```
* ```DateTime::GetSecond(Resource<TM>{Flags:AutoMap}) -> Uint8```
* ```DateTime::GetMillisecondOfSecond(Resource<TM>{Flags:AutoMap}) -> Uint32```
* ```DateTime::GetMicrosecondOfSecond(Resource<TM>{Flags:AutoMap}) -> Uint32```

**Примеры**

```sql
$tm = DateTime::Split(Datetime("2019-01-09T00:00:00Z"));

SELECT
    DateTime::GetDayOfMonth($tm) as Day, -- 9
    DateTime::GetMonthName($tm) as Month, -- "January"
    DateTime::GetYear($tm) as Year, -- 2019
    DateTime::GetDayOfWeekName($tm) as WeekDay; -- "Wednesday"
```

## Update {#update}

Обновление одной или нескольких компонент во внутреннем представлении. Возвращает либо обновлённую копию, либо NULL, если после обновления получается некорректная дата или возникают другие противоречия.

**Список функций**

* ```DateTime::Update(Resource<TM>{Flags:AutoMap}, [Year:Uint16?, Month:Uint8?, Day:Uint8?, Hour:Uint8?, Minute:Uint8?, Second:Uint8?, Microsecond:Uint32?]) -> Resource<TM>?```

**Примеры**

```sql
$tm = DateTime::Split(Timestamp("2019-01-01T01:02:03.456789Z"));

SELECT
    DateTime::MakeDate(DateTime::Update($tm, 2012)), -- 2012-01-01
    DateTime::MakeDate(DateTime::Update($tm, 2000, 6, 6)), -- 2000-06-06
    DateTime::MakeDate(DateTime::Update($tm, NULL, 2, 30)), -- NULL (30 февраля)
    DateTime::MakeDatetime(DateTime::Update($tm, NULL, NULL, 31)), -- 2019-01-31T01:02:03Z
    DateTime::MakeDatetime(DateTime::Update($tm, 15 as Hour, 30 as Minute)), -- 2019-01-01T15:30:03Z
    DateTime::MakeTimestamp(DateTime::Update($tm, 999999 as Microsecond)); -- 2019-01-01T01:02:03.999999Z
```

## From... / To... / Interval... {#from-to-interva;}

Получение Timestamp из количества секунд/миллисекунд/микросекунд от начала эпохи.

**Список функций**

* ```DateTime::FromSeconds(Uint32{Flags:AutoMap}) -> Timestamp```
* ```DateTime::FromMilliseconds(Uint64{Flags:AutoMap}) -> Timestamp```
* ```DateTime::FromMicroseconds(Uint64{Flags:AutoMap}) -> Timestamp```

Получение количества секунд/миллисекунд/микросекунд от начала эпохи из примитивного типа.

**Список функций**

* ```DateTime::ToSeconds(Date/DateTime/Timestamp{Flags:AutoMap}) -> Uint32```
* ```DateTime::ToMilliseconds(Date/DateTime/Timestamp{Flags:AutoMap}) -> Uint64```
* ```DateTime::ToMicroseconds(Date/DateTime/Timestamp{Flags:AutoMap}) -> Uint64```

**Примеры**

```sql
SELECT
    DateTime::FromSeconds(1546304523), -- 2019-01-01T01:02:03.000000Z
    DateTime::ToMicroseconds(Timestamp("2019-01-01T01:02:03.456789Z")); -- 1546304523456789
```

Преобразования между ```Interval``` и различными единицами измерения времени.

**Список функций**

* ```DateTime::ToDays(Interval{Flags:AutoMap}) -> Int16```
* ```DateTime::ToHours(Interval{Flags:AutoMap}) -> Int32```
* ```DateTime::ToMinutes(Interval{Flags:AutoMap}) -> Int32```
* ```DateTime::ToSeconds(Interval{Flags:AutoMap}) -> Int32```
* ```DateTime::ToMilliseconds(Interval{Flags:AutoMap}) -> Int64```
* ```DateTime::ToMicroseconds(Interval{Flags:AutoMap}) -> Int64```
* ```DateTime::IntervalFromDays(Int16{Flags:AutoMap}) -> Interval```
* ```DateTime::IntervalFromHours(Int32{Flags:AutoMap}) -> Interval```
* ```DateTime::IntervalFromMinutes(Int32{Flags:AutoMap}) -> Interval```
* ```DateTime::IntervalFromSeconds(Int32{Flags:AutoMap}) -> Interval```
* ```DateTime::IntervalFromMilliseconds(Int64{Flags:AutoMap}) -> Interval```
* ```DateTime::IntervalFromMicroseconds(Int64{Flags:AutoMap}) -> Interval```

**Примеры**

```sql
SELECT
    DateTime::ToDays(Interval("PT3000M")), -- 2
    DateTime::IntervalFromSeconds(1000000); -- 11 days 13 hours 46 minutes 40 seconds
```

## Format {#format}

Получить строковое представление момента времени, используя произвольную строку форматирования.

**Список функций**

* ```DateTime::Format(String) -> (Resource<TM>{Flags:AutoMap}) -> String```

Для строки форматирования реализовано подмножество спецификаторов, аналогичных strptime.

* `%%` - символ %;
* `%Y` - год 4 цифры;
* `%m` - месяц 2 цифры;
* `%d` - день 2 цифры;
* `%H` - час 2 цифры;
* `%M` - минуты 2 цифры;
* `%S` - секунды 2 цифры -- или xx.xxxxxx в случае непустых микросекунд;
* `%z` - +hhmm or -hhmm;
* `%Z` - IANA имя таймзоны.

Все остальные символы строки форматирования переносятся без изменений.

**Примеры**

```sql
$format = DateTime::Format("%Y-%m-%d %H:%M:%S %Z");

SELECT
    $format(DateTime::Split(Datetime("2019-01-01T01:02:03Z"))); -- "2019-01-01 01:02:03 GMT"
```

## Parse {#parse}

Распарсить строку во внутреннее представление, используя произвольную строку форматирования. Для незаполненных полей используются значения по умолчанию. При возникновении ошибок возвращается NULL.

**Список функций**

* ```DateTime::Parse(String) -> (String{Flags:AutoMap}) -> Resource<TM>?```

Реализованные спецификаторы:

* `%%` - символ %;
* `%Y` - год 4 цифры (1970);
* `%m` - месяц 2 цифры (1);
* `%d` - день 2 цифры (1);
* `%H` - час 2 цифры (0);
* `%M` - минуты 2 цифры (0);
* `%S` - секунды (0), может принимать и микросекунды в форматах от xx. до xx.xxxxxx
* `%Z` - IANA имя таймзоны (GMT).

**Примеры**

```sql
$parse1 = DateTime::Parse("%H:%M:%S");
$parse2 = DateTime::Parse("%S");
$parse3 = DateTime::Parse("%m/%d/%Y");
$parse4 = DateTime::Parse("%Z");

SELECT
    DateTime::MakeDatetime($parse1("01:02:03")), -- 1970-01-01T01:02:03Z
    DateTime::MakeTimestamp($parse2("12.3456")), -- 1970-01-01T00:00:12.345600Z
    DateTime::MakeTimestamp($parse3("02/30/2000")); -- NULL (Feb 30)
```

Для распространённых форматов есть врапперы вокруг соответствующих методов util. Можно получить только TM с компонентами в UTC таймзоне.

**Список функций**

* ```DateTime::ParseRfc822(String{Flags:AutoMap}) -> Resource<TM>?```
* ```DateTime::ParseIso8601(String{Flags:AutoMap}) -> Resource<TM>?```
* ```DateTime::ParseHttp(String{Flags:AutoMap}) -> Resource<TM>?```
* ```DateTime::ParseX509(String{Flags:AutoMap}) -> Resource<TM>?```

**Примеры**

```sql
SELECT
    DateTime::MakeTimestamp(DateTime::ParseRfc822("Fri, 4 Mar 2005 19:34:45 EST")), -- 2005-03-05T00:34:45Z
    DateTime::MakeTimestamp(DateTime::ParseIso8601("2009-02-14T02:31:30+0300")), -- 2009-02-13T23:31:30Z
    DateTime::MakeTimestamp(DateTime::ParseHttp("Sunday, 06-Nov-94 08:49:37 GMT")), -- 1994-11-06T08:49:37Z
    DateTime::MakeTimestamp(DateTime::ParseX509("20091014165533Z")); -- 2009-10-14T16:55:33Z
```

