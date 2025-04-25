---
title: Indexes in {{ PG }}
description: Learn about indexes in {{ PG }}, why they may get bloated, and how to trobleshoot this with pg_repack.
---

# Indexes in {{ PG }}

A database index is an auxiliary structure that helps you find data in tables faster. It works in the same way as an alphabetic index for quick access to the information you need.

In relational databases such as {{ PG }}, data is stored in linked tables. Here is an example of database structure:

```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    stock_quantity INTEGER,
    category_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--  Index for quick search by product name
CREATE INDEX idx_products_name ON products(name);
```

When running search queries without an index, the entire table has to be scanned, which requires `O(n)` operations, while a search with an index needs `O(log n)` operations.

## Specialized indexes {#specialized-indexes}

{{ PG }} supports various index types to optimize specific operations:

```sql
CREATE TABLE pickup_points (
    id SERIAL PRIMARY KEY,
    address TEXT,
    coordinates POINT,
    working_hours JSONB,
    current_load INTEGER,
    updated_at TIMESTAMP
);

-- B-tree index
CREATE INDEX idx_pickup_basic ON pickup_points(id);

-- GiST index for geodata
CREATE INDEX idx_pickup_location ON pickup_points USING gist(coordinates);

-- BRIN index for temporary data
CREATE INDEX idx_pickup_load_history ON pickup_points USING brin(updated_at)
WHERE current_load IS NOT NULL;
```

Example of a complex query using various indexes:

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

For more information about index types, see [{{ PG }}](https://www.postgresql.org/docs/current/indexes-types.html).

## Index bloating {#index-bloating}

Updating data in {{ PG }} requires updating all related indexes. With intensive data updates, indexes grow in size since outdated data versions remains in the index until maintenance operations are complete.

Example of an update operation:

```sql
-- Updating creates new versions in indexes
UPDATE products 
SET price = price * 0.8, 
    updated_at = CURRENT_TIMESTAMP 
WHERE category_id = 5;
```

Index bloating is a critical performance issue in {{ PG }}. When processing a high number of transactions, degraded database performance can severely disrupt the system, especially during peak load periods.

### Bloating scenarios {#bloat-scenarios}

Here is an example of a data structure with multiple indexes:

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

Operations that cause index bloating:

```sql
-- Order status update
UPDATE orders 
SET status = 'ready_for_pickup',
    updated_at = CURRENT_TIMESTAMP
WHERE pickup_point_id = 123 
  AND status = 'processing';

-- Bulk status updates
UPDATE orders 
SET status = 'archived'
WHERE created_at < NOW() - INTERVAL '3 months' 
  AND status = 'completed';
```

### Native maintenance {#reindex}

The standard index maintenance method uses the `REINDEX` command:

```sql
REINDEX INDEX idx_orders_status;
```

This operation requires a table lock, which may be impossible under high loads.

### pg_repack extension {#pg-repack}

The [pg_repack](https://github.com/reorg/pg_repack) extension reorganizes tables and indexes without long-term locks. To learn how to update and run `pg_repack` in a {{ mpg-name }} cluster, see [Using pg_repack](../operations/extensions/pg_repack.md).
