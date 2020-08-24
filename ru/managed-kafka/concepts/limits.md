---
editable: false
---

{% if audience != "internal" %}

# Квоты и лимиты

В сервисе {{ mkf-name }} действуют следующие ограничения:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mkf-limits.md](../../_includes/mdb/mkf-limits.md) %}

{% else %}

# Технические ограничения {{ mkf-name }}

Вид ограничения | Значение
----- | -----
Минимальный класс хоста | s2.micro (1 vCPU, 4 ГБ оперативной памяти)
Максимальный класс хоста | s3.6xlarge (64 vCPU, 256 ГБ оперативной памяти)
Максимальное количество хостов в одном кластере {{ KF }} | 7
Максимальный объем хранилища для кластера {{ KF }} | 4096 ГБ

{% endif %}
