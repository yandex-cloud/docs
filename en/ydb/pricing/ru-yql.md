# Rules for estimating the cost of YQL queries to {{ ydb-short-name }}



Backend resources are used to execute YQL queries. Information about consumed resources is available in the request statistics.

To evaluate the {{ ydb-short-name }} API request cost, the CPU cost and the I/O cost are calculated. A maximum from the calculated values is selected.
* CPU cost.

   The CPU time spent to compile the request is added to the CPU time spent at each step of query execution. This sum is divided by the CPU time increment of 1.5 ms, rounded down and converted to RU based on the service plan from the table below.

   Cached requests aren't recompiled. To use caching, use `bind variables` in your requests and enable caching of the request execution plan.
* I/O cost.

   The following values are calculated:
   * Number of disk reads. The number of read records and data blocks is compared, and the largest of them is selected. The number of blocks is calculated by dividing the amount of bytes read by the block size of 4 KB and rounding the result up.
   * Number of disk writes. The number of written rows and data blocks is compared, and the largest of them is selected. The number of blocks is calculated by dividing the amount of bytes written by a block size of 1 KB and rounding the value up.

   This includes I/O operations on tables and indexes. Row deletes are billed based on their count.

   The number of reads and writes is converted to RU based on the service plan from the table below with the resulting costs summed up.

{% note warning %}

Some row conversions involve data reads or deletes before editing, and this may affect the request cost.

{% endnote %}

Unit costs in RUs:

| Estimated parameter | Cost |
:--- | :---:
| One CPU time increment | 1 RU |
| One read | 1 RU |
| One write | 2 RUs |

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
* `query_phases[].cpu_time_us`: The CPU time used for executing the request, in microseconds.
* `compilation.cpu_time_us`: The CPU time used for compiling the request, in microseconds.
* `process_cpu_time_us`: The CPU time used for interaction control, in microseconds.
* `query_phases[].reads.rows`: The number of data rows read.
* `query_phases[].reads.bytes`: The number of data bytes read.
* `query_phases[].updates.rows`: The number of data rows written.
* `query_phases[].updates.bytes`: The number of data bytes written.

To evaluate the CPU cost, the request's total CPU time is divided by 1.5 ms, `( 475 + 514 + 4062 + 870 ) / 1500 = 3.95`. The result is rounded down and converted to RU:

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
   * 2456 bytes written, `2456 / 1024 = 2.398`, the result is rounded up, the number of operations is 3.

   The number of write operations is 3.

I/O cost:

```text
2 × 1 RU + 3 × 2 RUs = 8 RUs
```

The request cost is 8 RUs.

{% endcut %}
