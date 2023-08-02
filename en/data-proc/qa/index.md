---
title: "{{ dataproc-full-name }}. Questions and answers"
description: "How do I get the logs of my activity in {{ dataproc-full-name }}? Find the answer to this and other questions in this article."
---

# General questions about {{ dataproc-name }}

#### What do I do if data on storage subcluster hosts is distributed unevenly?

[Connect](../operations/connect.md) to the cluster master host and run the command to rebalance the data:

```bash
sudo -u hdfs hdfs balancer
```

You can configure the load balancer parameters. For example, to change the maximum amount of data to transfer, add the `-D dfs.balancer.max-size-to-move=<data-size-in-bytes>` argument.


{% include [logs](../../_qa/logs.md) %}

#### Why is a cluster working slowly even though it still has free computing resources? {#throttling}

{% include [throttling](../../_qa/throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, consider switching to a different cluster with larger host storage or a faster disk type. You can transfer data to a new cluster, for example, using [{{ metastore-full-name }}](../concepts/metastore.md).
