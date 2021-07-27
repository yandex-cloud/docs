---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# DateTime UDF

In the DateTime module, the main internal representation format is `Resource<TM>` that stores the following date components:

* Year (12 bits).
* Month (4 bits).
* Day (5 bits).
* Hour (5 bits).
* Minute (6 bits).
* Second (6 bits).
* Microsecond (20 bits).
* TimezoneId (16 bits).
* DayOfYear (9 bits): Day since the beginning of the year.
* WeekOfYear (6 bits): Week since the beginning of the year, January 1 is always in week 1.
* DayOfWeek (3 bits): Day of the week.

If the timezone is not GMT, the components store the local time for the relevant timezone.

## Split {#split}

Conversion from a primitive type to an internal representation. It's always successful on a non-empty input.

**List of functions**

* ```DateTime::Split(Date{Flags:AutoMap}) -> Resource<TM>```
* ```DateTime::Split(Datetime{Flags:AutoMap}) -> Resource<TM>```
* ```DateTime::Split(Timestamp{Flags:AutoMap}) -> Resource<TM>```

The functions that accept the `Resource<TM>` input, can be called directly from the primitive date/time type. An implicit conversion will be made in this case by calling a relevant `Split` function.

## Make... {#make}

Making a primitive type from an internal representation. It's always successful on a non-empty input.

**List of functions**

* ```DateTime::MakeDate(Resource<TM>{Flags:AutoMap}) -> Date```
* ```DateTime::MakeDatetime(Resource<TM>{Flags:AutoMap}) -> Datetime```
* ```DateTime::MakeTimestamp(Resource<TM>{Flags:AutoMap}) -> Timestamp```

**Examples**

```sql
SELECT
    DateTime::MakeTimestamp(DateTime::Split(Datetime("2019-01-01T15:30:00Z"))), -- 2019-01-01T15:30:00.000000Z
    DateTime::MakeDate(Datetime("2019-01-01T15:30:00Z")); -- 2019-01-01
```

## Get... {#get}

Extracting a component from an internal representation.

**List of functions**

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

**Examples**

```sql
$tm = DateTime::Split(Datetime("2019-01-09T00:00:00Z"));

SELECT
    DateTime::GetDayOfMonth($tm) as Day, -- 9
    DateTime::GetMonthName($tm) as Month, -- "January"
    DateTime::GetYear($tm) as Year, -- 2019
    DateTime::GetDayOfWeekName($tm) as WeekDay; -- "Wednesday"
```

## Update {#update}

Updating one or more components in the internal representation. Returns either an updated copy or NULL, if an update produces an invalid date or other inconsistencies.

**List of functions**

* ```DateTime::Update(Resource<TM>{Flags:AutoMap}, [Year:Uint16?, Month:Uint8?, Day:Uint8?, Hour:Uint8?, Minute:Uint8?, Second:Uint8?, Microsecond:Uint32?]) -> Resource<TM>?```

**Examples**

```sql
$tm = DateTime::Split(Timestamp("2019-01-01T01:02:03.456789Z"));

SELECT
    DateTime::MakeDate(DateTime::Update($tm, 2012)), -- 2012-01-01
    DateTime::MakeDate(DateTime::Update($tm, 2000, 6, 6)), -- 2000-06-06
    DateTime::MakeDate(DateTime::Update($tm, NULL, 2, 30)), -- NULL (February 30)
    DateTime::MakeDatetime(DateTime::Update($tm, NULL, NULL, 31)), -- 2019-01-31T01:02:03Z
    DateTime::MakeDatetime(DateTime::Update($tm, 15 as Hour, 30 as Minute)), -- 2019-01-01T15:30:03Z
    DateTime::MakeTimestamp(DateTime::Update($tm, 999999 as Microsecond)); -- 2019-01-01T01:02:03.999999Z
```

## From... / To... / Interval... {#from-to-interva;}

Getting a Timestamp from the number of seconds/milliseconds/microseconds since the Epoch.

**List of functions**

* ```DateTime::FromSeconds(Uint32{Flags:AutoMap}) -> Timestamp```
* ```DateTime::FromMilliseconds(Uint64{Flags:AutoMap}) -> Timestamp```
* ```DateTime::FromMicroseconds(Uint64{Flags:AutoMap}) -> Timestamp```

Getting a number of seconds/milliseconds/microseconds since the Epoch from a primitive type.

**List of functions**

* ```DateTime::ToSeconds(Date/DateTime/Timestamp{Flags:AutoMap}) -> Uint32```
* ```DateTime::ToMilliseconds(Date/DateTime/Timestamp{Flags:AutoMap}) -> Uint64```
* ```DateTime::ToMicroseconds(Date/DateTime/Timestamp{Flags:AutoMap}) -> Uint64```

**Examples**

```sql
SELECT
    DateTime::FromSeconds(1546304523), -- 2019-01-01T01:02:03.000000Z
    DateTime::ToMicroseconds(Timestamp("2019-01-01T01:02:03.456789Z")); -- 1546304523456789
```

Conversions between ```Interval``` and various time units.

**List of functions**

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

**Examples**

```sql
SELECT
    DateTime::ToDays(Interval("PT3000M")), -- 2
    DateTime::IntervalFromSeconds(1000000); -- 11 days 13 hours 46 minutes 40 seconds
```

## Format {#format}

Get a string representation of a time using an arbitrary formatting string.

**List of functions**

* ```DateTime::Format(String) -> (Resource<TM>{Flags:AutoMap}) -> String```

A subset of specifiers similar to strptime is implemented for the formatting string.

* `%%`: % character.
* `%Y`: 4-digit year.
* `%m`: 2-digit month.
* `%d`: 2-digit day.
* `%H`: 2-digit hour.
* `%M`: 2-digit minutes.
* `%S`: 2-digit seconds  -- or xx.xxxxxx  in the case of non-empty microseconds.
* `%z`: +hhmm or -hhmm.
* `%Z`: The IANA name of the timezone.

All other characters in the format string are passed on without changes.

**Examples**

```sql
$format = DateTime::Format("%Y-%m-%d %H:%M:%S %Z");

SELECT
    $format(DateTime::Split(Datetime("2019-01-01T01:02:03Z"))); -- "2019-01-01 01:02:03 GMT"
```

## Parse {#parse}

Parse a string into an internal representation using an arbitrary formatting string. Default values are used for empty fields. If errors are raised, NULL is returned.

**List of functions**

* ```DateTime::Parse(String) -> (String{Flags:AutoMap}) -> Resource<TM>?```

Implemented specifiers:

* `%%`: % character.
* `%Y`: 4-digit year (1970).
* `%m`: 2-digit month (1).
* `%d`: 2-digit day (1).
* `%H`: 2-digit hour (0).
* `%M`: 2-digit minutes (0).
* `%S`: Seconds (0), can also accept microseconds in the formats from xx. up to xx.xxxxxx
* `%Z`: The IANA name of the timezone (GMT).

**Examples**

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

For the common formats, wrappers around the corresponding util methods are supported. You can only get TM with components in the UTC timezone.

**List of functions**

* ```DateTime::ParseRfc822(String{Flags:AutoMap}) -> Resource<TM>?```
* ```DateTime::ParseIso8601(String{Flags:AutoMap}) -> Resource<TM>?```
* ```DateTime::ParseHttp(String{Flags:AutoMap}) -> Resource<TM>?```
* ```DateTime::ParseX509(String{Flags:AutoMap}) -> Resource<TM>?```

**Examples**

```sql
SELECT
    DateTime::MakeTimestamp(DateTime::ParseRfc822("Fri, 4 Mar 2005 19:34:45 EST")), -- 2005-03-05T00:34:45Z
    DateTime::MakeTimestamp(DateTime::ParseIso8601("2009-02-14T02:31:30+0300")), -- 2009-02-13T23:31:30Z
    DateTime::MakeTimestamp(DateTime::ParseHttp("Sunday, 06-Nov-94 08:49:37 GMT")), -- 1994-11-06T08:49:37Z
    DateTime::MakeTimestamp(DateTime::ParseX509("20091014165533Z")); -- 2009-10-14T16:55:33Z
```

