---
title: Cache invalidation in {{ datalens-full-name }}
description: Follow this guide to learn how to use and configure cache invalidation in {{ datalens-full-name }}.
---

# Cache invalidation in {{ datalens-full-name }}

{{ datalens-short-name }} caches query results from data sources to accelerate chart and dashboard rendering. By default, the cache refreshes only after its TTL expires. This may become a constraint if you need real-time visibility, as your data will update regularly but infrequently.

Here is how cache invalidation solves this issue: the system runs an occasional _invalidation query_ against the data source to check if the data has changed. If the query returns a different result, the cache refreshes immediately without waiting for TTL expiration.

## Invalidation stages {#stages}

The invalidation query must be optimized to run fast on the target database.

The system runs the invalidation query at a configured interval ([throttling](#throttling-and-coordination)), while the primary data query runs only when data actually changes or the cache TTL expires:

1. The user configures the invalidation query in the dataset using either SQL or a formula with filters. You can only define one such query for a dataset, provided the dataset has been saved at least once.
1. Upon each data query, the system checks the invalidation cache first.
1. If the invalidation cache is stale, i.e., the throttling interval has elapsed, the system runs the invalidation query against the database.
1. The query returns a short string, such as `"2024-01-15T10:30:00"`.
1. This result is appended to the key of the main data cache.
1. When the query returns a different output or the cache TTL expires, the cache key changes, and fresh data is fetched.

## Typical use cases {#use-cases}

* **Table with an `updated_at` column**: Use the `SELECT MAX(updated_at)::text FROM orders` invalidation query to track the latest update timestamp.
* **Table with an auto-incrementing ID**: Use the `SELECT MAX(id)::text FROM events` query to detect new records.
* **Versioned table**: Use the `SELECT version::text FROM metadata WHERE table_name = 'orders'` query to monitor the data version.

## Throttling and coordination {#throttling-and-coordination}

_Throttling_ defines the minimum interval (`N` seconds) between invalidation queries. For example, with a value of `60`, the query runs at most once per minute, even if the data is queried `1 000` times within that window. Until this interval elapses, subsequent queries reuse the cached invalidation query result.

## Invalidation modes {#modes}

The following modes are available:

* **None**: Disables cache invalidation. The cache refreshes only upon TTL expiration. This is the default behavior.
* **SQL**: The user provides a custom SQL query to run directly against the data source.

  Requirements:

  * The connection must support subqueries.
  * The SQL query must not be empty.
  * The result must meet these [criteria](#result-requirements).

* **Formula**: The user defines a {{ datalens-short-name }} formula (same as with calculated fields) and optional filters. The system compiles and executes the formula through the standard {{ datalens-short-name }} query pipeline.

  Requirements:

  * The formula cannot be empty.
  * The formula must return a string value.
  * The result must meet these [criteria](#result-requirements).

  The `Formula` mode is convenient because it leverages native {{ datalens-short-name }} tools (formulas and filters), so you do not need to know the SQL dialect of your specific database.

## Requirements to the invalidation query result {#result-requirements}

The invalidation query (SQL or formula) must return a result that meets the following conditions:

1. The query must return exactly one row and one column.
1. The value must be a string.
1. The string length cannot exceed `100` characters.

## Setting up cache validation {#test-setting}

To configure cache validation in a dataset:

1. In your dataset's connection settings, go to **Caching settings**, enable **Allow cache validation in datasets** and set the cache refresh interval: **max every** `N` **seconds**. Acceptable values range from `30` to `86 400` seconds.

   {% note info %}

   For the `SQL` invalidation mode, enable **Raw SQL level**.

   {% endnote %}

1. Open the dataset you want to configure cache validation for.
1. Go to the **Cache validation** tab.
1. Select an invalidation mode and configure validation settings:

   {% list tabs %}

   - None

     No invalidation. The cache refreshes only upon TTL expiration. This is the default behavior.

   - Formula
     
     1. Next to the **Formula** field, click ![image](../../_assets/console-icons/plus.svg) **Add** and enter a {{ datalens-short-name }} formula following these requirements:
       
        * The formula cannot be empty.
        * The formula must return a string value.
        * The result must meet these [criteria](#result-requirements).

     1. Optionally, at the bottom left, click **Check result** or skip this step to check the result later.
     1. Click **Save**.
     1. Optionally, next to the **Filtering** field, click ![image](../../_assets/console-icons/plus.svg) **Add** and define the filtering conditions.

   - SQL
     
     1. Next to the **SQL query** field, click ![image](../../_assets/console-icons/plus.svg) **Add** and enter the query text by following these requirements:
       
        * The connection must support subqueries.
        * The SQL query must not be empty.
        * The result must meet these [criteria](#result-requirements).

     1. Optionally, at the bottom left, click **Check result** or skip this step to check the result later.
     1. Click **Save**.

   {% endlist %}

1. Click **Check result** (unavailable in **None** mode) and verify that the output meets the [requirements](#result-requirements).
1. In the top-right corner of the dataset edit window, click **Save**.

## Invalidation testing {#testing}

Invalidation query testing does not affect the main cache and ignores throttling. It is intended strictly for debugging to verify that the query runs correctly and returns the expected result.


This feature is only available to users with [edit](../security/manage-access.md#permission-write) permissions for the dataset to prevent data leakage via RLS.


To run an invalidation test:

1. Open the dataset you want to test.
1. Go to the **Cache validation** tab.
1. Click **Check result** and make sure the result meets [these requirements](#result-requirements).

## Last invalidation result {#last-result}

Viewing the last validation result does not trigger new database queries. The available data includes the most recent query output and query timestamp.


This option is only available to users with [edit](../security/manage-access.md#permission-write) permissions for the dataset.


The result may be either the returned string or an execution error. An error may also indicate an empty result, e.g., if the throttling interval has elapsed but the query has not run.

To view the last validation result:

1. Open the dataset you want to test.
1. Go to the **Cache validation** tab. Next to the **Last result** field, you can see the date and time of the most recent check. If the check failed, you will see `Failed with error` next to **Last result**.
1. Click **Open** to view the check result, or **Show error** to see the error message.

## Error handling {#errors}

The invalidation system follows the *graceful degradation* design principle: invalidation errors never block main data queries.

If invalidation is misconfigured, charts and dashboards will continue to render normally, and the cache will refresh based on its TTL as if invalidation is disabled. Error indicators will flag the affected charts and datasets, and full error details will be available in the [Last result](#last-result) dataset field.

## Limits {#restrictions}

* Invalidation query timeout is `20` seconds.
* The maximum result length is `100` characters.
* The result must contain exactly `1` row.
* The result must contain exactly `1` column.
* The result data type must be a string.
