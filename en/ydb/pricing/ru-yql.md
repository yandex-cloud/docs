---
title: Rules for estimating the cost of YQL queries to {{ ydb-full-name }}
description: This article contains rules for estimating the cost of YQL requests to {{ ydb-name }}.
editable: false
---

# Rules for estimating the cost of YQL queries to {{ ydb-short-name }}



To run YQL queries, the system uses backend resources. To view the information about consumed resources, see the relevant request statistics.

To evaluate the {{ ydb-short-name }} API request cost, one needs to calculate the CPU and I/O cost, out of which the largest value is the final one.
* CPU cost:

  The CPU time spent to compile the request is added to the CPU time spent at each step of request execution. This value is then divided by the CPU time increment of 1.5 ms, rounded down, and converted to RUs based on the service plan from the table below.

  Cached requests are not recompiled. For caching, use `bind variables` in your requests and enable caching of the request execution plan.
* I/O cost:

  For the I/O cost, the following values are calculated:
  * Number of disk reads: The number of read records and data blocks is compared, and the largest of them is selected. The number of blocks is calculated by dividing the amount of bytes read by the block size of 4 KB and rounding up the result.
  * Number of disk writes: The number of written rows and data blocks is compared, and the largest of them is selected. The number of blocks is calculated by dividing the amount of bytes written by a block size of 1 KB and rounding up the value.

  This includes I/O operations on tables and indexes. Row deletes are billed based on their count.

  The number of reads and writes is converted to RUs based on the service plan from the table below with the resulting costs summed up.

{% note warning %}

Some row conversions involve data reads or deletes before editing, and this may affect the request cost.

{% endnote %}

Unit costs in RUs:

Value to estimate | Cost
:--- | :---:
One CPU time increment | 1 RU
One read | 1 RU
One write | 2 RUs

The following operations are not billed:
* Creating, updating, and deleting table schemas.
* Getting a description and list of tables.
* Creating and deleting directories.

{% cut "Example of request cost calculation" %}

Request statistics:

```text
query_phases {
  ...
  table_access {
    ...
    reads {
      rows: 2
      bytes: 16
    }
    ...
  }
  cpu_time_us: 475
  ...
}
query_phases {
  ...
  table_access {
    ...
    updates {
      rows: 2
      bytes: 2456
    }
    ...
  }
  cpu_time_us: 514
  ...
}
compilation {
  ...
  cpu_time_us: 4062
}
process_cpu_time_us: 870
```

Where:
* `query_phases[].cpu_time_us`: CPU time used for executing the request, in microseconds.
* `compilation.cpu_time_us`: CPU time used for compiling the request, in microseconds.
* `process_cpu_time_us`: CPU time used for manage interaction, in microseconds.
* `query_phases[].reads.rows`: Number of read data rows.
* `query_phases[].reads.bytes`: Number of read data bytes.
* `query_phases[].updates.rows`: Number of written data rows.
* `query_phases[].updates.bytes`: Number of written data bytes.

To estimate the CPU cost, the request's total CPU time is divided by 1.5 ms, `( 475 + 514 + 4062 + 870 ) / 1500 = 3.95`. The result is rounded down and converted to RUs:

```text
3 × 1 RU = 3 RUs
```

To get the I/O cost:
* The number of disk reads of rows and blocks is calculated, and the maximum is selected:
  * 2 rows read, the number of operations is 2.
  * 16 bytes read, `16 / ( 4 × 1024 ) = 0.004`, the result is rounded up, the number of operations is 1.

  The number of read operations is 2.
* The number of disk writes for rows and blocks is calculated, and the maximum is selected:
  * 2 rows written, the number of operations is 2.
  * 2,456 bytes read, `2456 / 1024 = 2.398`, the result is rounded up, the number of operations is 3.

  The number of write operations is 3.

I/O cost:

```text
2 × 1 RU + 3 × 2 RUs = 8 RUs
```

The request cost is 8 RUs.

{% endcut %}

