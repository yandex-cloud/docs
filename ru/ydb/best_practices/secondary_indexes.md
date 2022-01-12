---
sourcePath: overlay/best_practices/secondary_indexes.md
---

{% include [secondary_indexes.md](_includes/secondary_indexes.md) %}

{% if audience == "internal" or audience == "tech" %}

В примере используется схема данных, описанная в документе [Начало работы — Работа со схемой](../getting_started/start_scheme.md).
Чтобы хранить количество просмотров, в таблицу  `series` для каждого сериала добавлено поле `views` типа `Uint64`.

{% endif %}
