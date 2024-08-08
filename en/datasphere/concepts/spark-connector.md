# Spark connector

{{ ml-platform-name }} allows processing large amounts of data on [{{ dataproc-full-name }}](../../data-proc/) clusters. With a Spark connector, you can either use existing {{ dataproc-name }} clusters or create temporary clusters.

The Spark connector is a special resource that stores connection and interaction settings for [existing and temporary](./data-proc.md#types) {{ dataproc-name }} clusters. The selected clusters are automatically connected or created when you start computing in the IDE. When creating a resource, you can also specify data for connection to the S3 object storage.

## Information about a Spark connector as a resource {#info}

The following information is stored for each Spark connector:

* Unique resource ID.
* Resource creator.
* Date when the resource was created and last modified, in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format, e.g., `April 22, 2024, 13:21`.
* {{ dataproc-name }} cluster configuration.
* Settings for connecting to S3.

## Working with a Spark connector {#work}

You can [create](../operations/data/spark-connectors.md) a Spark connector in the [{{ ml-platform-name }} interface]({{ link-datasphere-main }}). When creating a Spark connector, you can choose the type of connection to an existing {{ dataproc-name }} cluster: SparkContext or Spark Connect (available only for {{ dataproc-name }} clusters version 2.2 or older). The SparkContext connection is used for temporary clusters.

Spark connectors are used in the project notebooks. When first running computations, you select the [configuration](./configurations.md) on which the notebook code will run. This VM resides on the network specified in the Spark connector, so it has network access to the {{ dataproc-name }} cluster but does not belong to it. The VM environment for working with the cluster differs from the {{ ml-platform-name }} [standard environment](./preinstalled-packages.md) and allows accessing the {{ dataproc-name }} cluster environment. You can also use [sessions](./data-proc.md#session) to work with the cluster.

Once created, the Spark connector becomes available for the project. Like any other resource, you can publish the Spark connector in the community to use it in other projects. To do this, you need at least the `Editor` role in the project and the `Developer` role in the community in which you want to publish it. You can open the access on the **{{ ui-key.yc-ui-datasphere.common.access }}** tab on the Spark connector view page. The resource available to the community will appear on the community page under **{{ ui-key.yc-ui-datasphere.spaces-page.community-resources }}**.

If you chose a temporary {{ dataproc-name }} cluster when creating the Spark connector, {{ ml-platform-name }} will create a {{ dataproc-name }} cluster the first time you run computations in your notebook and will monitor it on its own. The cluster will be deleted if there are no computations on it for the period of time specified in the **{{ ui-key.yc-ui-datasphere.edit-project-page.dedicated-vm-inactivity-timeout }}** parameter, or if the notebook's VM is forced to stop.

### Configurations of temporary clusters {#configurations}

Temporary {{ dataproc-name }} clusters are deployed on [{{ compute-full-name }} VMs](../../compute/concepts/vm.md) powered by Intel Cascade Lake (`standard-v2`).

You can calculate the total disk storage capacity required for different cluster configurations using this formula:

```
<number_of_Data_Proc_hosts> × 256 + 128
```

| Cluster type | Number of hosts | Disk size | Host parameters |
|:------------:|:-----------------:|--------------|------------------- |
| **XS** | 1 | 384 GB HDD | 4 vCPUs, 16 GB RAM |
| **S** | 4 | 1152 GB SSD | 4 vCPUs, 16 GB RAM |
| **M** | 8 | 2176 GB SSD | 16 vCPUs, 64 GB RAM |
| **L** | 16 | 4224 GB SSD | 16 vCPUs, 64 GB RAM |
| **XL** | 32 | 8320 GB SSD | 16 vCPUs, 64 GB RAM |

{% note tip %}

Before running a project with the Spark connector to create a temporary {{ dataproc-name }} cluster, make sure the [quotas]({{ link-console-quotas }}) for creating HDDs or SSDs allow you to create a disk of a sufficient size.

{% endnote %}

You will be charged additionally for running temporary clusters created based on {{ dataproc-name }} templates according to the [{{ dataproc-full-name }} pricing policy](../../data-proc/pricing.md).


#### See also {#see-also}

* [How to create, modify, and delete a Spark connector](../operations/data/spark-connectors.md).