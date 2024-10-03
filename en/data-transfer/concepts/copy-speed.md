---
title: Speed for copying data in {{ data-transfer-full-name }}
description: The speed for copying data can reach 15 MBps.
---

# Speed for copying data

The speed for copying data can reach 15 MBps. It usually takes 2-3 hours to copy a 100 GB database. The exact time depends on:

* Target and source settings
* Number of [workers and threads](../operations/transfer.md#update-copy-repl)
* [Parallel copy](sharded.md) capabilities of the source
* Connection stability

When you replicate {{ PG }} and {{ MY }} data, the bandwidth may be up to 20-30 thousand write transactions per second.

{% include [speed-degrade](../../_includes/data-transfer/speed-degrade.md) %}