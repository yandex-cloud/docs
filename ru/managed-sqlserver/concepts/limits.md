---
editable: false
---

{% if audience != "internal" %}

# Квоты и лимиты

В сервисе {{ mms-name }} действуют следующие ограничения:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mms-limits.md](../../_includes/mdb/mms-limits.md) %}

{% else %}

# Технические ограничения {{ mms-name }}

Вид ограничения | Значение
----- | -----
Минимальный класс хоста | s2.nano (1 vCPU, 4 ГБ оперативной памяти)
Максимальный класс хоста | s3.6xlarge (64 vCPU, 256 ГБ оперативной памяти)
Максимальное количество хостов в одном кластере {{ MS }} | 7
Максимальный объем хранилища для кластера {{ MS }} | 4096 ГБ

{% endif %}
