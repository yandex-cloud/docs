* **Audit level**{#audti-level} {{ tag-con }} {{ tag-api }}

  Describes how to configure login auditing to monitor SQL Server Database Engine login activity.

  Possible values:
  - `0`: Do not log login attempts (default).
  - `1`: Log only failed login attempts.
  - `2`: Log only successful login attempts (not recommended).
  - `3`: Log all login attempts (not recommended).

  For more information, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016).

* **Cost threshold for parallelism**{#setting-cost-threshold} {{ tag-con }} {{ tag-api }}

  Specifies the threshold at which {{ MS }} creates and runs parallel plans for queries. This process starts only when the estimated cost to run a serial plan for the same query is higher than the value of the parameter.

  Acceptable values: from `0` to `32767` inclusive. The default value is `5`.

  For more information, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016).

* **Fill factor percent**{#setting-fill-factor} {{ tag-con }} {{ tag-api }}

  Sets the [fill factor for the index](https://docs.microsoft.com/en-us/sql/relational-databases/indexes/specify-fill-factor-for-an-index?view=sql-server-2016). This factor determines the percentage of space on each index leaf-level page when the index is created or rebuilt. The remaining space is reserved as free space.

  Acceptable values: from `0` to `100` inclusive. The default value is `0`.

  The values `0` and `100` mean fully filled pages (no space is reserved).

  For more information, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016).

* **Max degree of parallelism**{#setting-mark-cache-size} {{ tag-con }} {{ tag-api }}

  Limits the number of CPUs to use in parallel plan execution per query.

  Acceptable values: from `0` to `32767` inclusive. The default value is `0` (all of the processors available are used).

  For more information, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016).

* **Optimize for ad hoc workloads**{#setting-ad-hoc-workloads} {{ tag-con }} {{ tag-api }}

  Enables caching of query plans only after the second execution. Helps avoid SQL cache bloat because of single-use plans.

  This setting is disabled by default.

  For more information, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016).

