**Синтаксис:**`DATEPART( datetime, unit [ , firstday ] )`

Возвращает часть даты в виде целого числа.

В зависимости от аргумента `datetime` возвращает следующие значения:
- `"year"` — номер года (см. [YEAR](../../date/YEAR/overview.md)),
- `"month"` — номер месяца в году (см. [MONTH](../../date/MONTH/overview.md)),
- `"week"` — номер недели в году по [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) (см. [WEEK](../../date/WEEK/overview.md)),
- `"dayofweek"`, `"dow"` — номер дня недели (см. [DAYOFWEEK](../../date/DAYOFWEEK/overview.md)),
- `"day"` — номер месяца в году (см. [DAY](../../date/DAY/overview.md)),
- `"hour"` — номер часа в дне (см. [HOUR](../../date/HOUR/overview.md)),
- `"minute"` — номер минуты в часе (см. [MINUTE](../../date/MINUTE/overview.md)),
- `"second"` — номер секунды в минуте (см. [SECOND](../../date/SECOND/overview.md)).

Если выбран "`dayofweek`", то дполнительным параметром `firstday` можно задать, какой день недели считать первым - по умолчанию это понедельник.Более подробно об этом параметре смотрите в описании функции [DAYOFWEEK](../../date/DAYOFWEEK/overview.md)
