* `planned-usage-threshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее [окно обслуживания](../../../managed-redis/concepts/maintenance.md#maintenance-window).

  Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

  Если вы задали этот параметр, [настройте](../../../managed-redis/operations/update.md#change-additional-settings) расписание технического обслуживания.

* `emergency-usage-threshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.

  Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

  {% note warning %}

  Если заданы оба порога, значение `emergency-usage-threshold` должно быть не меньше `planned-usage-threshold`.

  {% endnote %}

* `disk-size-limit` — максимальный размер хранилища в гигабайтах после увеличения.



{% include [warn-storage-resize](warn-storage-resize.md) %}
