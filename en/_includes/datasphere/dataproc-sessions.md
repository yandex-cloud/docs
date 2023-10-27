In {{ dataproc-name }} clusters, your code is running in [sessions](https://livy.incubator.apache.org/docs/latest/rest-api.html#session). A session stores the intermediate state until you delete the session or cluster. Each cluster has a default session. Its ID is the same as the project ID.

Use the following commands to manage sessions:
* `%create_livy_session --cluster <cluster name> --id <session ID>` to create a session.
* `%delete_livy_session --cluster <cluster name> --id <session ID>` to delete a session.

For example, the command below creates a session named `ses1` in `my-new-cluster`, which allows each process to use a maximum of 4 CPUs per cluster and 4 GB of RAM (for more information, see the [Spark documentation](https://spark.apache.org/docs/latest/configuration.html)):

```python
%create_livy_session --cluster my-new-cluster --id ses1 --conf spark.cores.max=4 --conf spark.executor.memory=4g
```

Dynamic resource allocation is enabled in sessions by default. To limit session resources, set `--conf spark.dynamicAllocation.enabled` to `false`.

For a full list of livy session parameters, see the [official documentation](https://livy.incubator.apache.org/docs/latest/rest-api.html).
