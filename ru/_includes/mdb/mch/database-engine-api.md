* `DATABASE_ENGINE_ATOMIC` (по умолчанию) — движок Atomic. Поддерживает неблокирующие операции `DROP TABLE` и `RENAME TABLE`, а также атомарные операции `EXCHANGE TABLES`.
* `DATABASE_ENGINE_REPLICATED` — движок Replicated. Поддерживает репликацию метаданных таблиц между всеми репликами базы данных. При этом набор таблиц и их схемы будут одинаковыми для всех реплик.
                    
  {% include [replicated-claster-engine](replicated-claster-engine.md) %}

* `DATABASE_ENGINE_UNSPECIFIED` — для этого значения будет выбран движок по умолчанию `DATABASE_ENGINE_ATOMIC`.
                    
{% include [set-engine](set-engine.md) %}