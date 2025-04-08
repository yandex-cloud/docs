---
title: Индексы в {{ PG }}
description: Что такое индексы в {{ PG }}, почему они могут разрастаться и как pg_repack помогает решить эту проблему.
---

# Индексы в {{ PG }}

Индекс в базе данных представляет собой вспомогательную структуру для ускорения поиска данных в таблице. Принцип работы аналогичен алфавитному указателю, обеспечивающему быстрый доступ к необходимой информации.

В реляционных базах данных, таких как {{ PG }}, данные хранятся в связанных таблицах. Пример структуры базы данных:

```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    stock_quantity INTEGER,
    category_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Индекс для быстрого поиска по названию товара
CREATE INDEX idx_products_name ON products(name);
```

При выполнении поисковых запросов без индекса требуется полное сканирование таблицы, что занимает `O(n)` операций, а поиск с индексом — `O(log n)`.

## Специализированные индексы {#specialized-indexes}

{{ PG }} поддерживает различные типы индексов для оптимизации специфических операций:

```sql
CREATE TABLE pickup_points (
    id SERIAL PRIMARY KEY,
    address TEXT,
    coordinates POINT,
    working_hours JSONB,
    current_load INTEGER,
    updated_at TIMESTAMP
);

-- Индекс B-tree
CREATE INDEX idx_pickup_basic ON pickup_points(id);

-- Индекс GiST для геоданных
CREATE INDEX idx_pickup_location ON pickup_points USING gist(coordinates);

-- Индекс BRIN для временных данных
CREATE INDEX idx_pickup_load_history ON pickup_points USING brin(updated_at)
WHERE current_load IS NOT NULL;
```

Пример комплексного запроса с использованием различных индексов:

```sql
SELECT p.*, 
       p.coordinates <-> POINT(37.5, 55.7) as distance,
       i.quantity as items_available
FROM pickup_points p
JOIN inventory i ON i.pickup_point_id = p.id
WHERE i.product_id = 12345
  AND p.current_load < 80
  AND p.coordinates <@ circle '((37.5, 55.7), 5000)'
ORDER BY distance
LIMIT 5;
```

Подробнее о типах индексов см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/indexes-types.html).

## Разрастание индексов {#index-bloating}

Обновление данных в {{ PG }} требует обновления всех связанных индексов. При интенсивном обновлении данных индексы увеличиваются в размере: неактуальные версии сохраняются в индексе до выполнения операций обслуживания.

Пример операции обновления:

```sql
-- Обновление создает новые версии в индексах
UPDATE products 
SET price = price * 0.8, 
    updated_at = CURRENT_TIMESTAMP 
WHERE category_id = 5;
```

Разрастание индексов является критической проблемой производительности {{ PG }}. При обработке большого количества транзакций снижение производительности базы данных может существенно влиять на работу системы, особенно в периоды пиковых нагрузок.

### Сценарии разрастания {#bloat-scenarios}

Пример структуры данных с множественными индексами:

```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    pickup_point_id INTEGER,
    status VARCHAR(50),
    items JSONB,
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(status, created_at);
CREATE INDEX idx_orders_pickup ON orders(pickup_point_id, status);
```

Операции, приводящие к разрастанию индексов:

```sql
-- Обновление статуса заказа
UPDATE orders 
SET status = 'ready_for_pickup',
    updated_at = CURRENT_TIMESTAMP
WHERE pickup_point_id = 123 
  AND status = 'processing';

-- Массовое обновление статусов
UPDATE orders 
SET status = 'archived'
WHERE created_at < NOW() - INTERVAL '3 months' 
  AND status = 'completed';
```

### Встроенный механизм обслуживания {#reindex}

Стандартный метод обслуживания индексов использует команду `REINDEX`:

```sql
REINDEX INDEX idx_orders_status;
```

Эта операция требует блокировки таблицы, что может быть неприемлемо при высокой нагрузке.

### Расширение pg_repack {#pg-repack}

Расширение [pg_repack](https://github.com/reorg/pg_repack) обеспечивает реорганизацию таблиц и индексов без длительных блокировок. О том, как установить и запустить `pg_repack` в кластере {{ mpg-name }}, см. в разделе [Использование pg_repack](../operations/extensions/pg_repack.md).
