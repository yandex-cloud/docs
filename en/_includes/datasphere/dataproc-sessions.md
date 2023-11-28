In {{ dataproc-name }} clusters, your code is running in [sessions](https://livy.incubator.apache.org/docs/latest/rest-api.html#session). A session stores the intermediate state until you delete the session or cluster. Each cluster has a default session. Its ID is the same as the project ID.

Use the following commands to manage sessions:
* `%create_livy_session --cluster <cluster name> --id <session ID>` to create a session.
* `%delete_livy_session --cluster <cluster name> --id <session ID>` to delete a session.

For example, the command below creates a session named `ses1` in `my-new-cluster`, which allows each process to use a maximum of 4 CPUs per cluster and 4 GB of RAM (for more information, see the [Spark documentation](https://spark.apache.org/docs/latest/configuration.html)):

```python
%create_livy_session --cluster my-new-cluster --id ses1 --conf spark.cores.max=4 --conf spark.executor.memory=4g
```

Dynamic resource allocation is enabled in sessions by default. To limit session resources, set `--conf spark.dynamicAllocation.enabled` to `false`.

## Livy session parameters {#parameters}

Complete list of parameters for the `%create_livy_session` command:

| Parameter | Type | Description |
|------------------------------|----------|--------------------------------------------|
| `--cluster` | `string` | {{ dataproc-name }} cluster ID or name |
| `--id` | `string` | Session ID, arbitrary string. If omitted, it is generated automatically. |
| `--conf` | `string` | Spark configuration properties |
| `--proxyUser` | `string` | {{ dataproc-name }} cluster OS username on behalf of which the job will be run. The default value is `spark`. |
| `--jars` | `string` | Java libraries to be used in the session |
| `--files` | `string` | Files to be used in the session |
| `--pyFiles` | `string` | Python files to be used in the session |
| `--driverMemory` | `string` | Driver memory capacity |
| `--driverCores` | `int` | Number of driver cores |
| `--executorMemory` | `string` | Worker memory capacity |
| `--executorCores` | `int` | Number of worker cores |
| `--numExecutors` | `int` | Number of workers |
| `--archives` | `string` | Archives to be used in the session |
| `--queue` | `string` | YARN queue name |
| `--variables` | `string` | Variables to be used in the session |
| `--return_variables` | `string` | Variables to be returned by the session |
| `--heartbeatTimeoutInSecond` | `int` | Timeout before the session ends |
| `--ttl` | `string` | Inactive session timeout |

For more information about livy session parameters, see the [official documentation](https://livy.incubator.apache.org/docs/latest/rest-api.html).
