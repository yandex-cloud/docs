# Spark jobs

{{ dataproc-name }} supports [Spark](https://spark.apache.org/docs/latest/sql-programming-guide.html) job run in Spark _applications_.

## Application management {#applications}

Multiple applications can be running in a cluster simultaneously. A running application is orchestrated by a special _driver_ program. The driver can run in one of the following modes:

* On a cluster node (`deploy-mode=cluster`).
* Separately from a cluster (`deploy-mode=client`).

For more information about driver deployment modes, see the [Apache Spark documentation](https://spark.apache.org/docs/latest/running-on-yarn.html#launching-spark-on-yarn).

An application can be in standby mode or run _jobs_. By default, jobs within an application are run on the first in first out (_FIFO_) basis. This method does not require any additional setup.

To enable multiple parallel jobs, switch the scheduler to the _FAIR_ mode and additionally set up the system and specific jobs. For more information about how to do this, see the [Apache Spark documentation](https://spark.apache.org/docs/latest/job-scheduling.html#scheduling-within-an-application).

{% note tip %}

To execute jobs in parallel with no FAIR scheduling, run them in different Spark applications in the FIFO mode.

{% endnote %}

## Task management {#tasks}

Each Spark job consists of multiple _tasks_ that are run by specific processes called _executors_. Each executor is run on a single cluster node and consumes a certain amount of computing resources, such as CPU and RAM.

Depending on the execution plan, tasks can be run either one by one or concurrently. Concurrent tasks are grouped into _stages_. The number of tasks that can be running simultaneously depends on requests and available cluster resources.

If standard {{ dataproc-name }} settings are used, computing resources required to run Spark jobs are allocated dynamically. To set the amount of computing resources manually, provide the following settings to Spark when running an application:

* For the entire application: `spark.driver.cores` and `spark.driver.memory`.
* For each standalone executor: `spark.executor.cores` and `spark.executor.memory`.

## Useful links {#see-also}

The Apache Spark documentation provides detailed information about:

* [Spark application configuration](https://spark.apache.org/docs/latest/configuration.html).
* [Spark application resource allocation](https://spark.apache.org/docs/latest/running-on-yarn.html#resource-allocation-and-configuration-overview).

To check how Spark applications are running in a {{ dataproc-name }} cluster, [monitor the state of Spark applications](../operations/spark-monitoring.md).

If a Spark application is slow, run [primary performance diagnostics](../operations/spark-diagnostics.md#diagnostics).
