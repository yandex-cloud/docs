---
editable: false
---

{% if audience != "internal" %}

# Квоты и лимиты в {{ mgp-name }}

В сервисе {{ mgp-name }} действуют следующие ограничения:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [mgp-limits](../../_includes/mdb/mgp/limits.md) %}

{% else %}

# Технические ограничения {{ mgp-name }}

| Вид ограничения                           | Значение             |
|-------------------------------------------|----------------------|
| Минимальное число ядер                    | 4                    |
| Минимальное количество RAM                | 16 ГБ                |
| Максимальное число ядер                   | 64 (s3.6xlarge)      |
| Максимальное количество RAM               | 384 ГБ (m3.11xlarge) |
| Максимальное количество хостов-мастеров   | 2                    |
| Максимальное количество хостов-сегментов  | 32                   |
| Максимальный объем хранилища одного хоста | 4096 ГБ              |

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
