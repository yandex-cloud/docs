In {{ dataproc-name }} clusters, your code is running in [sessions](https://livy.incubator.apache.org/docs/latest/rest-api.html#session). The session stores intermediate results until you delete it or shut down the cluster. Each cluster has a default session. The session ID is the same as the project ID.

Use the following commands to manage sessions:
* `%create_livy_session --cluster <cluster_name> --id <session_ID>`: Creating a session.
* `%delete_livy_session --cluster <cluster_name> --id <session_ID>`: Deleting a session.

For example, the command below creates a session named `ses1` in `my-new-cluster`, which allows each process to use a maximum of 4 CPUs per cluster and 4 GB of RAM (for more information, see [these Spark articles](https://spark.apache.org/docs/latest/configuration.html)):

```python
%create_livy_session --cluster my-new-cluster --id ses1 --conf spark.cores.max=4 --conf spark.executor.memory=4g
```

Dynamic resource allocation is enabled in sessions by default. To limit the session's resources, set `--conf spark.dynamicAllocation.enabled=false`.

### Livy session parameters {#parameters}

Complete list of parameters for the `%create_livy_session` command:

| Parameter                     | Type      | Description                                   |
|------------------------------|----------|--------------------------------------------|
| `--cluster`                  | `string` | {{ dataproc-name }} cluster ID or name |
| `--id`                       | `string` | Session ID, any string. If not set, the system will generate it automatically. |
| `--conf`                     | `string` | Spark configuration properties                |
| `--proxyUser`                | `string` | {{ dataproc-name }} cluster OS username that will be used to run the job. The default value is `spark`. |
| `--jars`                     | `string` | Java libraries to use in the session |
| `--files`                    | `string` | Files to use in the session           |
| `--pyFiles`                  | `string` | Python files to use in the session    |
| `--driverMemory`             | `string` | Driver memory                      |
| `--driverCores`              | `int`    | Number of driver cores               |
| `--executorMemory`           | `string` | Worker memory          |
| `--executorCores`            | `int`    | Number of worker cores      |
| `--numExecutors`             | `int`    | Number of workers          |
| `--archives`                 | `string` | Archives to use in the session          |
| `--queue`                    | `string` | YARN queue name                      |
| `--variables`                | `string` | Variables to use in the session      |
| `--return_variables`         | `string` | Variables to return by the session  |
| `--heartbeatTimeoutInSecond` | `int`    | Time to wait for heartbeat before the session ends     |
| `--ttl`                      | `string` | Inactive session timeout          |

For more information about livy session parameters, see [this Apache Livy article](https://livy.incubator.apache.org/docs/latest/rest-api.html).
