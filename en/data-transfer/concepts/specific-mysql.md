---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# MySQL specifics

{% include [features](../../_includes/data-transfer/features-of-work.md) %}

1. Make sure that full binary log mode is enabled for the source database.
1. Working with constraints (`CONSTRAINT`).
   * Constraints (`CONSTRAINT`) are enabled on the target by default. This is taken into account during the transfer. For large databases, this can significantly affect replication performance.
   * At the transfer level, you can disable `CONSTRAINT` to regain performance. However, the behavior may vary depending on the low-level data storage subsystem: unlike [MyISAM](https://en.wikipedia.org/wiki/MyISAM), we can't guarantee cascade delete for [InnoDB](https://en.wikipedia.org/wiki/InnoDB).
1. Only the MyISAM and InnoDB low-level storage subsystems are tested regularly. We don't guarantee that the other low-level storage subsystems will behave properly.
1. Running the `ALTER` operators:
   * In some cases, such operators may slow down replication, but the performance usually recovers after a while.
   * If you perform complex manipulations that involve changing the schema on the source, run explicit checks on the target database.
1. You can change the limit on the size of the chunk sent using the `max_allowed_packet` parameter.
1. [SQL mode](https://dev.mysql.com/doc/mysql-replication-excerpt/5.6/en/replication-features-sql-mode.html) must be the same on the source and target.

The transfer checks this requirement and, if any discrepancy is found, requests administrator intervention.

