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
