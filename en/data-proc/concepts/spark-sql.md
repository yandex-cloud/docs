# Spark jobs

{{ dataproc-name }} supports [Spark](https://spark.apache.org/docs/latest/sql-programming-guide.html) jobs run in Spark _applications_. When running Spark jobs, resource allocation is handled by [Apache Hadoop YARN](https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/YARN.html).

## Application management {#applications}

A single cluster may run multiple applications concurrently. A running application is orchestrated by a special _driver_ program. To learn how Spark drivers work, see the [Resource allocation](#resource-management) section.

An application can either be in standby mode or run _jobs_. By default, jobs within an application are run on the first in first out (_FIFO_) basis. This method does not require any additional setup.

To enable concurrent jobs, switch the scheduler to the _FAIR_ mode and additionally set up the system and specific jobs. To learn how to do this, see the [Apache Spark documentation](https://spark.apache.org/docs/latest/job-scheduling.html#scheduling-within-an-application).

{% note tip %}

To run concurrent jobs without FAIR scheduling, you can run them in different Spark applications in the FIFO mode.

{% endnote %}

## Task management {#tasks}

Each Spark job consists of multiple _tasks_ run by specific processes called _executors_. Each executor is run on a single cluster host and consumes a certain amount of computing resources, such as CPU and RAM.

Depending on the execution plan, tasks can be run either one by one or concurrently. Concurrent tasks are grouped into _stages_. The number of tasks that can be running concurrently depends on requests and available cluster resources.

If you use standard {{ dataproc-name }} settings, computing resources required to run Spark jobs are allocated dynamically.

## Resource allocation {#resource-management}

A Spark application running on a {{ dataproc-name }} cluster includes a number of processes running on the cluster nodes. Contents of the application's processes, their location, and the amount of the computing resources reserved depend on the Spark [component properties](./settings-list.md).

Spark applications managed by the YARN resource manager support two possible deploy modes you set using the `spark:spark.submit.deployMode` property:

* In `deployMode=cluster` mode, the driver runs inside the application's main process managed by YARN (YARN Application Master process), so the client can terminate its operation once the application is started successfully.
* In `deployMode=client` mode, the driver runs directly within the client process, while the YARN Application Master is used only for interaction with YARN (e.g., to get resources).

In both modes, the YARN Application Master runs on one of the compute hosts within the `compute` or `data` subcluster.

If the cluster meets the requirements for [lightweight clusters](./index.md#light-weight-clusters), the `deployMode=client` mode is used by default. Otherwise, the default mode is `deployMode=cluster`.

Resources are allocated between the driver and the executors based on the Spark [component properties](./settings-list.md). The tables below list the key properties that determine resource allocation in different deploy modes.

These tables use the following abbreviations:

* `allCPU`: Number of host cores. This property is determined by the host class selected while creating the subcluster.
* `nmMem`: Host RAM available to YARN NodeManager. This property is calculated using the following formula:

    `total host RAM` × `RAM share allocated for YARN NodeManager`

    * Total host RAM is based on the host class selected when creating the subcluster.
    * You can set the RAM reserved for YARN NodeManager using the `dataproc:nodemanager_available_memory_ratio` property. By default, it is set to `0.8`. The remaining RAM is reserved for auxiliary load (sending logs and metrics, file system cache, etc.).

In the tables, results of arithmetic operations are rounded:

* For CPU, results are rounded down to the nearest integer. If the result of a division is less than 1, it is rounded up to 1.
* For RAM, results are rounded down to the nearest multiple of 1 GB.

{% list tabs %}

- deployMode=client

    In this mode, the driver runs on the cluster's master host separately from the YARN Application Master and can access all resources of the master host. The YARN Application Master runs in a separate YARN container on a compute host. However, only the required small amount of resources is reserved for its operation.

    #|
    || **Property (abbreviation)**                    | **Description**                                                       | **Default value**        ||
    || `dataproc:spark_executors_per_vm` (`numCon`) | Maximum number of containers per computing host  | `1`                              ||
    || `spark:spark.yarn.am.cores` (`yamCPU`)       | Number of CPU cores allocated to YARN Application Master | `1`                              ||
    || `spark:spark.yarn.am.memory` (`yamMem`)      | Memory size (MB) allocated to YARN Application Master          | `1024`                           ||
    || `spark:spark.executor.cores` (`exCPU`)       | Number of processor cores allocated to each executor     | (`allCPU` − `yamCPU`) / `numCon` ||
    || `spark:spark.executor.memory` (`exMem`)      | Memory size (MB) allocated to each executor               | (`nmMem` − `yamMem`) / `numCon`  ||
    |#

    `yamCPU` and `yamMem` being subtracted from the total CPU and RAM, respectively, the YARN Application Master takes up less resources than a standard container, thus increasing the share of resources available for executors.

- deployMode=cluster

    This mode assumes that a resource-intensive program, e.g., HDFS, is running on the cluster's master host. Consequently, the drivers run on compute hosts within the YARN Application Master and are allocated a substantial amount of resources.

    #|
    || **Property (abbreviation)**                          | **Description**                                                        | **Default value**     ||
    || `dataproc:spark_driver_memory_fraction` (`drMemF`) | Share of compute host memory reserved for the driver       | `0.25`                        ||
    || `dataproc:spark_executors_per_vm` (`numCon`)       | Maximum number of containers per computing host   | `2`                           ||
    || `spark:spark.executor.cores` (`exCPU`)             | Number of processor cores allocated to each executor      | `allCPU` / `numCon`           ||
    || `spark:spark.executor.memory` (`exMem`)            | Memory size (MB) allocated to each executor                | `nmMem` / `numCon`            ||
    || `spark:spark.driver.cores` (`drCPU`)               | Number of CPU cores allocated to YARN Application Master  | `allCPU` / `numCon`           ||
    || `spark:spark.driver.memory` (`drMem`)              | Memory size (MB) allocated to YARN Application Master           | `drMemF` × `nmMem` / `numCon` ||
    |#

{% endlist %}

The default values set in the service are optimal for running a single app. To optimize resource allocation for your needs, change the driver deployment mode and other component properties:

* For all new jobs in a cluster:

    * When [creating a cluster](../operations/cluster-create.md).
    * When [updating a cluster](../operations/cluster-update.md).

* For an individual job, during its [creation](../operations/jobs-spark.md#create).

### Resource allocation examples {#examples}

A single app runs on a cluster with default settings and two compute hosts. In this case:

{% list tabs %}

- deployMode=client

    * The driver can take up all the master host's resources.
    * The amount of resources available for executors on all compute hosts will be reduced by the amount reserved for the YARN Application Master.
    * The resources reserved for the YARN Application Master on the second host will remain unused.

    ![lightweight-load](../../_assets/data-processing/lightweight-load.svg)

- deployMode=cluster

    * The master host may be running HDFS or another resource-intensive program.
    * The YARN Application Master and the driver will take up a substantial portion of the resources on one of the compute hosts, but no more than the size of the container for the executors. Because of this, some resources may remain unused.
    * On the second compute host, both containers will be allocated to the executors.

    ![heavyweight-load](../../_assets/data-processing/heavyweight-load.svg)

{% endlist %}


## Automatic scaling {#autoscaling}

Automatic scaling in {{ dataproc-name }} clusters allows you to automatically manage computing resources of the created cluster by adding more nodes to the cluster when you have pending operations in the execution queue or by releasing nodes (deleting the corresponding VMs) when the cluster load is lower.

When the load drops below a specified threshold, the automatic scaling function deletes one or multiple cluster nodes. These nodes may host processes of Spark jobs. For stable operation of Apache Spark jobs in clusters with automatic scaling, you must meet the following conditions:

1. Repeated executions must be permitted for operations within a Spark job.
1. Processes of the YARN Application Master and Spark job drivers must be located on hosts without automatic scaling (i.e., not to be automatically decommissioned).

To configure repeated operations, you need to set up the `spark:spark.task.maxFailures` parameter at the job level or the overall cluster level. This parameter defines how many errors you can get for an individual operation until the whole job is aborted. We recommend using the default value of `4`, which means three possible retries in the event of consecutive errors executing a specific operation within a job.

Forced termination of YARN Application Master processes and Spark job driver processes results in immediate abnormal termination of the entire job, so you should locate these processes on hosts not controlled by the autoscaling mechanism. HDFS nodes (a subcluster of nodes with the *Data Node* role) or an additional subcluster of compute nodes (with the *Compute Node* role) with disabled automatic scaling can serve as such nodes.

### YARN settings for automatic scaling {#autoscaling-yarn}

You can use node labels set using the YARN resource manager tools together with [Hadoop Capacity Scheduler](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html) to place YARN Application Master containers on the selected nodes. Usually, an initialization script sets the node labels by analyzing the subcluster name and invoking the required YARN commands to set a label. For Spark jobs, the `spark.yarn.am.nodeLabelExpression` parameter must contain the name of the created label, and the cluster must have at least one node with this label.

Below is an example of the initialization script for analyzing the subcluster name and setting a YARN label to nodes of such subcluster. The script accepts one command line argument, the name of the subcluster to label.

```bash
#! /bin/sh
set -e
set +u
NAME_TO_LABEL="$1"

# Loading the JQ and YQ utilities to analyze the VM metadata.
wget -q -O - https://mycop1.website.yandexcloud.net/utils/jq.gz | gzip -dc >/tmp/jq
wget -q -O - https://mycop1.website.yandexcloud.net/utils/yq.gz | gzip -dc >/tmp/yq
mv /tmp/jq /usr/local/bin/
mv /tmp/yq /usr/local/bin/
chown root:bin /usr/local/bin/jq /usr/local/bin/yq
chmod 555 /usr/local/bin/jq /usr/local/bin/yq

# Checking if labeling is required.
MUSTLABEL=N
if [ ! -z "$NAME_TO_LABEL" ]; then
  # Getting the subcluster name from the VM metadata.
  curl --header Metadata-Flavor:Google 'http://169.254.169.254/computeMetadata/v1/instance/?alt=json&recursive=true' --output /tmp/host-meta.json
  jq -r .attributes.'"user-data"' /tmp/host-meta.json >/tmp/host-userdata.yaml
  subcid=`jq -r '.vendor.labels.subcluster_id' /tmp/host-meta.json`
  subname=`yq -r ".data.topology.subclusters.${subcid}.name" /tmp/host-userdata.yaml`
  if [ "${subname}" = "${NAME_TO_LABEL}" ]; then
    # The subcluster name matches the configured one.
    MUSTLABEL=Y
  fi
fi

if [ "${MUSTLABEL}" = "Y" ]; then
  MYHOST=`hostname -f`
  while true; do
    # Checking if there is a label in the cluster.
    foundya=`sudo -u yarn yarn cluster --list-node-labels 2>/dev/null | grep -E '^Node Labels' | grep '<SPARKAM:' | wc -l | (read x && echo $x)`
    if [ $foundya -gt 0 ]; then
      break
    fi
    # If there is no label, create it at the cluster level.
    sudo -u yarn yarn rmadmin -addToClusterNodeLabels 'SPARKAM' || true
    sleep 2
  done
  # Setting a label to the current node.
  sudo -u yarn yarn rmadmin -replaceLabelsOnNode "${MYHOST}=SPARKAM"
fi
```

### Spark settings for automatic scaling {#autoscaling-spark}

The table below provides the typical Spark parameters for a {{ dataproc-name }} cluster with automatic scaling.

#|
|| **Parameter=value**  | **Description of use** ||
|| `spark:`
`spark.task.maxFailures=`
`4`  | Number of consecutive errors allowed per a Spark job step ||
|| `spark:`
`spark.yarn.am.nodeLabelExpression=`
`SPARKAM`  | Label name for selecting nodes to run AM containers of Spark jobs ||
|| `spark:`
`spark.submit.deployMode=`
`cluster` | Default mode for Spark jobs (used if there is no relevant setting at job or particular service level) ||
|| `livy:`
`livy.spark.deploy-mode=`
`cluster`  | Spark job run mode used in Apache Livy sessions ||
|| `yarn:`
`yarn.node-labels.enabled=`
`true` | Enabling support for node labels in YARN ||
|| `yarn:`
`yarn.node-labels.fs-store.root-dir=`
`file:///hadoop/yarn/node-labels` | Folder for storing node labels in the file system of the cluster's master node ||
|| `yarn:`
`yarn.node-labels.configuration-type=`
`centralized` | YARN node label management mode ||
|| `capacity-scheduler:`
`yarn.scheduler.capacity.maximum-am-resource-percent=`
`1.00` | Maximum share of resources (`0.0` to `1.0`) for the execution of Application Master containers ||
|| `capacity-scheduler:`
`yarn.scheduler.capacity.root.`
`default.accessible-node-labels=`
`SPARKAM` | Allow jobs in the `default` queue to use nodes with specified labels ||
|| `capacity-scheduler:`
`yarn.scheduler.capacity.root.`
`accessible-node-labels.SPARKAM.capacity=`
`100` | Set the allowed percentage of using the `SPARKAM` labeled nodes to 100% ||
|| `capacity-scheduler:`
`yarn.scheduler.capacity.root.`
`default.accessible-node-labels.SPARKAM.capacity=`
`100` | Set the allowed percentage of the `SPARKAM` labeled nodes used by the `default` queue jobs to 100% ||
|#

## Useful links {#see-also}

The Apache Spark documentation provides detailed information about:

* [Spark application configuration](https://spark.apache.org/docs/latest/configuration.html)
* [Spark driver operation modes](https://spark.apache.org/docs/latest/running-on-yarn.html#launching-spark-on-yarn)
* [Spark application resource allocation](https://spark.apache.org/docs/latest/running-on-yarn.html#resource-allocation-and-configuration-overview)

What else you can find in the Apache Hadoop documentation:

* [Working with YARN node labels](https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/NodeLabel.html)
* [Configuring *Capacity Scheduler*](https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html)

To check how Spark applications are running in a {{ dataproc-name }} cluster, [run Spark application monitoring](../operations/spark-monitoring.md).

If a Spark application is slow, run [primary performance diagnostics](../operations/spark-diagnostics.md#diagnostics).
