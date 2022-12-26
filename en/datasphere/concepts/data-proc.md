# Computing on Apache Spark™ clusters in {{ ml-platform-name }}

{{ dataproc-full-name }} lets you deploy Apache Spark™ clusters. You can use {{ dataproc-name }} clusters to run distributed training on them. {{ ml-platform-name }} supports sessions created by [Apache Livy](https://livy.apache.org/).

## Cluster deployment options {#types}

There are two ways to deploy a cluster for computations in {{ ml-platform-name }}:
* Create a cluster in {{ ml-platform-name }} using a special resource called a [{{ dataproc-name }} template](data-proc-template.md).
* Create a cluster in [{{ dataproc-full-name }}](../../data-proc/) on your own and integrate it into your {{ ml-platform-name }} project.

Regardless of the deployment option, all {{ dataproc-name }} clusters are charged based on the [{{ dataproc-full-name }} pricing policy](../../data-proc/pricing.md). To view all the clusters available in your project, open **Project resources** ⟶ ![data-proc-template](../../_assets/datasphere/data-proc-template.svg) **{{ dataproc-name }}** on the project page.

### {{ dataproc-name }} templates {#template}

In a {{ dataproc-name }} template, you select one of the preset cluster configurations. Based on the {{ dataproc-name }} template activated in the project, {{ ml-platform-name }} deploys a temporary cluster using the appropriate project parameters.

{{ ml-platform-name }} monitors how temporary clusters are running. If the cluster isn't used for computations during two hours, {{ ml-platform-name }} stops it. You can redeploy the cluster in your project as needed. You can also share {{ dataproc-name }} templates with other users.

[Learn more about {{ dataproc-name }} templates](../operations/data-proc-template.md).

### Integration with {{ dataproc-full-name }} {#clusters}

If you have experience using [{{ dataproc-full-name }}](../../data-proc/) or the standard template configurations are not well-suited, you can deploy a cluster and use it for computing in {{ ml-platform-name }}.

{% note warning %}

Using the cluster deployed in {{ dataproc-name }}, you manage its lifecycle on your own. Even if there have been no computations for more than two hours, the cluster keeps running and you'll pay for it until you stop it.

{% endnote %}

To ensure proper integration with {{ ml-platform-name }}, make sure the [image version](../../data-proc/concepts/environment.md) of the deployed {{ dataproc-name }} cluster is at least `1.3` and the following services are enabled: `LIVY`, `SPARK`, `YARN`, and `HDFS`.

## Setting up a {{ ml-platform-name }} project to work with {{ dataproc-name }} clusters {#settings}

{% include [preferences](../../_includes/datasphere/settings-for-dataproc.md) %}

## Computing sessions {#session}

{% include [dataproc](../../_includes/datasphere/dataproc-sessions.md) %}

### Running Python code in a cluster {#run-code}

Code is run in cells with the header:

```
#!spark [--cluster <cluster>] [--session <session>] [--variables <variable>]
```

Where:

* `<cluster>` is the Data Proc cluster to perform calculations on. This can be:
   * The name of the cluster created through the notebook interface.
   * An HTTP link to the internal IP address of the `masternode` host, like `http://10.0.0.8:8998/`.
* `<session>` is the computing session ID. If this parameter is omitted, the default {{ dataproc-name }} cluster session is used.
* `<variable>` is the variable imported to the cell from the core. Supported types: `bool`, `int`, `float`, `str`, and `pandas.DataFrame` (converted to Spark DataFrame).

### Working with the Spark SQL library {#sql}

{{ ml-platform-name }} supports the Spark SQL library. For example, the query below will return all records in the `animals` table created in the `cluster test-dataproc-cluster`:

```python
#!spark --cluster test-dataproc-cluster
df = spark.sql("SELECT * FROM animals;")
df.show()
```

For more information about the SQL query syntax and how to use the Spark SQL library, see the [official documentation](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select.html).

#### See also {#see-also}

* [{#T}](data-proc-template.md).
* [{#T}](../tutorials/data-proc-integration.md).