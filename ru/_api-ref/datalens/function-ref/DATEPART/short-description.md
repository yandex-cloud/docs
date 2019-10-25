**Синтаксис:**`DATEPART( datetime, unit [ , firstday ] )`

Возвращает часть даты в виде целого числа.

В зависимости от аргумента `unit` возвращает следующие значения:
- `"year"` — номер года (см. [YEAR](../YEAR/short-description.md)),
- `"month"` — номер месяца в году (см. [MONTH](../MONTH/short-description.md)),
- `"week"` — номер недели в году по [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) (см. [WEEK](../WEEK/short-description.md)),
- `"dayofweek"`, `"dow"` — номер дня недели (см. [DAYOFWEEK](../DAYOFWEEK/short-description.md)),
- `"day"` — номер дня в месяце (см. [DAY](../DAY/short-description.md)),
- `"hour"` — номер часа в дне (см. [HOUR](../HOUR/short-description.md)),
- `"minute"` — номер минуты в часе (см. [MINUTE](../MINUTE/short-description.md)),
- `"second"` — номер секунды в минуте (см. [SECOND](../SECOND/short-description.md)).

Если выбран "`dayofweek`", то дополнительным параметром `firstday` можно задать, какой день недели считать первым — по умолчанию это понедельник. Более подробно об этом параметре смотрите в описании функции [DAYOFWEEK](../DAYOFWEEK/short-description.md)
