---
title: Comparing {{ MY }} 5.7 and {{ MY }} 8.0 in {{ yandex-cloud }}
description: Overview of the key differences and advantages of {{ MY }} 8.0 compared to {{ MY }} 5.7 in {{ mmy-full-name }}.
---

# Comparing {{ MY }} 5.7 and 8.0

{{ MY }} 8.0 is a major update compared to {{ MY }} 5.7, released almost ten years ago. This version offers significant improvements in the DBMS architecture and functionality.

## Transactional data dictionary {#data-dictionary}

{{ MY }} 8.0 has replaced the separate `.frm` file-based metadata storage system with the unified transactional data dictionary. 

Advantages of the new approach:

* Eliminates the metadata desynchronization issues in case of faults.
* No locks when executing DDL operations.
* Optimized table structure modification without long-term locks.
* More reliable database structure backup and restore operations.

## Security {#security}

{{ MY }} 8.0 implements improved security mechanisms.

Key improvements:

* `caching_sha2_password` instead of `mysql_native_password` as the default mechanism.
* Improved password storage system.
* Advanced protection against modern attack vectors.
* Backward compatibility with previous authentication mechanisms.

## SQL features {#sql-features}

* {{ MY }} 8.0 provides built-in support of window functions to facilitate complex computations:

   ```sql
   SELECT
       sale_date,
       product_id,
       sales_amount,
       ROUND(AVG(sales_amount) OVER (
           ORDER BY sale_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ), 2) as moving_average_3days
   FROM daily_sales;
   ```

* {{ MY }} 8.0 implements Common Table Expressions (CTE), which allows you to create better structured queries:

   ```sql
   WITH customer_totals AS (
       SELECT
           customer_id,
           region,
           SUM(order_amount) as total_spent
       FROM orders
       GROUP BY customer_id, region
   )
   SELECT * FROM customer_totals;
   ```

## Working with JSON {#json}

{{ MY }} 8.0 offers advanced features for working with JSON data:

* Creating indexes:

   ```sql
   ALTER TABLE users
   ADD INDEX idx_profile_age ((CAST(profile->>'$.age' AS UNSIGNED)));
   ```

* Optimized syntax for JSON:

   ```sql
   -- Value extraction
   SELECT 
       id,
       profile->>'$.name' as name,
       profile->>'$.contacts.email' as email
   FROM users;
   ```

## Additional features {#additional-features}

New features in {{ MY }} 8.0:

* Invisible indexes for testing index structures in the production environment.
* `EXPLAIN ANALYZE` for analyzing actual query plans.
* Optimized metadata processing system to reduce the number of locks.

## Performance {#performance}

{{ MY }} 8.0 performance test results:

* Single-host configurations demonstrate higher performance with {{ MY }} 5.7.
* Multi-host configurations show improved stability with {{ MY }} 8.0.

The choice of version depends on your specific performance requirements.

## Upgrading to {{ MY }} 8.0 {#upgrade}

Starting October 2023, official support of {{ MY }} 5.7 has been discontinued. Advantages of upgrading to {{ MY }} 8.0:

* Access to new features and improved security mechanisms.
* {{ yandex-cloud }} migration tools.
* Long-term support of the new version.

For more details about migration, see [{{ MY }} version upgrade](../operations/cluster-version-update.md).
