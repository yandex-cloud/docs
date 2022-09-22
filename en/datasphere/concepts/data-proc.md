# Integration with Apache Spark™

{{ ml-platform-name }} integration with {{ dataproc-full-name }} lets you perform calculations on Apache Spark™ clusters. Calculations are performed in sessions created by [Apache Livy](https://livy.apache.org/).

## {{ dataproc-name }} cluster {#cluster}

You can use an existing cluster from your subnet or create a new one. To ensure proper integration, you need to [set up](#settings) a project and [assign roles](#roles).

### Setting up a {{ ml-platform-name }} project to work with {{ dataproc-name }} clusters {#settings}

To be able to create {{ dataproc-name }} clusters from {{ ml-platform-name }} or run existing {{ dataproc-name }} clusters, specify the following for the project:
* The service account for performing operations with {{ dataproc-name }} clusters.
* The subnet to create a new cluster in or connect an existing {{ dataproc-name }} cluster from. The integration only supports subnets created in the `{{ region-id }}-a` availability zone.

The above parameters should be [specified in additional project settings](../operations/data-proc-integration.md#settings).

{% include [subnet-create](../../_includes/subnet-create.md) %}

### Roles required for {{ dataproc-name }} clusters to run correctly {#roles}

* To create a {{ dataproc-name }} cluster, you need permission for the service account that {{ ml-platform-name }} will use to perform operations. This permission is included in the `iam.serviceAccounts.user` and `editor` roles and higher.
* To manage {{ dataproc-name }} clusters, the service account needs the following roles:
   * `datasphere.admin` to create resources in {{ ml-platform-name }}.
   * `vpc.user` to access the network specified in the project settings.
   * `mdb.admin` to create and use {{ dataproc-name }} clusters.
   * `mdb.dataproc.agent` to create and use {{ dataproc-name }} clusters.

Read more about [access management](../security/index.md).

### Creating a cluster from a project in {{ ml-platform-name }} {#notebook}

Specifics of a cluster created from a {{ ml-platform-name }} project:
* The cluster is created in the project folder and the subnet specified in the project settings.
* {{ ml-platform-name }} monitors the lifetime of a cluster and automatically deletes it if it's idle for two hours.

   A {{ dataproc-name }} cluster is considered active if computations are being performed or if there is an active notebook in the cluster project. A notebook is considered active if the break in computing is less than 20 minutes.

Learn more about [how to create a cluster from a project](../operations/data-proc-integration.md#notebook).

### Creating a cluster in {{ dataproc-name }} {#service}

Specifics of a cluster created in {{ dataproc-name }}:
* You control the life cycle of your cluster.
* For a {{ dataproc-name }} cluster to run correctly, make sure its version is at least `1.3` and the following services are enabled: `LIVY`, `SPARK`, `YARN`, and `HDFS`.

Learn more about [how to create a cluster in the service](../operations/data-proc-integration.md#console).

## Computing sessions {#session}

In {{ dataproc-name }} clusters, your code is executed in sessions. A session stores the intermediate state until you delete the session or cluster. Each cluster has a default session. Its ID is the same as the project ID.

Use the following commands to manage sessions:
* `%create_livy_session --host $host --id $id` to create a session.
* `%delete_livy_session $id` to delete a session.

### Running Python code {#run-code}

Code is run in cells with the header:

```
#!spark [--cluster <cluster>] [--session <session>] [--variables <variable>].
```

Where:

* `<cluster>` is the Data Proc cluster to perform calculations on. This can be:
   * An HTTP link to Livy, such as `http://10.0.0.8:8998/`.
   * The name of the cluster created through the notebook interface.
   * A {{ dataproc-name }} cluster from the project settings in the management console if the parameter is omitted.
* `<session>` is the computing session ID. If this parameter is omitted, the default {{ dataproc-name }} cluster session is used.
* `<variable>` is the variable imported to the cell from the core. Supported types: `bool`, `int`, `float`, `str`, and `pandas.DataFrame` (converted to Spark DataFrame).